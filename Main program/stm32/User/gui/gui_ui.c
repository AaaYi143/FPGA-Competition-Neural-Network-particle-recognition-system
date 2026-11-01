/**
 * @file    gui_ui.c
 * @brief   Phone UI: screen state machine + widgets (see gui_ui.h).
 *
 * Screen layout is portrait 240 (X) x 320 (Y). Common header is 48px tall:
 *   0..23   status bar (clock left, signal + battery icons right)
 *   24..47  title bar (back chevron on the left for sub-screens, title centered)
 *
 * Chinese labels are GB2312 byte literals from gui_strings.c and are rendered
 * with ILI9341_DispString_EN_CH() (which auto-splits ASCII vs Chinese).
 */
#include "./gui/gui_ui.h"
#include "stm32f1xx_hal.h"
#include "./gui/gui_icons.h"
#include "./gui/gui_strings.h"
#include "./lcd/bsp_ili9341_lcd.h"
#include "./touch/bsp_xpt2046.h"
#include "./gui/bsp_wallpaper.h"
#include <stdio.h>
#include "./instr/instr_capture.h"
#include "./instr/instr_measure.h"
#include "./instr/instr_render.h"
#include "./instr/instr_siggen.h"

/* ---- palette (RGB565) ---- */
#define UI_HEADER_BG   BLACK
#define UI_BODY_BG     BLACK
#define UI_CARD        0x3186u   /* dark gray  (49,49,49) */
#define UI_CARD_PRESS  0x528Au   /* mid gray   (82,82,82) */
#define UI_DISPLAY_BG  UI_CARD   /* visible input field, not black-on-black */
#define UI_ACCENT      GREEN     /* call key */
#define UI_TXT         WHITE
#define UI_TXT_DIM     GREY
/* Home app-tile translucency over the wallpaper: 0 = see-through, 255 = opaque */
#define UI_TILE_ALPHA  180u

/* ---- layout constants ---- */
#define HEADER_H       48u
#define HOME_CARD_W    64u
#define HOME_CARD_H    76u
#define HOME_COL_STEP  72u        /* 64 + 8 gap */
#define HOME_ROW0_Y    144u
#define HOME_ROW1_Y    232u

#define DIAL_MAX       12u                 /* max digits in the entry field */
#define DIAL_KB_X0     7u
#define DIAL_KB_Y0     110u
#define DIAL_KB_W      52u
#define DIAL_KB_H      44u
#define DIAL_KB_GAP_X  6u
#define DIAL_KB_GAP_Y  6u
#define DIAL_KB_COL3   181u                /* 7 + 3*(52+6) */

#define UI_CLOCK_START_MIN  (12u * 60u)    /* status clock starts at 12:00 */

/* ---- instrument screens ---- */
#define OSC_PLOT_X  4u
#define OSC_PLOT_Y  52u
#define OSC_PLOT_W  232u
#define OSC_PLOT_H  180u
#define INSTR_BTN_Y 272u
#define INSTR_BTN_H 40u

/* ---- screens ---- */
typedef enum {
    UI_SCREEN_HOME = 0,
    UI_SCREEN_DIALER,
    UI_SCREEN_SMS,
    UI_SCREEN_CONTACTS,
    UI_SCREEN_SETTINGS,
    UI_SCREEN_INSTR,
    UI_SCREEN_OSC,
    UI_SCREEN_SIGGEN,
    UI_SCREEN_LA
} UiScreen_t;

typedef struct UiButton {
    uint16_t x, y, w, h;
    uint8_t  radius;
    uint16_t bg;
    const char   *label;      /* GB2312 label, or NULL */
    const Icon_t *icon;       /* optional icon */
    uint16_t icon_fg;
    char     key;             /* dialer digit, '\0' if none */
    uint8_t  big;             /* 1 = draw label with Font16x24 (digits) */
    uint8_t  translucent;     /* 1 = frosted tile over wallpaper (home icons) */
    void (*onTap)(struct UiButton *b);
} UiButton_t;

/* ---- state ---- */
static UiScreen_t s_screen;
static uint8_t    s_wallpaper;          /* cached Wallpaper_Check() */

static char     s_dial[DIAL_MAX + 1];
static uint8_t  s_dial_len;
static uint8_t  s_dial_calling;
static uint32_t s_dial_call_start;

static uint32_t s_clock_last_total;
static char     s_clock_buf[6];

static UiButton_t s_home[5];
static UiButton_t s_dial_btns[16];      /* 12 digits + del + clear + call + back */
static UiButton_t s_back;               /* shared back button (sub-screens) */

/* ---- instrument screens ---- */
static UiButton_t s_instr_menu[4];      /* 3 instruments + back */
static UiButton_t s_osc_btns[4];        /* run/stop + T- + T+ + back */
static UiButton_t s_siggen_btns[4];     /* wave + freq + amp + back */
static UiButton_t s_la_btns[4];         /* run/stop + T- + T+ + back */

static uint8_t  s_osc_run;
static uint8_t  s_osc_rate_idx;
static uint8_t  s_la_run;
static uint8_t  s_la_rate_idx;
static uint8_t  s_sg_wave;
static uint8_t  s_sg_freq_idx;
static uint8_t  s_sg_amp_idx;

