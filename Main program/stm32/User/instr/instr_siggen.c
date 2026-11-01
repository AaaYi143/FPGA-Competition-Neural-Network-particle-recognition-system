/**
 * @file    instr_siggen.c
 * @brief   TIM1 CH1 (PA8) 8-bit PWM + DMA2_Ch5 (TIM1_CC1 -> CCR1) = PWM DAC.
 *          TIM1 is an advanced timer -> main output (MOE) must be enabled.
 *          Output frequency = 72 MHz / ((PSC+1) * 256 * 256) with a 256-entry
 *          table and ARR=255, so the usable range is ~1 Hz .. ~1.1 kHz (8-bit).
 */
#include "./instr/instr_siggen.h"
#include "stm32f1xx_hal.h"

#define SG_TIM      TIM1
#define SG_TIM_CLK  72000000u    /* APB2 timer clock */
#define SG_PWM_MAX  255u

static TIM_HandleTypeDef s_htim1;
static DMA_HandleTypeDef s_hdma;
static uint16_t          s_table[INSTR_SG_TABLE_LEN];

/* Full-cycle 256-entry 8-bit sine (round(127.5 + 127.5*sin(2*pi*i/256))). */
static const uint8_t s_sine256[INSTR_SG_TABLE_LEN] = {
    128, 131, 134, 137, 140, 143, 146, 149, 152, 155, 158, 162, 165, 167, 170, 173,
    176, 179, 182, 185, 188, 190, 193, 196, 198, 201, 203, 206, 208, 211, 213, 215,
    218, 220, 222, 224, 226, 228, 230, 232, 234, 235, 237, 238, 240, 241, 243, 244,
    245, 246, 248, 249, 250, 250, 251, 252, 253, 253, 254, 254, 254, 255, 255, 255,
    255, 255, 255, 255, 254, 254, 254, 253, 253, 252, 251, 250, 250, 249, 248, 246,
    245, 244, 243, 241, 240, 238, 237, 235, 234, 232, 230, 228, 226, 224, 222, 220,
    218, 215, 213, 211, 208, 206, 203, 201, 198, 196, 193, 190, 188, 185, 182, 179,
    176, 173, 170, 167, 165, 162, 158, 155, 152, 149, 146, 143, 140, 137, 134, 131,
    128, 124, 121, 118, 115, 112, 109, 106, 103, 100,  97,  93,  90,  88,  85,  82,
     79,  76,  73,  70,  67,  65,  62,  59,  57,  54,  52,  49,  47,  44,  42,  40,
     37,  35,  33,  31,  29,  27,  25,  23,  21,  20,  18,  17,  15,  14,  12,  11,
     10,   9,   7,   6,   5,   5,   4,   3,   2,   2,   1,   1,   1,   0,   0,   0,
      0,   0,   0,   0,   1,   1,   1,   2,   2,   3,   4,   5,   5,   6,   7,   9,
     10,  11,  12,  14,  15,  17,  18,  20,  21,  23,  25,  27,  29,  31,  33,  35,
     37,  40,  42,  44,  47,  49,  52,  54,  57,  59,  62,  65,  67,  70,  73,  76,
     79,  82,  85,  88,  90,  93,  97, 100, 103, 106, 109, 112, 115, 118, 121, 124
};

