/* Host-only LCD adapter: executes unchanged particle_ui.c and real fonts/images. */
#include "particle_ui.h"
#include "../User/lcd/bsp_ili9341_lcd.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static uint16_t screen[320][240],back,fore,wx,wy,ww,wh;
static unsigned offset,image_windows,full_clears;
static uint32_t now;
static sFONT *font;
uint16_t LCD_X_LENGTH=240,LCD_Y_LENGTH=320;
uint32_t HAL_GetTick(void){return now;}
uint32_t ParticleLink_Errors(void){return 0;}
void LCD_SetBackColor(uint16_t c){back=c;}
void LCD_SetColors(uint16_t a,uint16_t b){fore=a;back=b;}
void LCD_SetFont(sFONT *p){font=p;}
void ILI9341_OpenWindow(uint16_t x,uint16_t y,uint16_t w,uint16_t h){assert(w&&h&&x+w<=240&&y+h<=320);wx=x;wy=y;ww=w;wh=h;offset=0;if(w==144&&h==96)image_windows++;}
void ILI9341_Write_Cmd(uint16_t c){assert(c==CMD_SetPixel);}
void ILI9341_Write_Data(uint16_t c){assert(offset<(unsigned)ww*wh);screen[wy+offset/ww][wx+offset%ww]=c;offset++;}
void ILI9341_Clear(uint16_t x,uint16_t y,uint16_t w,uint16_t h){unsigned a,b;assert(x+w<=240&&y+h<=320);if(w==240&&h==320)full_clears++;for(a=y;a<y+h;a++)for(b=x;b<x+w;b++)screen[a][b]=back;}
void ILI9341_DispString_EN(uint16_t x,uint16_t y,char *s){while(*s){unsigned i,n=(font->Width*font->Height)/8;const uint8_t *p=font->table+((unsigned char)*s-32)*n;ILI9341_OpenWindow(x,y,font->Width,font->Height);for(i=0;i<n*8;i++)ILI9341_Write_Data(p[i/8]&(0x80u>>(i%8))?fore:back);x+=font->Width;s++;}}
static void save(const char *name){FILE *f=fopen(name,"wb");unsigned x,y;assert(f);fprintf(f,"P6\n240 320\n255\n");for(y=0;y<320;y++)for(x=0;x<240;x++){uint16_t v=screen[y][x];fputc(((v>>11)&31)*255/31,f);fputc(((v>>5)&63)*255/63,f);fputc((v&31)*255/31,f);}fclose(f);}
static void check_numeric_tail(void){unsigned row,x,y;for(row=0;row<4;row++)for(y=192+20*row;y<208+20*row;y++)for(x=200;x<208;x++)assert(screen[y][x]==0x0863u);}
static void send(unsigned seq,unsigned result){ParticleMessage m={0};m.result=result;m.sequence=seq;m.flags=result?0:2;now+=10;ParticleUI_OnMessage(&m);}
int main(void){unsigned c,i,old;char name[100];ParticleUI_Init();save("verification/ui_boot.ppm");assert(full_clears==1);
for(c=1;c<=4;c++){send(c*30,0);for(i=0;i<20;i++){send(c*30+i+1,i<18?c:(c%4+1));check_numeric_tail();if(i==2){sprintf(name,"verification/ui_class%u_warmup.ppm",c);save(name);}}sprintf(name,"verification/ui_class%u_90pct.ppm",c);save(name);old=image_windows;send(c*30+20,c);assert(image_windows==old);}
send(200,0);save("verification/ui_empty.ppm");old=image_windows;now+=2000;ParticleUI_Poll();save("verification/ui_timeout.ppm");assert(old==image_windows);send(200,2);check_numeric_tail();save("verification/ui_recover.ppm");assert(full_clears==1);printf("UI_ALL_PASS: 12 snapshots, every draw within 240x320, one full clear, duplicates and unchanged winner do not redraw photos. numeric_tail_background=PASS image_windows=%u\n",image_windows);return 0;}
