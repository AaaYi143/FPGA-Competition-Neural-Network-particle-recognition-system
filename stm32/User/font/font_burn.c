/**
  ******************************************************************************
  * @file    font_burn.c
  * @brief   Burn the GB2312 16x16 font library (GB2312_H1616.FON) into W25Q64
  *          over USART1 (115200 8-N-1). Host counterpart: tools/flash_font.py
  *
  * Protocol (host -> board):
  *   [4B total_len LE][4B crc32 LE]   then   raw data in <= FONT_BURN_CHUNK chunks
  * The board ACKs each chunk with a single 'K' byte, then prints
  * "CRC_OK" or "CRC_FAIL" followed by "FONT_BURN_DONE".
  ******************************************************************************
  */
#include "./font/font_burn.h"
#include "./font/fonts.h"
#include "./flash/bsp_spi_flash.h"
#include "./usart/bsp_debug_usart.h"

#define FONT_BURN_CHUNK     512
#define FONT_BURN_SECTORS   64      /* 64 * 4KB = 256KB >= 261,698 bytes */

static uint8_t  FontBurn_RxByte (void);
static uint32_t FontBurn_RxU32LE(void);
static uint32_t FontBurn_Crc32  (uint32_t crc, uint8_t b);

/**
  * @brief  Receive the font library and program it into W25Q64 (never returns).
  */
void FontBurn_Mode(void)
{
    uint8_t  buf[FONT_BURN_CHUNK];
    uint32_t total, expected_crc, crc, done, addr, i;
    uint16_t n;

    /* Erase the sector range that will hold the font library */
    printf("\r\nFONT_BURN: erase %d sectors @0x%X ...\r\n",
           FONT_BURN_SECTORS, (unsigned int)GBKCODE_START_ADDRESS);
    for (i = 0; i < FONT_BURN_SECTORS; i++) {
        SPI_FLASH_SectorErase(GBKCODE_START_ADDRESS + i * 4096);
    }
    printf("FONT_BURN: erase done\r\n");
    printf("FONT_BURN_READY\r\n");

    /* Header: total length + crc32 (both little-endian) */
    total        = FontBurn_RxU32LE();
    expected_crc = FontBurn_RxU32LE();
    printf("FONT_BURN: expecting %lu bytes\r\n", (unsigned long)total);
    printf("LEN_OK\r\n");

    /* Receive + program, one chunk at a time, ACK each chunk */
    addr = GBKCODE_START_ADDRESS;
    done = 0;
    crc  = 0xFFFFFFFFu;
    while (done < total) {
        n = (uint16_t)((total - done) > FONT_BURN_CHUNK ? FONT_BURN_CHUNK : (total - done));
        HAL_UART_Receive(&UartHandle, buf, n, 10000);
        SPI_FLASH_BufferWrite(buf, addr, n);
        for (i = 0; i < n; i++) {
            crc = FontBurn_Crc32(crc, buf[i]);
        }
        addr += n;
        done += n;
        {
            uint8_t ack = 'K';
            HAL_UART_Transmit(&UartHandle, &ack, 1, 1000);
        }
    }

    crc ^= 0xFFFFFFFFu;      /* finalize CRC-32 (ISO-HDLC) */

    printf("\r\nFONT_BURN: programmed %lu bytes\r\n", (unsigned long)done);
    if (crc == expected_crc) {
        printf("CRC_OK\r\n");
    } else {
        printf("CRC_FAIL\r\n");
    }
    printf("FONT_BURN_DONE\r\n");

    while (1);               /* stay in burn mode until reset */
}

static uint8_t FontBurn_RxByte(void)
{
    uint8_t b = 0;
    HAL_UART_Receive(&UartHandle, &b, 1, 10000);
    return b;
}

static uint32_t FontBurn_RxU32LE(void)
{
    uint32_t v = 0;
    int i;
    for (i = 0; i < 4; i++) {
        v |= (uint32_t)FontBurn_RxByte() << (8 * i);
    }
    return v;
}

/* IEEE 802.3 CRC-32 (reflected, poly 0xEDB88320), matches Python zlib.crc32 */
static uint32_t FontBurn_Crc32(uint32_t crc, uint8_t b)
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