static const uint32_t s_osc_rates[8] = {
    2000u, 5000u, 10000u, 20000u, 50000u, 100000u, 200000u, 500000u
};
static const uint32_t s_la_rates[3] = {100000u, 250000u, 500000u};
static const uint32_t s_sg_freqs[4] = {110u, 275u, 550u, 1100u};
static const uint8_t  s_sg_amps[4]  = {64u, 128u, 192u, 255u};
static const char *const s_sg_wave_names[4] = {"SINE", "SQR", "TRI", "SAW"};

/* ---- forward decls ---- */
static void ui_draw_screen(UiScreen_t scr);
static void ui_switch(UiScreen_t scr);

/* ====================== primitives ====================== */

static void ui_fill(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color)
{
    LCD_SetTextColor(color);
    ILI9341_DrawRectangle(x, y, w, h, 1);
}

/* Filled rounded rectangle. r==0, or a too-small card, falls back to a square. */
static void ui_fill_rounded(uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                            uint8_t r, uint16_t color)
{
    uint16_t x2 = x + w - 1, y2 = y + h - 1;
    if (r == 0 || w <= 2 * r || h <= 2 * r) {
        ui_fill(x, y, w, h, color);
        return;
    }
    LCD_SetTextColor(color);
    ILI9341_DrawRectangle(x + r, y, w - 2 * r, h, 1);          /* center slab   */
    ILI9341_DrawRectangle(x, y + r, r, h - 2 * r, 1);          /* left slab     */
    ILI9341_DrawRectangle(x + w - r, y + r, r, h - 2 * r, 1);  /* right slab    */
    ILI9341_DrawCircle(x + r - 1, y + r - 1, r, 1);            /* corners       */
    ILI9341_DrawCircle(x2 - r + 1, y + r - 1, r, 1);
    ILI9341_DrawCircle(x + r - 1, y2 - r + 1, r, 1);
    ILI9341_DrawCircle(x2 - r + 1, y2 - r + 1, r, 1);
}

/* Pixel width of a mixed ASCII/Chinese string using the current font. */
static uint16_t ui_text_width(const char *s)
{
    uint16_t w = 0;
    while (*s) {
        if ((uint8_t)*s <= 126) { w += LCD_GetFont()->Width; s++; }
        else { w += 16; s += 2; }          /* one GB2312 char = 2 bytes */
    }
    return w;
}

/* Draw a mixed EN/CH string horizontally centered on `cx`. */
static void ui_text_center(uint16_t cx, uint16_t y, const char *s,
                           uint16_t fg, uint16_t bg)
{
    uint16_t w = ui_text_width(s);
    uint16_t x = (cx >= w / 2) ? (uint16_t)(cx - w / 2) : 0;
    LCD_SetColors(fg, bg);
    ILI9341_DispString_EN_CH(x, y, (char *)s);
}

/* Render a mixed ASCII/Chinese string over a translucent tile: glyph strokes in
   `fg` (opaque), glyph background re-blended from the wallpaper with `tint`@`alpha`.
   Mirrors ui_text_center() but composites instead of writing a solid background. */
static void ui_text_center_blend(uint16_t cx, uint16_t y, const char *s,
                                 uint16_t fg, uint16_t tint, uint8_t alpha)
{
    uint16_t w = ui_text_width(s);
    uint16_t x = (cx >= w / 2) ? (uint16_t)(cx - w / 2) : 0;

    while (*s) {
        if ((uint8_t)*s <= 126) {
            /* ASCII glyph from the current font (RAM dot-matrix) */
            sFONT *f = LCD_GetFont();
            uint16_t fontLength = (uint16_t)((f->Width * f->Height) / 8);
            const uint8_t *bits = &f->table[((uint8_t)(*s - ' ')) * fontLength];
            Wallpaper_DrawBitmapBlend(x, y, f->Width, f->Height, bits, fg, tint, alpha);
            x = (uint16_t)(x + f->Width);
            s++;
        } else {
            /* one GB2312 char = 2 bytes, 16x16 glyph from W25Q64 */
            uint8_t buf[32];
            uint16_t usCh = (uint16_t)(((uint8_t)s[0] << 8) | (uint8_t)s[1]);
            GetGBKCode(buf, usCh);
            Wallpaper_DrawBitmapBlend(x, y, 16, 16, buf, fg, tint, alpha);
            x = (uint16_t)(x + 16);
            s += 2;
        }
    }
}

static void ui_draw_button(UiButton_t *b, uint8_t pressed)
{
    uint16_t bg = pressed ? UI_CARD_PRESS : b->bg;
    uint8_t  blend = (uint8_t)(b->translucent && s_wallpaper);

    if (blend) {
        Wallpaper_BlendRoundedRect(b->x, b->y, b->w, b->h, b->radius, bg, UI_TILE_ALPHA);
    } else {
        ui_fill_rounded(b->x, b->y, b->w, b->h, b->radius, bg);
    }

    if (b->icon) {
        uint16_t ix = b->x + (uint16_t)(b->w - b->icon->width) / 2;
        uint16_t iy;
        if (b->label) {
            iy = b->y + 12;                                   /* icon near top  */
        } else {
            iy = b->y + (uint16_t)(b->h - b->icon->height) / 2;
        }
        if (blend) {
            Wallpaper_DrawBitmapBlend(ix, iy, b->icon->width, b->icon->height,
                                      b->icon->bitmap, b->icon_fg, bg, UI_TILE_ALPHA);
        } else {
            ILI9341_DrawIcon(ix, iy, b->icon->width, b->icon->height,
                             b->icon->bitmap, b->icon_fg, bg);
        }
    }

    if (b->label) {
        if (b->icon) {
            /* tile: label centered under the icon */
            if (blend) {
                ui_text_center_blend(b->x + b->w / 2, b->y + b->h - 16 - 8,
                                     b->label, UI_TXT, bg, UI_TILE_ALPHA);
            } else {
                ui_text_center(b->x + b->w / 2, b->y + b->h - 16 - 8,
                               b->label, UI_TXT, bg);
            }
        } else if (b->big) {
            LCD_SetFont(&Font16x24);
            ui_text_center(b->x + b->w / 2, b->y + (uint16_t)(b->h - 24) / 2,
                           b->label, UI_TXT, bg);
            LCD_SetFont(&Font8x16);
        } else if (blend) {
            ui_text_center_blend(b->x + b->w / 2, b->y + (uint16_t)(b->h - 16) / 2,
                                 b->label, UI_TXT, bg, UI_TILE_ALPHA);
        } else {
            ui_text_center(b->x + b->w / 2, b->y + (uint16_t)(b->h - 16) / 2,
                           b->label, UI_TXT, bg);
        }
    }
}

