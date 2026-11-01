#include "./touch/bsp_xpt2046.h"
#include "./flash/bsp_spi_flash.h"
#include <stdio.h>

/* ---- 校准状态（RAM）---- */
static XptCalib_t s_calib;
static uint8_t    s_calib_valid;
static void XPT2046_ApplyCalib(uint16_t rx, uint16_t ry, uint16_t *sx, uint16_t *sy);

/* XPT2046 控制字（12bit、差分模式）
 * 若触摸坐标 XY 颠倒，交换下面两个宏即可
 */
#define XPT_CMD_X  0xD0
#define XPT_CMD_Y  0x90

/* ---- 软件 SPI 底层 ---- */
#define XPT_CS_LOW()    (XPT_CS_PORT->BRR   = XPT_CS_PIN)
#define XPT_CS_HIGH()   (XPT_CS_PORT->BSRR  = XPT_CS_PIN)
#define XPT_CLK_H()     (XPT_DCLK_PORT->BSRR = XPT_DCLK_PIN)
#define XPT_CLK_L()     (XPT_DCLK_PORT->BRR  = XPT_DCLK_PIN)
#define XPT_DIN_H()     (XPT_DIN_PORT->BSRR  = XPT_DIN_PIN)
#define XPT_DIN_L()     (XPT_DIN_PORT->BRR   = XPT_DIN_PIN)
#define XPT_DOUT()      ((XPT_DOUT_PORT->IDR & XPT_DOUT_PIN) ? 1u : 0u)
#define XPT_PEN()       ((XPT_PENIRQ_PORT->IDR & XPT_PENIRQ_PIN) ? 0u : 1u) /* 低有效 */

static void XPT_Delay(void)
{
    /* 约 0.6us @72MHz（DCLK ≈ 800kHz，仍低于 XPT2046 的 2.25MHz 上限） */
    for (volatile uint32_t i = 0; i < 12; i++) { __NOP(); }
}

void XPT2046_Init(void)
{
    GPIO_InitTypeDef g = {0};
    __HAL_RCC_GPIOC_CLK_ENABLE();

    /* 输入：DOUT、PENIRQ */
    g.Pin  = XPT_DOUT_PIN | XPT_PENIRQ_PIN;
    g.Mode = GPIO_MODE_INPUT;
    g.Pull = GPIO_PULLUP;              /* PENIRQ 上拉，未按下为高 */
    HAL_GPIO_Init(XPT_DOUT_PORT, &g);

    /* 输出：DCLK、CS、DIN */
    g.Pin   = XPT_DCLK_PIN | XPT_CS_PIN | XPT_DIN_PIN;
    g.Mode  = GPIO_MODE_OUTPUT_PP;
    g.Speed = GPIO_SPEED_FREQ_HIGH;
    g.Pull  = GPIO_NOPULL;
    HAL_GPIO_Init(XPT_DCLK_PORT, &g);

    XPT_CS_HIGH();
    XPT_CLK_L();
}

uint8_t XPT2046_IsPressed(void)
{
    return XPT_PEN();
}

/* 读一路 12bit：先发 8bit 控制字（MSB 先行，上升沿锁存），
 * 再读 12bit（下降沿出数据，读到 DOUT 上）
 */
static uint16_t XPT_ReadChannel(uint8_t cmd)
{
    uint16_t value = 0;

    XPT_CS_LOW();
    XPT_Delay();                         /* CS 建立时间 */

    for (uint8_t i = 0; i < 8; i++) {
        if (cmd & 0x80) XPT_DIN_H(); else XPT_DIN_L();
        cmd <<= 1;
        XPT_CLK_H(); XPT_Delay(); XPT_CLK_L(); XPT_Delay();
    }
    for (uint8_t i = 0; i < 12; i++) {
        XPT_CLK_H(); XPT_Delay(); XPT_CLK_L(); XPT_Delay();
        value <<= 1;
        if (XPT_DOUT()) value |= 1u;
    }

    XPT_CS_HIGH();
    return value;
}

/* 3 次采样取中值（比 5 次更快，兼顾消抖） */
static uint16_t XPT_Filter(uint8_t cmd)
{
    uint16_t s[3];
    for (uint8_t i = 0; i < 3; i++) s[i] = XPT_ReadChannel(cmd);
    for (uint8_t i = 0; i < 2; i++)
        for (uint8_t j = 0; j < 2 - i; j++)
            if (s[j] > s[j + 1]) { uint16_t t = s[j]; s[j] = s[j + 1]; s[j + 1] = t; }
    return s[1];
}

uint8_t XPT2046_ReadXY(TouchPoint_t *pt)
{
    uint16_t rx, ry;

    if (!XPT_PEN()) return 0;          /* 未按下 */
    rx = XPT_Filter(XPT_CMD_X);
    ry = XPT_Filter(XPT_CMD_Y);

    if (s_calib_valid) {
        XPT2046_ApplyCalib(rx, ry, &pt->x, &pt->y);
    } else {
        /* 未校准时用朴素映射（仅供调试，竖屏下方向会错） */
        pt->x = (uint16_t)((uint32_t)rx * XPT_SCREEN_W / 4096);
        pt->y = (uint16_t)((uint32_t)ry * XPT_SCREEN_H / 4096);
    }
    return 1;
}