void InstrSiggen_Init(void)
{
    GPIO_InitTypeDef gpio = {0};

    __HAL_RCC_TIM1_CLK_ENABLE();
    __HAL_RCC_DMA2_CLK_ENABLE();
    __HAL_RCC_GPIOA_CLK_ENABLE();

    gpio.Pin   = GPIO_PIN_8;            /* PA8 = TIM1_CH1 */
    gpio.Mode  = GPIO_MODE_AF_PP;
    gpio.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOA, &gpio);

    s_htim1.Instance               = TIM1;
    s_htim1.Init.Prescaler         = 0;
    s_htim1.Init.CounterMode       = TIM_COUNTERMODE_UP;
    s_htim1.Init.Period            = SG_PWM_MAX;      /* 8-bit resolution */
    s_htim1.Init.ClockDivision     = TIM_CLOCKDIVISION_DIV1;
    s_htim1.Init.RepetitionCounter = 0;
    s_htim1.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
    HAL_TIM_PWM_Init(&s_htim1);

    TIM_OC_InitTypeDef oc = {0};
    oc.OCMode     = TIM_OCMODE_PWM1;
    oc.Pulse      = 0;
    oc.OCPolarity = TIM_OCPOLARITY_HIGH;
    oc.OCFastMode = TIM_OCFAST_DISABLE;
    HAL_TIM_PWM_ConfigChannel(&s_htim1, &oc, TIM_CHANNEL_1);

    s_hdma.Instance                 = DMA2_Channel5;       /* TIM1_CC1 */
    s_hdma.Init.Direction           = DMA_MEMORY_TO_PERIPH;
    s_hdma.Init.PeriphInc           = DMA_PINC_DISABLE;
    s_hdma.Init.MemInc              = DMA_MINC_ENABLE;
    s_hdma.Init.PeriphDataAlignment = DMA_PDATAALIGN_HALFWORD;
    s_hdma.Init.MemDataAlignment    = DMA_MDATAALIGN_HALFWORD;
    s_hdma.Init.Mode                = DMA_CIRCULAR;
    s_hdma.Init.Priority            = DMA_PRIORITY_HIGH;
    HAL_DMA_Init(&s_hdma);
    __HAL_LINKDMA(&s_htim1, hdma[TIM_DMA_ID_CC1], s_hdma);
}

void InstrSiggen_Set(uint8_t waveform, uint32_t freq_hz, uint8_t amp)
{
    uint32_t i, psc, v, denom;

    for (i = 0; i < INSTR_SG_TABLE_LEN; i++) {
        switch (waveform) {
            case INSTR_WAVE_SQUARE:
                v = (i < INSTR_SG_TABLE_LEN / 2) ? SG_PWM_MAX : 0u;
                break;
            case INSTR_WAVE_TRIANGLE:
                v = (i < INSTR_SG_TABLE_LEN / 2)
                    ? (i * 2u * SG_PWM_MAX / INSTR_SG_TABLE_LEN)
                    : ((INSTR_SG_TABLE_LEN - 1u - i) * 2u * SG_PWM_MAX / INSTR_SG_TABLE_LEN);
                break;
            case INSTR_WAVE_SAW:
                v = i * SG_PWM_MAX / INSTR_SG_TABLE_LEN;
                break;
            case INSTR_WAVE_SINE:
            default:
                v = s_sine256[i];
                break;
        }
        s_table[i] = (uint16_t)((v * amp) / 255u);
    }

    /* fout = 72 MHz / ((PSC+1) * 65536) -> PSC = round(72 MHz / (fout*65536)) - 1 */
    if (freq_hz < 1u)    freq_hz = 1u;
    if (freq_hz > 1100u) freq_hz = 1100u;
    denom = freq_hz * INSTR_SG_TABLE_LEN * (SG_PWM_MAX + 1u);
    psc = (SG_TIM_CLK + denom / 2u) / denom;   /* round to nearest, not floor */
    if (psc == 0u)      psc = 1u;
    if (psc > 65535u)   psc = 65535u;
    __HAL_TIM_SET_PRESCALER(&s_htim1, psc - 1u);

    __HAL_TIM_SET_COUNTER(&s_htim1, 0);
    HAL_TIM_PWM_Start_DMA(&s_htim1, TIM_CHANNEL_1, (uint32_t *)s_table, INSTR_SG_TABLE_LEN);
    __HAL_TIM_MOE_ENABLE(&s_htim1);              /* advanced timer: enable output */
}

void InstrSiggen_Stop(void)
{
    HAL_TIM_PWM_Stop_DMA(&s_htim1, TIM_CHANNEL_1);
    __HAL_TIM_MOE_DISABLE(&s_htim1);
}