/* ====================== clock ====================== */

static void ui_clock_string(char *buf)
{
    uint32_t total = UI_CLOCK_START_MIN + HAL_GetTick() / 60000u;
    uint16_t h = (uint16_t)((total / 60u) % 24u);
    uint16_t m = (uint16_t)(total % 60u);
    buf[0] = (char)('0' + h / 10);
    buf[1] = (char)('0' + h % 10);
    buf[2] = ':';
    buf[3] = (char)('0' + m / 10);
    buf[4] = (char)('0' + m % 10);
    buf[5] = '\0';
}

static void ui_draw_status_clock(void)
{
    ui_clock_string(s_clock_buf);
    LCD_SetFont(&Font8x16);
    LCD_SetColors(UI_TXT, UI_HEADER_BG);
    ILI9341_DispString_EN(6, 4, s_clock_buf);
}

/* Big clock inside the home card (centered in the 208-wide card). */
static void ui_draw_big_clock(void)
{
    ui_clock_string(s_clock_buf);

    if (s_wallpaper) {
        /* translucent clock card: clear + redraw the digits over the wallpaper */
        Wallpaper_BlendRoundedRect(60, 64, 120, 32, 0, UI_CARD, UI_TILE_ALPHA);
        LCD_SetFont(&Font24x32);
        ui_text_center_blend(120, 64, s_clock_buf, UI_TXT, UI_CARD, UI_TILE_ALPHA);
    } else {
        LCD_SetTextColor(UI_CARD);
        ILI9341_DrawRectangle(60, 64, 120, 32, 1);      /* clear old digits */
        LCD_SetFont(&Font24x32);
        LCD_SetColors(UI_TXT, UI_CARD);
        ILI9341_DispString_EN(60, 64, s_clock_buf);
    }
    LCD_SetFont(&Font8x16);
}

/* ====================== header / title ====================== */

static const char *ui_title(UiScreen_t scr)
{
    switch (scr) {
        case UI_SCREEN_HOME:      return (const char *)ui_str_title_home;
        case UI_SCREEN_DIALER:    return (const char *)ui_str_app_dialer;
        case UI_SCREEN_SMS:       return (const char *)ui_str_app_sms;
        case UI_SCREEN_CONTACTS:  return (const char *)ui_str_app_contacts;
        case UI_SCREEN_SETTINGS:  return (const char *)ui_str_app_settings;
        case UI_SCREEN_INSTR:     return (const char *)ui_str_app_instr;
        case UI_SCREEN_OSC:       return (const char *)ui_str_osc;
        case UI_SCREEN_SIGGEN:    return (const char *)ui_str_siggen;
        case UI_SCREEN_LA:        return (const char *)ui_str_la;
        default:                  return "";
    }
}

static void ui_draw_header(UiScreen_t scr)
{
    ui_fill(0, 0, LCD_X_LENGTH, HEADER_H, UI_HEADER_BG);

    /* status bar */
    LCD_SetFont(&Font8x16);
    ui_clock_string(s_clock_buf);
    LCD_SetColors(UI_TXT, UI_HEADER_BG);
    ILI9341_DispString_EN(6, 4, s_clock_buf);
    ILI9341_DrawIcon(200, 4, 16, 16, icon_signal.bitmap, GREEN, UI_HEADER_BG);
    ILI9341_DrawIcon(220, 4, 16, 16, icon_battery.bitmap, GREEN, UI_HEADER_BG);

    /* title */
    LCD_SetFont(&Font8x16);
    ui_text_center(LCD_X_LENGTH / 2, 28, ui_title(scr), UI_TXT, UI_HEADER_BG);

    /* back chevron (sub-screens only) */
    if (scr != UI_SCREEN_HOME) {
        ILI9341_DrawIcon(8, 28, icon_back.width, icon_back.height,
                         icon_back.bitmap, UI_TXT, UI_HEADER_BG);
    }
}

/* ====================== screens ====================== */

static void ui_draw_home_body(void)
{
    uint8_t i;

    /* clock card (translucent over the wallpaper, like the app tiles) */
    if (s_wallpaper) {
        Wallpaper_BlendRoundedRect(16, 56, 208, 76, 8, UI_CARD, UI_TILE_ALPHA);
    } else {
        ui_fill_rounded(16, 56, 208, 76, 8, UI_CARD);
    }
    ui_draw_big_clock();
    LCD_SetFont(&Font8x16);
    if (s_wallpaper) {
        ui_text_center_blend(120, 104, (const char *)ui_str_about_1, UI_TXT_DIM, UI_CARD, UI_TILE_ALPHA);
    } else {
        ui_text_center(120, 104, (const char *)ui_str_about_1, UI_TXT_DIM, UI_CARD);
    }

    for (i = 0; i < 5; i++) {
        ui_draw_button(&s_home[i], 0);
    }
}

