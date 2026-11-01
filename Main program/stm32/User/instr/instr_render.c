/**
 * @file    instr_render.c
 * @brief   Fast rect fill + trace/lane drawing on top of the public ILI9341
 *          primitives (ILI9341_OpenWindow + Write_Cmd(0x2C) + Write_Data).
 *          No framebuffer: trace erases the previous scanline in background
 *          colour, then draws the new one in foreground colour.
 */
#include "./instr/instr_render.h"
#include "./lcd/bsp_ili9341_lcd.h"

static uint8_t s_old_y[240];     /* previous trace Y, for erase pass */
static uint8_t s_trace_ready;    /* 0 = nothing drawn yet, skip first erase */

void InstrRender_FillRect(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color)
{
    uint32_t i, n = (uint32_t)w * h;
    ILI9341_OpenWindow(x, y, w, h);
    ILI9341_Write_Cmd(CMD_SetPixel);
    for (i = 0; i < n; i++) ILI9341_Write_Data(color);
}

void InstrRender_Grid(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color)
{
    uint16_t i;
    LCD_SetTextColor(color);
    ILI9341_DrawRectangle(x, y, w, h, 0);               /* border outline */
    for (i = 1; i < 4; i++) {                            /* 4x4 subdivision */
        ILI9341_DrawLine(x + w * i / 4, y, x + w * i / 4, y + h - 1);
        ILI9341_DrawLine(x, y + h * i / 4, x + w - 1, y + h * i / 4);
    }
}

void InstrRender_ResetTrace(void)
{
    s_trace_ready = 0;
}

void InstrRender_Trace(uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                       const uint8_t *yarr, uint16_t fg, uint16_t bg)
{
    uint16_t i;

    if (s_trace_ready) {
        /* erase old trace */
        for (i = 0; i + 1 < w; i++) {
            uint8_t a = s_old_y[i], b = s_old_y[i + 1];
            uint8_t ymin = a < b ? a : b;
            uint8_t seg  = (uint8_t)((a > b ? a : b) - ymin + 1u);
            InstrRender_FillRect(x + i, y + ymin, 1, seg, bg);
        }
    }

    /* draw new trace */
    for (i = 0; i + 1 < w; i++) {
        uint8_t a = yarr[i], b = yarr[i + 1];
        uint8_t ymin = a < b ? a : b;
        uint8_t seg  = (uint8_t)((a > b ? a : b) - ymin + 1u);
        InstrRender_FillRect(x + i, y + ymin, 1, seg, fg);
        s_old_y[i] = yarr[i];
    }
    if (w > 0) s_old_y[w - 1] = yarr[w - 1];
    s_trace_ready = 1;
}

void InstrRender_Scale(const uint16_t *samples, uint16_t n,
                       uint8_t *yarr, uint16_t h)
{
    uint16_t lo = 0xFFFFu, hi = 0, i;
    for (i = 0; i < n; i++) {
        if (samples[i] < lo) lo = samples[i];
        if (samples[i] > hi) hi = samples[i];
    }
    if (hi <= lo) hi = lo + 1u;                  /* flat signal: mid line */
    for (i = 0; i < n; i++) {
        uint32_t t = (uint32_t)(samples[i] - lo) * (h - 1u) / (hi - lo);
        yarr[i] = (uint8_t)(h - 1u - t);
    }
}

/* Stacked digital lanes, one per channel (channel 0 on top). */
void InstrRender_Digital(const uint8_t *samples, uint16_t n,
                         uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                         uint8_t channels, const uint16_t *colors, uint16_t bg)
{
    uint16_t lane_h = h / channels;
    uint8_t  ch;
    uint16_t i;

    InstrRender_FillRect(x, y, w, h, bg);
    for (ch = 1; ch < channels; ch++) {
        InstrRender_FillRect(x, y + ch * lane_h, w, 1, GREY);
    }
    for (ch = 0; ch < channels; ch++) {
        uint16_t top = y + ch * lane_h;
        uint16_t hi  = top + 2;
        uint16_t lo  = top + lane_h - 4;
        for (i = 0; i < w && i < n; i++) {
            uint16_t ly = ((samples[i] >> ch) & 1u) ? hi : lo;
            InstrRender_FillRect(x + i, ly, 1, 2, colors[ch]);
        }
    }
}
