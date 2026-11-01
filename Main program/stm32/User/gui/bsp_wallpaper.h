#ifndef __BSP_WALLPAPER_H
#define __BSP_WALLPAPER_H

#include "stm32f1xx.h"

/**
  * @brief  Wallpaper image stored in W25Q64 (after the GB2312 font library).
  *
  * Layout:
  *   WALLPAPER_MAGIC_ADDR : 4 bytes "WPP1" (written only after a verified burn)
  *   WALLPAPER_DATA_ADDR  : 153600 bytes RGB565, big-endian, row-major, 240x320
  *
  * The font library occupies 0x196000 .. 0x1D5FFF (64 sectors). 0x1E0000 is the
  * first free sector boundary after it, so wallpaper never overlaps the font.
  */
#define WALLPAPER_MAGIC_ADDR    0x1E0000UL
#define WALLPAPER_DATA_ADDR     (WALLPAPER_MAGIC_ADDR + 4UL)

#define WALLPAPER_W             240
#define WALLPAPER_H             320
#define WALLPAPER_SIZE          (WALLPAPER_W * WALLPAPER_H * 2)   /* 153600 */

uint8_t Wallpaper_Check(void);      /* 1 if a wallpaper has been burned */
void    Wallpaper_Draw(void);       /* stream the image onto the whole screen */
void    WallpaperBurn_Mode(void);   /* receive + burn over USART1, never returns */

/* Alpha compositing over the wallpaper (source pixels come from W25Q64, so no
 * LCD read-back or framebuffer is needed). alpha = 255 -> fully opaque color,
 * alpha = 0 -> wallpaper shows through completely. */
uint16_t Wallpaper_GetPixel(uint16_t x, uint16_t y);       /* one RGB565 wallpaper pixel */
void     Wallpaper_BlendRoundedRect(uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                                    uint8_t r, uint16_t color, uint8_t alpha);
void     Wallpaper_DrawBitmapBlend(uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                                   const uint8_t *bitmap, uint16_t fg,
                                   uint16_t tint, uint8_t alpha);

#endif /* __BSP_WALLPAPER_H */