static void ui_draw_dialer_body(void)
{
    uint8_t i;

    /* number entry field */
    ui_fill_rounded(16, 56, 208, 44, 6, UI_DISPLAY_BG);
    if (s_dial_calling) {
        LCD_SetFont(&Font8x16);
        ui_text_center(120, 68, (const char *)ui_str_calling,
                       UI_ACCENT, UI_DISPLAY_BG);
    } else if (s_dial_len) {
        LCD_SetFont(&Font16x24);
        LCD_SetColors(UI_TXT, UI_DISPLAY_BG);
        ILI9341_DispString_EN(24, 66, s_dial);
        LCD_SetFont(&Font8x16);
    } else {
        LCD_SetFont(&Font8x16);
        ui_text_center(120, 68, (const char *)ui_str_empty_dial,
                       UI_TXT_DIM, UI_DISPLAY_BG);
    }

    for (i = 0; i < 15; i++) {         /* content keys (back is #15) */
        ui_draw_button(&s_dial_btns[i], 0);
    }
}

static void ui_draw_placeholder(const char *text)
{
    LCD_SetFont(&Font8x16);
    ui_text_center(LCD_X_LENGTH / 2, 150, text, UI_TXT_DIM, UI_BODY_BG);
}

static void ui_draw_settings_body(void)
{
    LCD_SetFont(&Font8x16);
    ui_text_center(120, 96,  (const char *)ui_str_about_1, UI_TXT,     UI_BODY_BG);
    ui_text_center(120, 128, (const char *)ui_str_about_2, UI_TXT_DIM, UI_BODY_BG);
    ui_text_center(120, 160, (const char *)ui_str_net_name, UI_TXT_DIM, UI_BODY_BG);
}

/* ====================== instrument screens ====================== */

static void ui_siggen_draw_readout(void)
{
    char line[40];
    LCD_SetFont(&Font8x16);
    LCD_SetColors(WHITE, BLACK);
    sprintf(line, "WAVE %s", s_sg_wave_names[s_sg_wave]);
    ILI9341_DispString_EN(16, 80, line);
    sprintf(line, "FREQ %d Hz", (int)s_sg_freqs[s_sg_freq_idx]);
    ILI9341_DispString_EN(16, 120, line);
    sprintf(line, "AMP  %d", (int)s_sg_amps[s_sg_amp_idx]);
    ILI9341_DispString_EN(16, 160, line);
}

static void ui_draw_instr_menu_body(void)
{
    uint8_t i;
    for (i = 0; i < 3; i++) {
        ui_draw_button(&s_instr_menu[i], 0);
    }
}

static void ui_draw_osc_body(void)
{
    uint8_t i;
    InstrRender_ResetTrace();
    InstrRender_Grid(OSC_PLOT_X, OSC_PLOT_Y, OSC_PLOT_W, OSC_PLOT_H, GREY);
    for (i = 0; i < 4; i++) {
        ui_draw_button(&s_osc_btns[i], 0);
    }
}

static void ui_draw_siggen_body(void)
{
    uint8_t i;
    for (i = 0; i < 4; i++) {
        ui_draw_button(&s_siggen_btns[i], 0);
    }
    ui_siggen_draw_readout();
}

static void ui_draw_la_body(void)
{
    uint8_t i;
    LCD_SetTextColor(GREY);
    ILI9341_DrawRectangle(OSC_PLOT_X, OSC_PLOT_Y, OSC_PLOT_W, OSC_PLOT_H, 0);
    for (i = 0; i < 4; i++) {
        ui_draw_button(&s_la_btns[i], 0);
    }
}

static void ui_osc_refresh(void)
{
    static uint16_t buf[OSC_PLOT_W];
    static uint8_t  yarr[OSC_PLOT_W];
    char line[32];
    uint16_t i, wr = InstrAdc_WrIndex();

    for (i = 0; i < OSC_PLOT_W; i++) {
        buf[i] = InstrAdc_Sample((uint16_t)(wr - OSC_PLOT_W + i));
    }
    InstrRender_Scale(buf, OSC_PLOT_W, yarr, OSC_PLOT_H);
    InstrRender_Trace(OSC_PLOT_X, OSC_PLOT_Y, OSC_PLOT_W, OSC_PLOT_H, yarr, GREEN, BLACK);
    InstrRender_Grid(OSC_PLOT_X, OSC_PLOT_Y, OSC_PLOT_W, OSC_PLOT_H, GREY);  /* restore graticule over the trace */

    LCD_SetFont(&Font8x16);
    LCD_SetColors(WHITE, BLACK);
    sprintf(line, "Vpp %4d mV", (int)InstrMeas_VppMv(buf, OSC_PLOT_W));
    ILI9341_DispString_EN(4, 236, line);
    sprintf(line, "F   %6d Hz", (int)InstrMeas_FreqHz(buf, OSC_PLOT_W, s_osc_rates[s_osc_rate_idx]));
    ILI9341_DispString_EN(4, 252, line);
}

