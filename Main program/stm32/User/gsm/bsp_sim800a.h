#ifndef __BSP_SIM800A_H
#define __BSP_SIM800A_H

#include "stm32f1xx_hal.h"
#include <stdint.h>

/* SIM800A —— USART2: PA2=TX  PA3=RX（与板载 EEPROM 共用引脚，本工程弃用 EEPROM） */
#define SIM800A_UART        USART2
#define SIM800A_BAUDRATE    115200

/* PWRKEY 上电：PC1（注意需拔掉板载 VAR/BEEP 跳线帽释放 PC1） */
#define SIM800A_PWRKEY_PORT  GPIOC
#define SIM800A_PWRKEY_PIN   GPIO_PIN_1

#define SIM800A_RX_BUF_SIZE  512
#define SIM800A_LINE_MAX     128

extern UART_HandleTypeDef hsim800a;

/* 事件标志（主循环 SIM800A_Poll 消费） */
#define GSM_FLAG_RING     0x01u   /* 来电 +CLIP */
#define GSM_FLAG_SMS      0x02u   /* 新短信 +CMTI */
#define GSM_FLAG_READY    0x04u   /* Call Ready / 网络注册 */

void    SIM800A_UartInit(void);
void    SIM800A_PowerOn(void);
uint8_t SIM800A_SendCmd(const char *cmd, char *resp, uint16_t resp_size, uint32_t timeout_ms);
uint8_t SIM800A_ReadLine(char *line, uint16_t max_len, uint32_t timeout_ms);
uint8_t SIM800A_Poll(uint8_t *events);

#endif /* __BSP_SIM800A_H */
