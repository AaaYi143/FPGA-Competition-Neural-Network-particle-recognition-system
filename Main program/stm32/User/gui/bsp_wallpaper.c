/**
  ******************************************************************************
  * @file    bsp_wallpaper.c
  * @brief   Wallpaper in W25Q64: stream-draw a 240x320 RGB565 image onto the
  *          ILI9341, plus a burn mode that receives the image over USART1.
  *          Host counterpart: tools/flash_wallpaper.py
  *
  * Burn protocol (host -> board), same as font_burn.c:
  *   [4B total_len LE][4B crc32 LE]  then raw RGB565 in <=512B chunks, 'K' ACK
  * The magic "WPP1" is stamped only after a CRC-verified burn, so Wallpaper_Check()
  * reliably reports whether a valid wallpaper is present.
  ******************************************************************************
  */
#include "./gui/bsp_wallpaper.h"
#include "./lcd/bsp_ili9341_lcd.h"
#include "./flash/bsp_spi_flash.h"
#include "./usart/bsp_debug_usart.h"
#include <stdio.h>

#define WALLPAPER_BURN_CHUNK     512
#define WALLPAPER_BURN_SECTORS   38      /* ceil((4 + 153600) / 4096) */

static uint8_t  WallpaperBurn_RxByte(void);
static uint32_t WallpaperBurn_RxU32LE(void);
static uint32_t WallpaperBurn_Crc32(uint32_t crc, uint8_t b);

/**
  * @brief  Return 1 if a wallpaper has been burned (magic "WPP1" present).
  */
uint8_t Wallpaper_Check(void)
{
    uint8_t magic[4];
    SPI_FLASH_BufferRead(magic, WALLPAPER_MAGIC_ADDR, 4);
    return (magic[0] == 'W' && magic[1] == 'P' && magic[2] == 'P' && magic[3] == '1');
}

/**
  * @brief  Stream the RGB565 wallpaper from W25Q64 onto the whole screen.
  *         No framebuffer: open the full window once, then read+write in chunks.
  */
void Wallpaper_Draw(void)
{
    uint8_t  buf[WALLPAPER_BURN_CHUNK];
    uint32_t addr      = WALLPAPER_DATA_ADDR;
    uint32_t remaining = WALLPAPER_SIZE;
    uint16_t i, n;

    ILI9341_OpenWindow(0, 0, WALLPAPER_W, WALLPAPER_H);
    ILI9341_Write_Cmd(CMD_SetPixel);

    while (remaining) {
        n = (remaining > WALLPAPER_BURN_CHUNK) ? WALLPAPER_BURN_CHUNK : (uint16_t)remaining;
        SPI_FLASH_BufferRead(buf, addr, n);
        for (i = 0; i < n; i += 2) {
            /* big-endian RGB565 in flash -> 16-bit color */
            ILI9341_Write_Data((uint16_t)((buf[i] << 8) | buf[i + 1]));
        }
        addr      += n;
        remaining -= n;
    }
}

/**
  * @brief  Read one wallpaper pixel (RGB565) at screen coordinate (x,y).
  */
uint16_t Wallpaper_GetPixel(uint16_t x, uint16_t y)
{
    uint8_t  b[2];
    uint32_t addr = WALLPAPER_DATA_ADDR + (uint32_t)y * WALLPAPER_W * 2u + (uint32_t)x * 2u;
    SPI_FLASH_BufferRead(b, addr, 2);
    return (uint16_t)((b[0] << 8) | b[1]);   /* big-endian RGB565 in flash */
}

/**
  * @brief  Blend a solid foreground over a background pixel (both RGB565) by
  *         alpha/255. Integer math only (no FPU on F103); blends the 5-6-5
  *         channels in place.
  */