static void ui_la_refresh(void)
{
    static uint8_t buf[OSC_PLOT_W];
    static const uint16_t colors[INSTR_LA_CHANNELS] = {YELLOW, CYAN, MAGENTA, WHITE};
    uint16_t i, wr = InstrLa_WrIndex();

    for (i = 0; i < OSC_PLOT_W; i++) {
        buf[i] = InstrLa_Sample((uint16_t)(wr - OSC_PLOT_W + i));
    }
    InstrRender_Digital(buf, OSC_PLOT_W, OSC_PLOT_X, OSC_PLOT_Y, OSC_PLOT_W, OSC_PLOT_H,
                        INSTR_LA_CHANNELS, colors, BLACK);
    LCD_SetTextColor(GREY);
    ILI9341_DrawRectangle(OSC_PLOT_X, OSC_PLOT_Y, OSC_PLOT_W, OSC_PLOT_H, 0);
}

static void ui_draw_screen(UiScreen_t scr)
{
    /* background */
    if (scr == UI_SCREEN_HOME) {
        if (s_wallpaper) {
            Wallpaper_Draw();
        } else {
            LCD_SetBackColor(UI_BODY_BG);
            ILI9341_Clear(0, 0, LCD_X_LENGTH, LCD_Y_LENGTH);
        }
    } else {
        LCD_SetBackColor(UI_BODY_BG);
        ILI9341_Clear(0, 0, LCD_X_LENGTH, LCD_Y_LENGTH);
    }

    ui_draw_header(scr);

    switch (scr) {
        case UI_SCREEN_HOME:      ui_draw_home_body(); break;
        case UI_SCREEN_DIALER:    ui_draw_dialer_body(); break;
        case UI_SCREEN_SMS:       ui_draw_placeholder((const char *)ui_str_empty_sms); break;
        case UI_SCREEN_CONTACTS:  ui_draw_placeholder((const char *)ui_str_empty_contacts); break;
        case UI_SCREEN_SETTINGS:  ui_draw_settings_body(); break;
        case UI_SCREEN_INSTR:     ui_draw_instr_menu_body(); break;
        case UI_SCREEN_OSC:       ui_draw_osc_body(); break;
        case UI_SCREEN_SIGGEN:    ui_draw_siggen_body(); break;
        case UI_SCREEN_LA:        ui_draw_la_body(); break;
        default: break;
    }

    LCD_SetFont(&Font8x16);
    s_clock_last_total = UI_CLOCK_START_MIN + HAL_GetTick() / 60000u;
}

/* ====================== callbacks ====================== */

static void ui_cb_goto_dialer(UiButton_t *b)    { (void)b; ui_switch(UI_SCREEN_DIALER); }
static void ui_cb_goto_sms(UiButton_t *b)       { (void)b; ui_switch(UI_SCREEN_SMS); }
static void ui_cb_goto_contacts(UiButton_t *b)  { (void)b; ui_switch(UI_SCREEN_CONTACTS); }
static void ui_cb_goto_settings(UiButton_t *b)  { (void)b; ui_switch(UI_SCREEN_SETTINGS); }
static void ui_cb_back(UiButton_t *b)
{
    (void)b;
    if (s_screen == UI_SCREEN_OSC || s_screen == UI_SCREEN_SIGGEN || s_screen == UI_SCREEN_LA) {
        ui_switch(UI_SCREEN_INSTR);
    } else {
        ui_switch(UI_SCREEN_HOME);
    }
}
static void ui_cb_goto_instr(UiButton_t *b)     { (void)b; ui_switch(UI_SCREEN_INSTR); }
static void ui_cb_goto_osc(UiButton_t *b)       { (void)b; ui_switch(UI_SCREEN_OSC); }
static void ui_cb_goto_siggen(UiButton_t *b)    { (void)b; ui_switch(UI_SCREEN_SIGGEN); }
static void ui_cb_goto_la(UiButton_t *b)        { (void)b; ui_switch(UI_SCREEN_LA); }

static void ui_cb_osc_run(UiButton_t *b)
{
    s_osc_run = !s_osc_run;
    if (s_osc_run) {
        InstrAdc_SetRate(s_osc_rates[s_osc_rate_idx]);
        InstrAdc_Start();
        b->label = (const char *)ui_str_stop;
    } else {
        InstrAdc_Stop();
        b->label = (const char *)ui_str_run;
    }
    ui_draw_button(b, 0);
}

static void ui_cb_osc_tb_down(UiButton_t *b)
{
    (void)b;
    if (s_osc_rate_idx > 0) s_osc_rate_idx--;
    InstrAdc_SetRate(s_osc_rates[s_osc_rate_idx]);
}

static void ui_cb_osc_tb_up(UiButton_t *b)
{
    (void)b;
    if (s_osc_rate_idx < 7) s_osc_rate_idx++;
    InstrAdc_SetRate(s_osc_rates[s_osc_rate_idx]);
}

static void ui_cb_la_run(UiButton_t *b)
{
    s_la_run = !s_la_run;
    if (s_la_run) {
        InstrLa_SetRate(s_la_rates[s_la_rate_idx]);
        InstrLa_Start();
        b->label = (const char *)ui_str_stop;
    } else {
        InstrLa_Stop();
        b->label = (const char *)ui_str_run;
    }
    ui_draw_button(b, 0);
}

static void ui_cb_la_tb_down(UiButton_t *b)
{
    (void)b;
    if (s_la_rate_idx > 0) s_la_rate_idx--;
    InstrLa_SetRate(s_la_rates[s_la_rate_idx]);
}

