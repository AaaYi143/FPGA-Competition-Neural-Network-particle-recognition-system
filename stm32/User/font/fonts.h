#ifndef __FONT_H
#define __FONT_H       

#include "stm32f1xx.h"


#define LINE(x) ((x) * (((sFONT *)LCD_GetFont())->Height))
#define LINEY(x) ((x) * (((sFONT *)LCD_GetFont())->Width))

/** @defgroup FONTS_Exported_Types
  * @{
  */ 
typedef struct _tFont
{    
  const uint8_t *table;
  uint16_t Width;
  uint16_t Height;
  
} sFONT;

extern sFONT Font24x32;
extern sFONT Font16x24;
extern sFONT Font8x16;

/******************* 中文字符 ****************************/
/* GB2312 16x16 点阵字库（存于外部 W25Q64），字符格宽高 */
#define      WIDTH_CH_CHAR                      16
#define      HEIGHT_CH_CHAR                     16

/* 0 = SD 卡字库；1 = 外部 FLASH 字库（本项目用 W25Q64） */
#define      GBKCODE_FLASH                      1

#if GBKCODE_FLASH
	/* GB2312_H1616.FON 烧写于 W25Q64 的 406*4096 地址处（见野火外部存储器规划表） */
	#define GBKCODE_START_ADDRESS               406*4096

	/* 从外部 FLASH 读取单个汉字（GB2312 编码）的 32 字节点阵到 ucBuffer */
	#define GetGBKCode( ucBuffer, usChar )      GetGBKCode_from_EXFlash( ucBuffer, usChar )
	int GetGBKCode_from_EXFlash( uint8_t * pBuffer, uint16_t c );
#endif


#endif /*end of __FONT_H    */
