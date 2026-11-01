/**
 * @file    instr_siggen.h
 * @brief   Signal generator: TIM1 PWM (PA8) + DMA2_Ch5 (CC1) writes duty per
 *          PWM cycle = PWM "DAC". Output is square at the pin; add an RC
 *          low-pass to smooth the other waveforms.
 */
#ifndef __INSTR_SIGGEN_H
#define __INSTR_SIGGEN_H

#include "stm32f1xx.h"

#define INSTR_WAVE_SINE     0u
#define INSTR_WAVE_SQUARE   1u
#define INSTR_WAVE_TRIANGLE 2u
#define INSTR_WAVE_SAW      3u
#define INSTR_SG_TABLE_LEN  256u

void InstrSiggen_Init(void);
void InstrSiggen_Set(uint8_t waveform, uint32_t freq_hz, uint8_t amp); /* amp 0..255 */
void InstrSiggen_Stop(void);

#endif /* __INSTR_SIGGEN_H */
