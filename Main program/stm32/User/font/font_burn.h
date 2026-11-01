/**
  ******************************************************************************
  * @file    font_burn.h
  * @brief   Burn the GB2312 16x16 font library into W25Q64 over USART1
  ******************************************************************************
  */
#ifndef __FONT_BURN_H
#define __FONT_BURN_H

#include "stm32f1xx.h"

/* Burn the GB2312_H1616.FON font library into W25Q64 (blocking).
 * Call it instead of the normal GUI when FONT_BURN_MODE is enabled in main.c.
 * Host counterpart: tools/flash_font.py */
void FontBurn_Mode(void);

#endif /* __FONT_BURN_H */