static void ui_cb_la_tb_up(UiButton_t *b)
{
    (void)b;
    if (s_la_rate_idx < 2) s_la_rate_idx++;
    InstrLa_SetRate(s_la_rates[s_la_rate_idx]);
}

static void ui_cb_sg_wave(UiButton_t *b)
{
    (void)b;
    s_sg_wave = (s_sg_wave + 1) & 3u;
    InstrSiggen_Set(s_sg_wave, s_sg_freqs[s_sg_freq_idx], s_sg_amps[s_sg_amp_idx]);
    ui_siggen_draw_readout();
}

static void ui_cb_sg_freq(UiButton_t *b)
{
    (void)b;
    s_sg_freq_idx = (s_sg_freq_idx + 1) & 3u;
    InstrSiggen_Set(s_sg_wave, s_sg_freqs[s_sg_freq_idx], s_sg_amps[s_sg_amp_idx]);
    ui_siggen_draw_readout();
}

static void ui_cb_sg_amp(UiButton_t *b)
{
    (void)b;
    s_sg_amp_idx = (s_sg_amp_idx + 1) & 3u;
    InstrSiggen_Set(s_sg_wave, s_sg_freqs[s_sg_freq_idx], s_sg_amps[s_sg_amp_idx]);
    ui_siggen_draw_readout();
}

static void ui_cb_digit(UiButton_t *b)
{
    if (s_dial_len < DIAL_MAX) {
        s_dial[s_dial_len++] = b->key;
        s_dial[s_dial_len] = '\0';
    }
    ui_draw_screen(UI_SCREEN_DIALER);
}

static void ui_cb_del(UiButton_t *b)
{
    (void)b;
    if (s_dial_len) {
        s_dial[--s_dial_len] = '\0';
    }
    ui_draw_screen(UI_SCREEN_DIALER);
}

static void ui_cb_clear(UiButton_t *b)
{
    (void)b;
    s_dial_len = 0;
    s_dial[0] = '\0';
    ui_draw_screen(UI_SCREEN_DIALER);
}

static void ui_cb_call(UiButton_t *b)
{
    (void)b;
    if (s_dial_len == 0) {
        return;
    }
    s_dial_calling = 1;
    s_dial_call_start = HAL_GetTick();
    printf("DIAL: %s\r\n", s_dial);       /* Phase 2 hook: ATD<num>; goes here */
    ui_draw_screen(UI_SCREEN_DIALER);
}

/* ====================== buttons setup ====================== */

static UiButton_t ui_make_button(uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                                 uint8_t r, uint16_t bg, const char *label,
                                 const Icon_t *ic, uint16_t icfg, char key,
                                 uint8_t big, void (*cb)(UiButton_t *))
{
    UiButton_t b;
    b.x = x; b.y = y; b.w = w; b.h = h; b.radius = r; b.bg = bg;
    b.label = label; b.icon = ic; b.icon_fg = icfg; b.key = key; b.big = big;
    b.translucent = 0;
    b.onTap = cb;
    return b;
}