/* 调试：不判断 PENIRQ，强制读一次原始 ADC，用于确认 XPT2046 是否接好 */
void XPT2046_GetRaw(uint16_t *rx, uint16_t *ry)
{
    *rx = XPT_Filter(XPT_CMD_X);
    *ry = XPT_Filter(XPT_CMD_Y);
}

/* ====================== 触摸校准 ====================== */

/* Q16 定点仿射：sx = (a*rx + b*ry + c) >> 16 */
static void XPT2046_ApplyCalib(uint16_t rx, uint16_t ry, uint16_t *sx, uint16_t *sy)
{
    int32_t x = (int32_t)(((int64_t)s_calib.a * rx + (int64_t)s_calib.b * ry + s_calib.c) >> 16);
    int32_t y = (int32_t)(((int64_t)s_calib.d * rx + (int64_t)s_calib.e * ry + s_calib.f) >> 16);

    if (x < 0) x = 0; else if (x >= XPT_SCREEN_W) x = XPT_SCREEN_W - 1;
    if (y < 0) y = 0; else if (y >= XPT_SCREEN_H) y = XPT_SCREEN_H - 1;
    *sx = (uint16_t)x;
    *sy = (uint16_t)y;
}

/* 3x3 整数行列式（int64 防溢出）。F103 无 FPU，用整数避免软浮点库拖大代码。 */
static int64_t XPT_det3i(int64_t a, int64_t b, int64_t c,
                         int64_t d, int64_t e, int64_t f,
                         int64_t g, int64_t h, int64_t i)
{
    return a * (e * i - f * h)
         - b * (d * i - f * g)
         + c * (d * h - e * g);
}

/* (n/d) 的 Q16 定点表示：(n*65536)/d。截断误差 < 1/65536（亚像素级），可忽略。 */
static int32_t XPT_q16i(int64_t n, int64_t d)
{
    return (int32_t)((n * 65536) / d);
}

/* 三点仿射：解 6 元线性方程组（Cramer 法则），结果写入 s_calib 并置 valid。
 * 三点必须不共线；返回 1 成功，0 失败（退化）。
 */
uint8_t XPT2046_Calib_Compute(const uint16_t sx[3], const uint16_t sy[3],
                              const uint16_t rx[3], const uint16_t ry[3])
{
    int64_t r0 = rx[0], r1 = rx[1], r2 = rx[2];
    int64_t y0 = ry[0], y1 = ry[1], y2 = ry[2];
    int64_t x0 = sx[0], x1 = sx[1], x2 = sx[2];
    int64_t n0 = sy[0], n1 = sy[1], n2 = sy[2];
    int64_t det;

    det = XPT_det3i(r0, y0, 1, r1, y1, 1, r2, y2, 1);
    if (det == 0) {
        s_calib_valid = 0;
        return 0;                      /* 三点共线 / 点重合 */
    }

    s_calib.a = XPT_q16i(XPT_det3i(x0, y0, 1, x1, y1, 1, x2, y2, 1), det);
    s_calib.b = XPT_q16i(XPT_det3i(r0, x0, 1, r1, x1, 1, r2, x2, 1), det);
    s_calib.c = XPT_q16i(XPT_det3i(r0, y0, x0, r1, y1, x1, r2, y2, x2), det);
    s_calib.d = XPT_q16i(XPT_det3i(n0, y0, 1, n1, y1, 1, n2, y2, 1), det);
    s_calib.e = XPT_q16i(XPT_det3i(r0, n0, 1, r1, n1, 1, r2, n2, 1), det);
    s_calib.f = XPT_q16i(XPT_det3i(r0, y0, n0, r1, y1, n1, r2, y2, n2), det);

    s_calib_valid = 1;
    return 1;
}

/* 校准存储布局：XPT_CALIB_ADDR 处 [magic(4B)][XptCalib_t(24B)] */
typedef struct {
    uint32_t   magic;
    XptCalib_t calib;
} XptCalibBlob_t;

uint8_t XPT2046_Calib_Load(void)
{
    XptCalibBlob_t blob;

    SPI_FLASH_BufferRead((uint8_t *)&blob, XPT_CALIB_ADDR, sizeof(blob));
    if (blob.magic != XPT_CALIB_MAGIC) {
        s_calib_valid = 0;
        return 0;
    }
    s_calib      = blob.calib;
    s_calib_valid = 1;
    return 1;
}

void XPT2046_Calib_Save(void)
{
    XptCalibBlob_t blob;

    if (!s_calib_valid) return;
    blob.magic = XPT_CALIB_MAGIC;
    blob.calib = s_calib;

    SPI_FLASH_SectorErase(XPT_CALIB_ADDR);
    SPI_FLASH_BufferWrite((uint8_t *)&blob, XPT_CALIB_ADDR, sizeof(blob));
}