static uint16_t Wallpaper_BlendPixel(uint16_t bg, uint16_t fg, uint8_t alpha)
{
    uint32_t ia = 255u - (uint32_t)alpha;
    uint32_t r = ((uint32_t)((fg >> 11) & 0x1Fu) * alpha + (uint32_t)((bg >> 11) & 0x1Fu) * ia) / 255u;
    uint32_t g = ((uint32_t)((fg >> 5)  & 0x3Fu) * alpha + (uint32_t)((bg >> 5)  & 0x3Fu) * ia) / 255u;
    uint32_t b = ((uint32_t)( fg        & 0x1Fu) * alpha + (uint32_t)( bg        & 0x1Fu) * ia) / 255u;
    return (uint16_t)((r << 11) | (g << 5) | b);
}

/**
  * @brief  Is (px,py) inside a rounded rectangle [x,x+w) x [y,y+h) with radius r?
  *         Mirrors ui_fill_rounded() in gui_ui.c (center/left/right slabs + 4
  *         corner circles), so the translucent fill matches the opaque shape.
  */
static uint8_t Wallpaper_RoundedInside(int px, int py, int x, int y, int w, int h, int r)
{
    int x2 = x + w - 1, y2 = y + h - 1;
    if (r == 0 || w <= 2 * r || h <= 2 * r) {
        return 1;                       /* falls back to a plain rectangle */
    }
    if (px >= x + r && px <= x2 - r) {
        return 1;                       /* center slab (full height) */
    }
    if (py >= y + r && py <= y2 - r) {
        return 1;                       /* left/right slabs */
    }
    {
        int cx = (px < x + r) ? (x + r - 1) : (x2 - r + 1);
        int cy = (py < y + r) ? (y + r - 1) : (y2 - r + 1);
        int dx = px - cx, dy = py - cy;
        return (uint8_t)((dx * dx + dy * dy) <= (r * r));
    }
}

/**
  * @brief  Fill a rounded-rect region with `color` alpha-blended over the
  *         wallpaper. Pixels outside the rounded shape keep the wallpaper.
  */
void Wallpaper_BlendRoundedRect(uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                                uint8_t r, uint16_t color, uint8_t alpha)
{
    uint8_t  rowbuf[2 * WALLPAPER_W];
    uint16_t row, col;

    ILI9341_OpenWindow(x, y, w, h);
    ILI9341_Write_Cmd(CMD_SetPixel);

    for (row = 0; row < h; row++) {
        uint32_t addr = WALLPAPER_DATA_ADDR + (uint32_t)(y + row) * WALLPAPER_W * 2u + (uint32_t)x * 2u;
        SPI_FLASH_BufferRead(rowbuf, addr, (uint16_t)(w * 2));
        for (col = 0; col < w; col++) {
            uint16_t px = (uint16_t)(x + col), py = (uint16_t)(y + row);
            uint16_t bg = (uint16_t)((rowbuf[2 * col] << 8) | rowbuf[2 * col + 1]);
            uint8_t  a  = Wallpaper_RoundedInside((int)px, (int)py, (int)x, (int)y, (int)w, (int)h, (int)r) ? alpha : 0;
            ILI9341_Write_Data(Wallpaper_BlendPixel(bg, color, a));
        }
    }
}

/**
  * @brief  Draw a 1bpp bitmap over the wallpaper: set bits in `fg` (opaque),
  *         clear bits as the wallpaper alpha-blended with `tint`. Every pixel
  *         is written, so this is safe on the ILI9341 (no skipped writes).
  */
void Wallpaper_DrawBitmapBlend(uint16_t x, uint16_t y, uint16_t w, uint16_t h,
                               const uint8_t *bitmap, uint16_t fg,
                               uint16_t tint, uint8_t alpha)
{
    uint8_t  bytesPerRow = (uint8_t)((w + 7) / 8);
    uint16_t row, col;

    ILI9341_OpenWindow(x, y, w, h);
    ILI9341_Write_Cmd(CMD_SetPixel);

    for (row = 0; row < h; row++) {
        for (col = 0; col < w; col++) {
            if (bitmap[row * bytesPerRow + col / 8] & (0x80 >> (col & 0x07))) {
                ILI9341_Write_Data(fg);
            } else {
                uint16_t bg = Wallpaper_GetPixel((uint16_t)(x + col), (uint16_t)(y + row));
                ILI9341_Write_Data(Wallpaper_BlendPixel(bg, tint, alpha));
            }
        }
    }
}

