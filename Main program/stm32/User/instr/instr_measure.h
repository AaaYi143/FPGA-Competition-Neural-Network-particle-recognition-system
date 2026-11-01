/**
 * @file    instr_measure.h
 * @brief   Trigger positioning and integer measurements over a sample buffer.
 */
#ifndef __INSTR_MEASURE_H
#define __INSTR_MEASURE_H

#include "stm32f1xx.h"

uint16_t InstrTrig_Rising(const uint16_t *buf, uint16_t n, uint16_t level);
uint16_t InstrMeas_Min(const uint16_t *buf, uint16_t n);
uint16_t InstrMeas_Max(const uint16_t *buf, uint16_t n);
uint16_t InstrMeas_VppMv(const uint16_t *buf, uint16_t n);   /* peak-peak in mV */
uint32_t InstrMeas_FreqHz(const uint16_t *buf, uint16_t n, uint32_t fs_hz);
uint16_t InstrMeas_DutyPermille(const uint16_t *buf, uint16_t n, uint16_t mid);
uint16_t InstrMeas_MeanMv(const uint16_t *buf, uint16_t n);

#endif /* __INSTR_MEASURE_H */