static void ui_build_buttons(void)
{
    static const char *const digit_labels[12] = {
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"
    };
    uint8_t i;

    /* home tiles: 3x2 grid, 5 apps (x = 16 + col*72, col = 0..2) */
    s_home[0] = ui_make_button(16,  HOME_ROW0_Y, HOME_CARD_W, HOME_CARD_H, 8, UI_CARD,
                               (const char *)ui_str_app_dialer, &icon_dialer, UI_TXT,
                               0, 0, ui_cb_goto_dialer);
    s_home[1] = ui_make_button(88,  HOME_ROW0_Y, HOME_CARD_W, HOME_CARD_H, 8, UI_CARD,
                               (const char *)ui_str_app_sms, &icon_sms, UI_TXT,
                               0, 0, ui_cb_goto_sms);
    s_home[2] = ui_make_button(160, HOME_ROW0_Y, HOME_CARD_W, HOME_CARD_H, 8, UI_CARD,
                               (const char *)ui_str_app_contacts, &icon_contacts, UI_TXT,
                               0, 0, ui_cb_goto_contacts);
    s_home[3] = ui_make_button(16,  HOME_ROW1_Y, HOME_CARD_W, HOME_CARD_H, 8, UI_CARD,
                               (const char *)ui_str_app_settings, &icon_settings, UI_TXT,
                               0, 0, ui_cb_goto_settings);
    s_home[4] = ui_make_button(88,  HOME_ROW1_Y, HOME_CARD_W, HOME_CARD_H, 8, UI_CARD,
                               (const char *)ui_str_app_instr, NULL, UI_TXT,
                               0, 0, ui_cb_goto_instr);

    for (i = 0; i < 5; i++) {
        s_home[i].translucent = 1;   /* home icons blend over the wallpaper */
    }

    /* shared back button (sub-screens) */
    s_back = ui_make_button(6, 26, 28, 28, 6, UI_HEADER_BG,
                            NULL, &icon_back, UI_TXT, 0, 0, ui_cb_back);

    /* instrument menu: 3 stacked choices + back */
    s_instr_menu[0] = ui_make_button(16, 72,  208, 64, 8, UI_CARD,
                                     (const char *)ui_str_osc, NULL, 0, 0, 0, ui_cb_goto_osc);
    s_instr_menu[1] = ui_make_button(16, 144, 208, 64, 8, UI_CARD,
                                     (const char *)ui_str_siggen, NULL, 0, 0, 0, ui_cb_goto_siggen);
    s_instr_menu[2] = ui_make_button(16, 216, 208, 64, 8, UI_CARD,
                                     (const char *)ui_str_la, NULL, 0, 0, 0, ui_cb_goto_la);
    s_instr_menu[3] = s_back;

    /* scope bottom bar */
    s_osc_btns[0] = ui_make_button(4,   INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                   (const char *)ui_str_run, NULL, 0, 0, 0, ui_cb_osc_run);
    s_osc_btns[1] = ui_make_button(64,  INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                   "T-", NULL, 0, 0, 0, ui_cb_osc_tb_down);
    s_osc_btns[2] = ui_make_button(124, INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                   "T+", NULL, 0, 0, 0, ui_cb_osc_tb_up);
    s_osc_btns[3] = s_back;

    /* siggen bottom bar */
    s_siggen_btns[0] = ui_make_button(4,   INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                      (const char *)ui_str_wave, NULL, 0, 0, 0, ui_cb_sg_wave);
    s_siggen_btns[1] = ui_make_button(64,  INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                      (const char *)ui_str_freq, NULL, 0, 0, 0, ui_cb_sg_freq);
    s_siggen_btns[2] = ui_make_button(124, INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                      (const char *)ui_str_amp, NULL, 0, 0, 0, ui_cb_sg_amp);
    s_siggen_btns[3] = s_back;

    /* LA bottom bar */
    s_la_btns[0] = ui_make_button(4,   INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                  (const char *)ui_str_run, NULL, 0, 0, 0, ui_cb_la_run);
    s_la_btns[1] = ui_make_button(64,  INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                  "T-", NULL, 0, 0, 0, ui_cb_la_tb_down);
    s_la_btns[2] = ui_make_button(124, INSTR_BTN_Y, 56, INSTR_BTN_H, 8, UI_CARD,
                                  "T+", NULL, 0, 0, 0, ui_cb_la_tb_up);
    s_la_btns[3] = s_back;

    /* dialer: 12 digits (3x4) */
    for (i = 0; i < 12; i++) {
        uint8_t r = i / 3, c = i % 3;
        s_dial_btns[i] = ui_make_button(
            (uint16_t)(DIAL_KB_X0 + c * (DIAL_KB_W + DIAL_KB_GAP_X)),
            (uint16_t)(DIAL_KB_Y0 + r * (DIAL_KB_H + DIAL_KB_GAP_Y)),
            DIAL_KB_W, DIAL_KB_H, 8, UI_CARD,
            digit_labels[i], NULL, 0, digit_labels[i][0], 1, ui_cb_digit);
    }

    /* control column */
    s_dial_btns[12] = ui_make_button(DIAL_KB_COL3, 110, DIAL_KB_W, DIAL_KB_H, 8, UI_CARD,
                                (const char *)ui_str_key_del, NULL, 0, 0, 0, ui_cb_del);
    s_dial_btns[13] = ui_make_button(DIAL_KB_COL3, 160, DIAL_KB_W, DIAL_KB_H, 8, UI_CARD,
                                (const char *)ui_str_key_clear, NULL, 0, 0, 0, ui_cb_clear);
    s_dial_btns[14] = ui_make_button(DIAL_KB_COL3, 210, DIAL_KB_W, 94, 8, UI_ACCENT,
                                (const char *)ui_str_key_call, NULL, 0, 0, 0, ui_cb_call);
    s_dial_btns[15] = s_back;
}

/* ====================== hit test / dispatch ====================== */

static UiButton_t *ui_buttons(UiScreen_t scr, uint8_t *count)
{
    switch (scr) {
        case UI_SCREEN_HOME:   *count = 5;  return s_home;
        case UI_SCREEN_DIALER: *count = 16; return s_dial_btns;
        case UI_SCREEN_INSTR:  *count = 4;  return s_instr_menu;
        case UI_SCREEN_OSC:    *count = 4;  return s_osc_btns;
        case UI_SCREEN_SIGGEN: *count = 4;  return s_siggen_btns;
        case UI_SCREEN_LA:     *count = 4;  return s_la_btns;
        default:               *count = 1;  return &s_back;
    }
}

static UiButton_t *ui_hit(UiScreen_t scr, uint16_t x, uint16_t y)
{
    uint8_t i, n;
    UiButton_t *arr = ui_buttons(scr, &n);
    for (i = 0; i < n; i++) {
        if (x >= arr[i].x && x < arr[i].x + arr[i].w &&
            y >= arr[i].y && y < arr[i].y + arr[i].h) {
            return &arr[i];
        }
    }
    return NULL;
}

static void ui_switch(UiScreen_t scr)
{
    /* Stop measurement capture when leaving its screen. The signal source is
       left RUNNING (DMA-driven, no CPU cost) so it can keep feeding a loopback
       probe while you view the scope — like a bench function generator. */
    if (s_screen == UI_SCREEN_OSC) InstrAdc_Stop();
    if (s_screen == UI_SCREEN_LA)  InstrLa_Stop();

    s_screen = scr;
    if (scr == UI_SCREEN_DIALER) {
        s_dial_len = 0;
        s_dial[0] = '\0';
        s_dial_calling = 0;
    } else if (scr == UI_SCREEN_OSC) {
        InstrAdc_SetRate(s_osc_rates[s_osc_rate_idx]);
        InstrAdc_Start();
        s_osc_run = 1;
        s_osc_btns[0].label = (const char *)ui_str_stop;
    } else if (scr == UI_SCREEN_LA) {
        InstrLa_SetRate(s_la_rates[s_la_rate_idx]);
        InstrLa_Start();
        s_la_run = 1;
        s_la_btns[0].label = (const char *)ui_str_stop;
    } else if (scr == UI_SCREEN_SIGGEN) {
        InstrSiggen_Set(s_sg_wave, s_sg_freqs[s_sg_freq_idx], s_sg_amps[s_sg_amp_idx]);
    }
    ui_draw_screen(scr);
}

