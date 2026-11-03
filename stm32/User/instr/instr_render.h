/**
 * @file    instr_render.h
 * @brief   Waveform rendering: grid, trace, sample->Y scaling, digital lanes.
 */
#ifndef __INSTR_RENDER_H
#define __INSTR_RENDER_H

#include "stm32f1xx.h"

void InstrRender_FillRect(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color);
void InstrRender_Grid(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color);
void InstrRender_Trace(uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                       const uint8_t *yarr, uint16_t fg, uint16_t bg);
void InstrRender_ResetTrace(void);
void InstrRender_Scale(const uint16_t *samples, uint16_t n, uint8_t *yarr, uint16_t h);
void InstrRender_Digital(const uint8_t *samples, uint16_t n,
                         uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                         uint8_t channels, const uint16_t *colors, uint16_t bg);

#endif /* __INSTR_RENDER_H */
