#ifndef __BSP_XPT2046_H
#define __BSP_XPT2046_H

#include "stm32f1xx_hal.h"

/* XPT2046 电阻触摸（野火 MINI 液晶接口，软件 SPI）
 * PC8 = DCLK   PC9 = CS    PC10 = DIN    PC11 = DOUT    PC12 = PENIRQ(低有效)
 */
#define XPT_DCLK_PORT    GPIOC
#define XPT_DCLK_PIN     GPIO_PIN_8
#define XPT_CS_PORT      GPIOC
#define XPT_CS_PIN       GPIO_PIN_9
#define XPT_DIN_PORT     GPIOC
#define XPT_DIN_PIN      GPIO_PIN_10
#define XPT_DOUT_PORT    GPIOC
#define XPT_DOUT_PIN     GPIO_PIN_11
#define XPT_PENIRQ_PORT  GPIOC
#define XPT_PENIRQ_PIN   GPIO_PIN_12

#define XPT_RAW_MIN      0
#define XPT_RAW_MAX      4095

/* 屏幕分辨率（跟随 ILI9341_GramScan 的横竖屏而定，横屏 240x320） */
#define XPT_SCREEN_W     240
#define XPT_SCREEN_H     320

typedef struct {
    uint16_t x;   /* 屏幕像素坐标 */
    uint16_t y;
} TouchPoint_t;

void    XPT2046_Init(void);
uint8_t XPT2046_IsPressed(void);                  /* 1=按下 */
uint8_t XPT2046_ReadXY(TouchPoint_t *pt);         /* 读取+中值滤波，返回 0=无效 */
void    XPT2046_GetRaw(uint16_t *rx, uint16_t *ry); /* 强制读原始 ADC（调试用，不判断 PEN） */

/* ---- 触摸校准（三点仿射变换，系数存 W25Q64） ----
 * 竖屏（GramScan 6）下触摸面板相对屏幕旋转了 90°，且轴可能翻转/交换/有偏移，
 * 朴素映射无法使用。校准用三点求仿射变换，把原始 ADC (rx,ry) 映射到屏幕 (sx,sy)：
 *     sx = (a*rx + b*ry + c) >> 16
 *     sy = (d*rx + e*ry + f) >> 16
 * 六个系数为 Q16 定点数，自动涵盖旋转/翻转/交换/缩放/偏移。
 */
#define XPT_CALIB_ADDR      0x207000UL        /* 字库+壁纸之后的首个空闲 4KB 扇区 */
#define XPT_CALIB_MAGIC     0x58435054UL      /* "XCPT" */

typedef struct {
    int32_t a, b, c;      /* sx = (a*rx + b*ry + c) >> 16 */
    int32_t d, e, f;      /* sy = (d*rx + e*ry + f) >> 16 */
} XptCalib_t;

uint8_t XPT2046_Calib_Load(void);                                  /* 从 Flash 读校准，成功返回 1 */
void    XPT2046_Calib_Save(void);                                  /* 把当前校准写入 Flash */
uint8_t XPT2046_Calib_Compute(const uint16_t sx[3], const uint16_t sy[3],
                              const uint16_t rx[3], const uint16_t ry[3]);  /* 三点求仿射系数 */

#endif /* __BSP_XPT2046_H */