/* ====================== public API ====================== */

void UI_Init(void)
{
    LCD_SetFont(&Font8x16);
    s_wallpaper = Wallpaper_Check();
    InstrAdc_Init();
    InstrLa_Init();
    InstrSiggen_Init();
    ui_build_buttons();
    s_clock_last_total = 0xFFFFFFFFu;   /* force a first clock draw */
    ui_switch(UI_SCREEN_HOME);
}

void UI_Poll(void)
{
    TouchPoint_t pt;
    static uint8_t held = 0;
    static UiButton_t *held_btn = NULL;

    if (XPT2046_ReadXY(&pt)) {
        if (!held) {
            UiButton_t *b = ui_hit(s_screen, pt.x, pt.y);
            if (b) {
                held = 1;
                held_btn = b;
                ui_draw_button(b, 1);
            }
        }
    } else {
        if (held) {
            UiButton_t *b = held_btn;
            held = 0;
            held_btn = NULL;
            if (b && b->onTap) {
                b->onTap(b);
            }
        }
    }
}

void UI_Tick(void)
{
    uint32_t total = UI_CLOCK_START_MIN + HAL_GetTick() / 60000u;

    if (total != s_clock_last_total) {
        s_clock_last_total = total;
        ui_draw_status_clock();
        if (s_screen == UI_SCREEN_HOME) {
            ui_draw_big_clock();
        }
    }

    if (s_dial_calling && (HAL_GetTick() - s_dial_call_start) >= 2000u) {
        s_dial_calling = 0;
        ui_draw_screen(UI_SCREEN_DIALER);
    }

    /* instrument continuous refresh (~30 fps) */
    if ((s_screen == UI_SCREEN_OSC && s_osc_run) ||
        (s_screen == UI_SCREEN_LA  && s_la_run)) {
        static uint32_t last = 0;
        if (HAL_GetTick() - last >= 33u) {
            last = HAL_GetTick();
            if (s_screen == UI_SCREEN_OSC) ui_osc_refresh();
            else                           ui_la_refresh();
        }
    }
}

/* ====================== touch calibration ====================== */

static const uint16_t s_calib_sx[3] = { 20, 220, 20 };
static const uint16_t s_calib_sy[3] = { 20, 20, 300 };
static const char *const s_calib_name[3] = {
    "TOP-LEFT", "TOP-RIGHT", "BOTTOM-LEFT"
};

static void ui_draw_cross(uint16_t x, uint16_t y, uint16_t color)
{
    LCD_SetTextColor(color);
    ILI9341_DrawLine((uint16_t)(x - 10), y, (uint16_t)(x + 10), y);
    ILI9341_DrawLine(x, (uint16_t)(y - 10), x, (uint16_t)(y + 10));
}

/* 交互式三点标定：画十字 → 等待按下 → 采原始 ADC → 等待松开。
 * 三点求仿射系数并写入 W25Q64（XPT_CALIB_ADDR 扇区）。
 */
void UI_Calibrate(void)
{
    uint16_t rx[3], ry[3];
    uint8_t i;

    ILI9341_Clear(0, 0, LCD_X_LENGTH, LCD_Y_LENGTH);
    LCD_SetFont(&Font8x16);
    LCD_SetColors(WHITE, BLACK);
    ILI9341_DispString_EN(16, 120, "Touch calibration");
    ILI9341_DispString_EN(16, 140, "Tap each crosshair");
    HAL_Delay(1500);

    for (i = 0; i < 3; i++) {
        ILI9341_Clear(0, 0, LCD_X_LENGTH, LCD_Y_LENGTH);
        ui_draw_cross(s_calib_sx[i], s_calib_sy[i], GREEN);
        LCD_SetFont(&Font8x16);
        LCD_SetColors(WHITE, BLACK);
        ILI9341_DispString_EN(16, 280, (char *)s_calib_name[i]);
        printf("CALIBRATE: tap %s\r\n", s_calib_name[i]);

        while (!XPT2046_IsPressed()) { }   /* 等待按下 */
        HAL_Delay(60);                     /* 等待采样稳定 */
        XPT2046_GetRaw(&rx[i], &ry[i]);    /* 原始 ADC（3 次中值） */
        printf("  raw = (%d, %d)\r\n", (int)rx[i], (int)ry[i]);
        while (XPT2046_IsPressed()) { }    /* 等待松开 */
        HAL_Delay(200);                    /* 消抖 */
    }

    if (!XPT2046_Calib_Compute(s_calib_sx, s_calib_sy, rx, ry)) {
        printf("CALIBRATE: FAILED (points collinear)\r\n");
        ILI9341_Clear(0, 0, LCD_X_LENGTH, LCD_Y_LENGTH);
        LCD_SetColors(RED, BLACK);
        ILI9341_DispString_EN(16, 150, "Calib failed - reset");
    } else {
        XPT2046_Calib_Save();
        printf("CALIBRATE: OK\r\n");
    }
}