/**
  * @brief  Receive the wallpaper and program it into W25Q64 (never returns).
  */
void WallpaperBurn_Mode(void)
{
    uint8_t  buf[WALLPAPER_BURN_CHUNK];
    uint32_t total, expected_crc, crc, done, addr, i;
    uint16_t n;

    printf("\r\nWALLPAPER: erase %d sectors @0x%X ...\r\n",
           WALLPAPER_BURN_SECTORS, (unsigned int)WALLPAPER_MAGIC_ADDR);
    for (i = 0; i < WALLPAPER_BURN_SECTORS; i++) {
        SPI_FLASH_SectorErase(WALLPAPER_MAGIC_ADDR + i * 4096);
    }
    printf("WALLPAPER: erase done\r\n");
    printf("WALLPAPER_BURN_READY\r\n");

    /* Header: total length + crc32 (both little-endian) */
    total        = WallpaperBurn_RxU32LE();
    expected_crc = WallpaperBurn_RxU32LE();
    printf("WALLPAPER: expecting %lu bytes\r\n", (unsigned long)total);

    if (total != WALLPAPER_SIZE) {
        printf("WALLPAPER_SIZE_ERR (expected %lu)\r\n", (unsigned long)WALLPAPER_SIZE);
        printf("WALLPAPER_BURN_DONE\r\n");
        while (1);
    }
    printf("LEN_OK\r\n");

    /* Receive + program, one chunk at a time, ACK each chunk */
    addr = WALLPAPER_DATA_ADDR;
    done = 0;
    crc  = 0xFFFFFFFFu;
    while (done < total) {
        n = (uint16_t)((total - done) > WALLPAPER_BURN_CHUNK ? WALLPAPER_BURN_CHUNK : (total - done));
        HAL_UART_Receive(&UartHandle, buf, n, 10000);
        SPI_FLASH_BufferWrite(buf, addr, n);
        for (i = 0; i < n; i++) {
            crc = WallpaperBurn_Crc32(crc, buf[i]);
        }
        addr += n;
        done += n;
        {
            uint8_t ack = 'K';
            HAL_UART_Transmit(&UartHandle, &ack, 1, 1000);
        }
    }

    crc ^= 0xFFFFFFFFu;      /* finalize CRC-32 (ISO-HDLC) */

    printf("\r\nWALLPAPER: programmed %lu bytes\r\n", (unsigned long)done);
    if (crc == expected_crc) {
        /* stamp the magic only after a verified burn */
        uint8_t magic[4] = { 'W', 'P', 'P', '1' };
        SPI_FLASH_BufferWrite(magic, WALLPAPER_MAGIC_ADDR, 4);
        printf("CRC_OK\r\n");
    } else {
        printf("CRC_FAIL\r\n");
    }
    printf("WALLPAPER_BURN_DONE\r\n");

    while (1);               /* stay in burn mode until reset */
}

static uint8_t WallpaperBurn_RxByte(void)
{
    uint8_t b = 0;
    HAL_UART_Receive(&UartHandle, &b, 1, 10000);
    return b;
}

static uint32_t WallpaperBurn_RxU32LE(void)
{
    uint32_t v = 0;
    int i;
    for (i = 0; i < 4; i++) {
        v |= (uint32_t)WallpaperBurn_RxByte() << (8 * i);
    }
    return v;
}

/* IEEE 802.3 CRC-32 (reflected, poly 0xEDB88320), matches Python zlib.crc32 */
static uint32_t WallpaperBurn_Crc32(uint32_t crc, uint8_t b)
{
    int k;
    crc ^= b;
    for (k = 0; k < 8; k++) {
        if (crc & 1u) {
            crc = (crc >> 1) ^ 0xEDB88320u;
        } else {
            crc >>= 1;
        }
    }
    return crc;
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
