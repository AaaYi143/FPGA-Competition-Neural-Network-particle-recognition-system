/**
 * @file    instr_capture.h
 * @brief   Instrument capture engine: oscilloscope ADC (TIM3 TRGO + DMA1_Ch1
 *          circular) and logic-analyzer GPIO sampler (TIM2 update IRQ).
 */
#ifndef __INSTR_CAPTURE_H
#define __INSTR_CAPTURE_H

#include "stm32f1xx.h"

#define INSTR_ADC_BUF_LEN   1024u   /* scope: 1024 samples, uint16, 2 KB */
#define INSTR_LA_BUF_LEN    4096u   /* LA: 4096 samples, uint8 (4ch packed) */
#define INSTR_LA_CHANNELS   4u

/* --- oscilloscope (ADC1 on PA1) --- */
void     InstrAdc_Init(void);
void     InstrAdc_SetRate(uint32_t rate_hz);   /* clamp 2000..500000 */
void     InstrAdc_Start(void);
void     InstrAdc_Stop(void);
uint16_t InstrAdc_Sample(uint16_t i);          /* raw ADC code, live ring */
uint16_t InstrAdc_WrIndex(void);               /* current DMA write position */

/* --- logic analyzer (4ch on GPIOA) --- */
void     InstrLa_Init(void);
void     InstrLa_SetRate(uint32_t rate_hz);    /* clamp 100000..500000 */
void     InstrLa_Start(void);
void     InstrLa_Stop(void);
uint8_t  InstrLa_Sample(uint16_t i);           /* bit0..3 = ch0..3 */
uint16_t InstrLa_WrIndex(void);                /* current write position */

#endif /* __INSTR_CAPTURE_H */
