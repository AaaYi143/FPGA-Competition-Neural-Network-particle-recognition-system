/**
 * @file    instr_capture.c
 * @brief   Sampling engine. Oscilloscope: TIM3 update -> TRGO paces ADC1 via
 *          DMA1_Ch1 in circular mode (CPU only reads the live ring). Logic
 *          analyzer: TIM2 update IRQ packs 4 GPIO bits into one byte/sample.
 *          No HAL MspInit overrides: clocks/GPIO/NVIC are set here explicitly.
 */
#include "./instr/instr_capture.h"
#include "stm32f1xx_hal.h"

/* ============ oscilloscope: ADC1 on PA1, TIM3 TRGO, DMA1_Ch1 ============ */
#define ADC_TIM         TIM3
#define ADC_TIM_CLK     72000000u        /* APB1 timer clock = 2x APB1 (36 MHz) */

static ADC_HandleTypeDef s_hadc;
static DMA_HandleTypeDef s_hdma_adc;
static TIM_HandleTypeDef s_htim3;
static uint16_t          s_adc_buf[INSTR_ADC_BUF_LEN];
static volatile uint8_t  s_adc_running;

/* ============ logic analyzer: 4ch on GPIOA, TIM2 update IRQ ============ */
#define LA_PORT     GPIOA
#define LA_PIN_MASK (GPIO_PIN_0 | GPIO_PIN_11 | GPIO_PIN_12 | GPIO_PIN_15)
#define LA_TIM      TIM2
#define LA_TIM_CLK  72000000u

static const uint8_t     s_la_shift[INSTR_LA_CHANNELS] = {0, 11, 12, 15};
static TIM_HandleTypeDef s_htim2;
static volatile uint8_t  s_la_buf[INSTR_LA_BUF_LEN];
static volatile uint16_t s_la_wr;

/* ------------------------------------------------------------------ */
void InstrAdc_Init(void)
{
    GPIO_InitTypeDef gpio = {0};

    __HAL_RCC_ADC1_CLK_ENABLE();
    __HAL_RCC_DMA1_CLK_ENABLE();
    __HAL_RCC_TIM3_CLK_ENABLE();
    __HAL_RCC_GPIOA_CLK_ENABLE();
    __HAL_RCC_ADC_CONFIG(RCC_ADCPCLK2_DIV6);    /* ADCCLK = 72 / 6 = 12 MHz */

    gpio.Pin  = GPIO_PIN_1;                      /* PA1 = ADC1_IN1 */
    gpio.Mode = GPIO_MODE_ANALOG;
    HAL_GPIO_Init(GPIOA, &gpio);

    s_htim3.Instance               = TIM3;
    s_htim3.Init.Prescaler         = 0;
    s_htim3.Init.CounterMode       = TIM_COUNTERMODE_UP;
    s_htim3.Init.Period            = 143;        /* 72 MHz / 144 = 500 kHz */
    s_htim3.Init.ClockDivision     = TIM_CLOCKDIVISION_DIV1;
    s_htim3.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
    HAL_TIM_Base_Init(&s_htim3);

    TIM_MasterConfigTypeDef master = {0};
    master.MasterOutputTrigger = TIM_TRGO_UPDATE;
    master.MasterSlaveMode     = TIM_MASTERSLAVEMODE_DISABLE;
    HAL_TIMEx_MasterConfigSynchronization(&s_htim3, &master);

    s_hadc.Instance                   = ADC1;
    s_hadc.Init.DataAlign             = ADC_DATAALIGN_RIGHT;
    s_hadc.Init.ScanConvMode          = ADC_SCAN_DISABLE;
    s_hadc.Init.ContinuousConvMode    = DISABLE;
    s_hadc.Init.DiscontinuousConvMode = DISABLE;
    s_hadc.Init.ExternalTrigConv      = ADC_EXTERNALTRIGCONV_T3_TRGO;
    s_hadc.Init.NbrOfConversion       = 1;
    s_hadc.Init.NbrOfDiscConversion   = 1;
    HAL_ADC_Init(&s_hadc);
    HAL_ADCEx_Calibration_Start(&s_hadc);

    ADC_ChannelConfTypeDef ch = {0};
    ch.Channel      = ADC_CHANNEL_1;
    ch.Rank         = ADC_REGULAR_RANK_1;
    ch.SamplingTime = ADC_SAMPLETIME_1CYCLE_5;   /* assumes <1k source (front-end) */
    HAL_ADC_ConfigChannel(&s_hadc, &ch);

    s_hdma_adc.Instance                 = DMA1_Channel1;
    s_hdma_adc.Init.Direction           = DMA_PERIPH_TO_MEMORY;
    s_hdma_adc.Init.PeriphInc           = DMA_PINC_DISABLE;
    s_hdma_adc.Init.MemInc              = DMA_MINC_ENABLE;
    s_hdma_adc.Init.PeriphDataAlignment = DMA_PDATAALIGN_HALFWORD;
    s_hdma_adc.Init.MemDataAlignment    = DMA_MDATAALIGN_HALFWORD;
    s_hdma_adc.Init.Mode                = DMA_CIRCULAR;
    s_hdma_adc.Init.Priority            = DMA_PRIORITY_HIGH;
    HAL_DMA_Init(&s_hdma_adc);
    __HAL_LINKDMA(&s_hadc, DMA_Handle, s_hdma_adc);

    s_adc_running = 0;
}

