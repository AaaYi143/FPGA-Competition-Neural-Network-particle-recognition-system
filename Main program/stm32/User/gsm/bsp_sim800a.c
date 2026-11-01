#include "./gsm/bsp_sim800a.h"
#include <string.h>

UART_HandleTypeDef hsim800a;

/* 接收环形缓冲 */
static uint8_t  s_rxBuf[SIM800A_RX_BUF_SIZE];
static volatile uint16_t s_rxHead = 0;   /* 写指针 */
static volatile uint16_t s_rxTail = 0;   /* 读指针 */
static uint8_t  s_rxByte;                /* 单字节中断接收缓冲 */

/* ---- 环形缓冲 ---- */
static void RxPush(uint8_t b)
{
    uint16_t next = (uint16_t)(s_rxHead + 1) % SIM800A_RX_BUF_SIZE;
    if (next != s_rxTail) {              /* 未满 */
        s_rxBuf[s_rxHead] = b;
        s_rxHead = next;
    }
    /* 满则丢弃 */
}

static uint8_t RxPop(uint8_t *b)
{
    if (s_rxHead == s_rxTail) return 0;
    *b = s_rxBuf[s_rxTail];
    s_rxTail = (uint16_t)(s_rxTail + 1) % SIM800A_RX_BUF_SIZE;
    return 1;
}

/* ---- PWRKEY 上电时序：拉低 ≥1s 再释放 ---- */
void SIM800A_PowerOn(void)
{
    GPIO_InitTypeDef g = {0};

    __HAL_RCC_GPIOC_CLK_ENABLE();
    g.Pin   = SIM800A_PWRKEY_PIN;
    g.Mode  = GPIO_MODE_OUTPUT_PP;
    g.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(SIM800A_PWRKEY_PORT, &g);

    HAL_GPIO_WritePin(SIM800A_PWRKEY_PORT, SIM800A_PWRKEY_PIN, GPIO_PIN_RESET);
    HAL_Delay(1200);
    HAL_GPIO_WritePin(SIM800A_PWRKEY_PORT, SIM800A_PWRKEY_PIN, GPIO_PIN_SET);
    HAL_Delay(2000);                     /* 等模块内部启动、搜网 */
}

/* ---- USART2 初始化（中断接收） ---- */
void SIM800A_UartInit(void)
{
    GPIO_InitTypeDef g = {0};

    /* USART2 时钟 + 引脚（PA2=TX, PA3=RX）
     * 野火的 HAL_UART_MspInit 只配了 USART1，这里手动配 USART2
     */
    __HAL_RCC_USART2_CLK_ENABLE();
    __HAL_RCC_GPIOA_CLK_ENABLE();

    g.Pin   = GPIO_PIN_2;            /* PA2 = USART2_TX */
    g.Mode  = GPIO_MODE_AF_PP;
    g.Pull  = GPIO_PULLUP;
    g.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOA, &g);

    g.Pin  = GPIO_PIN_3;             /* PA3 = USART2_RX */
    g.Mode = GPIO_MODE_AF_INPUT;
    HAL_GPIO_Init(GPIOA, &g);

    hsim800a.Instance          = SIM800A_UART;
    hsim800a.Init.BaudRate     = SIM800A_BAUDRATE;
    hsim800a.Init.WordLength   = UART_WORDLENGTH_8B;
    hsim800a.Init.StopBits     = UART_STOPBITS_1;
    hsim800a.Init.Parity       = UART_PARITY_NONE;
    hsim800a.Init.HwFlowCtl    = UART_HWCONTROL_NONE;
    hsim800a.Init.Mode         = UART_MODE_TX_RX;
    HAL_UART_Init(&hsim800a);

    __HAL_UART_ENABLE_IT(&hsim800a, UART_IT_RXNE);
    HAL_NVIC_SetPriority(USART2_IRQn, 1, 0);
    HAL_NVIC_EnableIRQ(USART2_IRQn);

    HAL_UART_Receive_IT(&hsim800a, &s_rxByte, 1);
}

/* 单字节接收完成回调：入环形缓冲并重装 */
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
    if (huart->Instance == SIM800A_UART) {
        RxPush(s_rxByte);
        HAL_UART_Receive_IT(&hsim800a, &s_rxByte, 1);
    }
}

/* USART2 中断服务（覆盖启动文件里的弱符号默认处理） */
void USART2_IRQHandler(void)
{
    HAL_UART_IRQHandler(&hsim800a);
}

/* ---- 从环形缓冲读一行（以 \n 结尾），带超时 ---- */
uint8_t SIM800A_ReadLine(char *line, uint16_t max_len, uint32_t timeout_ms)
{
    uint16_t idx = 0;
    uint8_t  b;
    uint32_t start = HAL_GetTick();

    while ((HAL_GetTick() - start) < timeout_ms) {
        while (RxPop(&b)) {
            if (b == '\n') {
                if (idx > 0 && line[idx - 1] == '\r') idx--;
                line[idx] = '\0';
                return (idx > 0) ? 1 : 0;   /* 空行返回 0 */
            }
            if (b != '\r' && idx < max_len - 1) {
                line[idx++] = b;
            }
        }
    }
    line[idx] = '\0';
    return (idx > 0) ? 1 : 0;
}

/* ---- 发送 AT 命令，等待应答，把多行应答拼进 resp ----
 * 返回 1=收到 OK/ERROR，0=超时。resp 可为 NULL（仅发送不等应答）。
 */
uint8_t SIM800A_SendCmd(const char *cmd, char *resp, uint16_t resp_size, uint32_t timeout_ms)
{
    char line[SIM800A_LINE_MAX];
    uint32_t start;

    /* 发送前清空接收缓冲，避免旧数据干扰 */
    s_rxHead = s_rxTail = 0;

    HAL_UART_Transmit(&hsim800a, (uint8_t *)cmd, (uint16_t)strlen(cmd), 1000);
    HAL_UART_Transmit(&hsim800a, (uint8_t *)"\r\n", 2, 1000);

    if (resp == NULL) return 1;

    resp[0] = '\0';
    start = HAL_GetTick();
    while ((HAL_GetTick() - start) < timeout_ms) {
        if (SIM800A_ReadLine(line, SIM800A_LINE_MAX, 50)) {
            /* 拼进 resp（带换行，便于显示） */
            if (strlen(resp) + strlen(line) + 2 < resp_size) {
                strcat(resp, line);
                strcat(resp, "\n");
            }
            if (strstr(line, "OK") || strstr(line, "ERROR")) {
                return 1;
            }
        }
    }
    return 0;
}

/* ---- 主循环轮询：解析主动上报 +CLIP / +CMTI / Call Ready ---- */
uint8_t SIM800A_Poll(uint8_t *events)
{
    static char line[SIM800A_LINE_MAX];
    static uint16_t idx = 0;
    uint8_t b, evts = 0;

    while (RxPop(&b)) {
        if (b == '\n') {
            line[idx] = '\0';
            if      (strstr(line, "+CLIP"))  evts |= GSM_FLAG_RING;
            else if (strstr(line, "+CMTI"))  evts |= GSM_FLAG_SMS;
            else if (strstr(line, "Call Ready") || strstr(line, "+CREG: 0,1")) evts |= GSM_FLAG_READY;
            idx = 0;
        } else if (b != '\r' && idx < SIM800A_LINE_MAX - 1) {
            line[idx++] = b;
        }
    }

    if (events) *events = evts;
    return evts;
}