void InstrAdc_SetRate(uint32_t rate_hz)
{
    uint32_t arr;
    if (rate_hz < 2000u)     rate_hz = 2000u;
    if (rate_hz > 500000u)   rate_hz = 500000u;
    arr = ADC_TIM_CLK / rate_hz;
    if (arr < 2u)     arr = 2u;
    if (arr > 65535u) arr = 65535u;
    s_htim3.Instance->ARR = arr - 1u;
}

void InstrAdc_Start(void)
{
    if (s_adc_running) return;
    HAL_TIM_Base_Start(&s_htim3);
    HAL_ADC_Start_DMA(&s_hadc, (uint32_t *)s_adc_buf, INSTR_ADC_BUF_LEN);
    s_adc_running = 1;
}

void InstrAdc_Stop(void)
{
    if (!s_adc_running) return;
    HAL_ADC_Stop_DMA(&s_hadc);
    HAL_TIM_Base_Stop(&s_htim3);
    s_adc_running = 0;
}

uint16_t InstrAdc_Sample(uint16_t i)
{
    return s_adc_buf[i & (INSTR_ADC_BUF_LEN - 1u)];
}

/* Current DMA write position = index of the next sample to be written. */
uint16_t InstrAdc_WrIndex(void)
{
    uint32_t rem = __HAL_DMA_GET_COUNTER(&s_hdma_adc);
    return (uint16_t)((INSTR_ADC_BUF_LEN - rem) & (INSTR_ADC_BUF_LEN - 1u));
}

/* ------------------------------------------------------------------ */
void InstrLa_Init(void)
{
    GPIO_InitTypeDef gpio = {0};

    __HAL_RCC_TIM2_CLK_ENABLE();
    __HAL_RCC_GPIOA_CLK_ENABLE();

    gpio.Pin  = LA_PIN_MASK;
    gpio.Mode = GPIO_MODE_INPUT;
    gpio.Pull = GPIO_PULLDOWN;
    HAL_GPIO_Init(LA_PORT, &gpio);

    s_htim2.Instance               = TIM2;
    s_htim2.Init.Prescaler         = 0;
    s_htim2.Init.CounterMode       = TIM_COUNTERMODE_UP;
    s_htim2.Init.Period            = 71;         /* 72 MHz / 72 = 1 MHz */
    s_htim2.Init.ClockDivision     = TIM_CLOCKDIVISION_DIV1;
    s_htim2.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
    HAL_TIM_Base_Init(&s_htim2);

    HAL_NVIC_SetPriority(TIM2_IRQn, 1, 0);
    HAL_NVIC_EnableIRQ(TIM2_IRQn);

    s_la_wr = 0;
}

void InstrLa_SetRate(uint32_t rate_hz)
{
    uint32_t arr;
    if (rate_hz < 100000u)   rate_hz = 100000u;
    if (rate_hz > 500000u)   rate_hz = 500000u;
    arr = LA_TIM_CLK / rate_hz;
    if (arr < 2u)     arr = 2u;
    if (arr > 65535u) arr = 65535u;
    s_htim2.Instance->ARR = arr - 1u;
}

void InstrLa_Start(void)
{
    s_la_wr = 0;
    __HAL_TIM_CLEAR_FLAG(&s_htim2, TIM_FLAG_UPDATE);
    HAL_TIM_Base_Start_IT(&s_htim2);
}

void InstrLa_Stop(void)
{
    HAL_TIM_Base_Stop_IT(&s_htim2);
}

uint8_t InstrLa_Sample(uint16_t i)
{
    return s_la_buf[i & (INSTR_LA_BUF_LEN - 1u)];
}

uint16_t InstrLa_WrIndex(void)
{
    return s_la_wr;
}

/* Logic-analyzer sample ISR: 4 bits packed into one byte per tick. */
void TIM2_IRQHandler(void)
{
    if (__HAL_TIM_GET_FLAG(&s_htim2, TIM_FLAG_UPDATE)) {
        __HAL_TIM_CLEAR_FLAG(&s_htim2, TIM_FLAG_UPDATE);
        uint32_t idr = LA_PORT->IDR;
        uint8_t  v = 0, c;
        for (c = 0; c < INSTR_LA_CHANNELS; c++) {
            if (idr & (1u << s_la_shift[c])) v |= (uint8_t)(1u << c);
        }
        s_la_buf[s_la_wr & (INSTR_LA_BUF_LEN - 1u)] = v;
        s_la_wr++;
    }
}
