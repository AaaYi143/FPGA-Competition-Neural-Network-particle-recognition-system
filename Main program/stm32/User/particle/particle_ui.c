/* Direct-to-LCD rendering. No full-screen RAM buffer, no rendering in ISR. */
#include "particle_ui.h"
#include "particle_link.h"
#include "particle_vote.h"
#include "particle_images.h"
#include "particle_glyphs.h"
#include "../lcd/bsp_ili9341_lcd.h"
#include <stdio.h>
#define UI_BG 0x0863u
#define UI_ACCENT 0x06B8u
#define UI_TEXT 0xFFFFu
#define UI_MUTED 0xAD75u
static const char *names[4]={"\xD0\xA1\xC3\xD7","\xD5\xE4\xD6\xE9\xB7\xDB","\xCF\xB8\xD1\xCE","\xB0\xD7\xC9\xB0\xCC\xC7"};
static ParticleVote vote;
static uint8_t rendered=254u,dirty=1;
static void fill(uint16_t x,uint16_t y,uint16_t w,uint16_t h,uint16_t color)
{ LCD_SetBackColor(color); ILI9341_Clear(x,y,w,h); }
static void text(uint16_t x,uint16_t y,const char *s,uint16_t fg,uint16_t bg)
{ LCD_SetFont(&Font8x16); LCD_SetColors(fg,bg); ILI9341_DispString_EN(x,y,(char *)s); }
static void chinese(uint16_t x,uint16_t y,const char *s,uint8_t scale,uint16_t fg,uint16_t bg)
{
    const uint8_t *p=(const uint8_t *)s;
    uint8_t bitmap[32],row,col,sy,sx;
    while(p[0] && p[1]) {
        ParticleGlyph_Get(((uint16_t)p[0]<<8)|p[1],bitmap);
        ILI9341_OpenWindow(x,y,16u*scale,16u*scale); ILI9341_Write_Cmd(CMD_SetPixel);
        for(row=0;row<16;row++) for(sy=0;sy<scale;sy++)
            for(col=0;col<16;col++) for(sx=0;sx<scale;sx++)
                ILI9341_Write_Data((bitmap[2u*row+(col>>3)]&(0x80u>>(col&7u)))?fg:bg);
        x+=16u*scale; p+=2;
    }
}
static void render_result(void)
{
    uint8_t state=vote.online?(vote.empty?4u:vote.winner):255u,i;
    char line[32];
    if(state!=rendered) {
        const uint16_t *pixels;
        uint32_t n;
        rendered=state;
        fill(0,26,240,144,UI_BG);
        if(state<4u) {
            chinese(16,30,names[state],2,UI_TEXT,UI_BG);
            snprintf(line,sizeof(line),"#%u",(unsigned)state+1u); text(200,38,line,UI_ACCENT,UI_BG);
            pixels=ParticleImage_Get(state);
            ILI9341_OpenWindow(48,70,PARTICLE_IMAGE_WIDTH,PARTICLE_IMAGE_HEIGHT); ILI9341_Write_Cmd(CMD_SetPixel);
            for(n=0;n<PARTICLE_IMAGE_WIDTH*PARTICLE_IMAGE_HEIGHT;n++) ILI9341_Write_Data(pixels[n]);
        } else {
            chinese(16,34,state==4u?"\xCE\xDE\xBF\xC5\xC1\xA3":"\xC1\xAC\xBD\xD3\xB3\xAC\xCA\xB1",2,UI_TEXT,UI_BG);
            text(96,102,"----",UI_MUTED,UI_BG);
        }
    }
    for(i=0;i<4;i++) {
        uint16_t y=(uint16_t)(192u+20u*i),p=ParticleVote_Percent10(&vote,i);
        fill(104,y,128,16,UI_BG); /* Remove placeholder / shorter number tails. */
        if(vote.count) snprintf(line,sizeof(line),"%3u.%u%% %2u/%2u",p/10u,p%10u,(unsigned)vote.votes[i],(unsigned)vote.count);
        else snprintf(line,sizeof(line),"  --    --/--");
        text(104,y,line,(vote.winner==i)?UI_ACCENT:UI_TEXT,UI_BG);
    }
    fill(8,274,224,18,UI_BG);
    chinese(8,274,vote.count<20u?"\xC1\xD9\xCA\xB1\xBD\xE1\xB9\xFB":"\xD7\xEE\xBD\xFC\xBD\xE1\xB9\xFB",1,UI_MUTED,UI_BG);
    snprintf(line,sizeof(line),"%2u/20",(unsigned)vote.count); text(88,274,line,UI_TEXT,UI_BG);
    fill(8,298,224,18,UI_BG);
    snprintf(line,sizeof(line),"%s S:%03u BG:%u E:%lu",vote.online?"LINK OK":"TIMEOUT",(unsigned)vote.sequence,(unsigned)(vote.flags&1u),(unsigned long)(ParticleLink_Errors()%10000u));
    text(8,298,line,vote.online?UI_ACCENT:UI_MUTED,UI_BG);
}
void ParticleUI_Init(void)
{
    uint8_t i;
    ParticleVote_Init(&vote); rendered=254u; dirty=1;
    fill(0,0,240,320,UI_BG); fill(0,0,240,24,UI_ACCENT);
    text(8,4,"FPGA PARTICLE / VOTE20",BLACK,UI_ACCENT);
    chinese(8,172,"\xCD\xB6\xC6\xB1\xD5\xBC\xB1\xC8",1,UI_ACCENT,UI_BG);
    text(88,172,"VOTE SHARE",UI_MUTED,UI_BG);
    for(i=0;i<4;i++) {
        char number[4]; snprintf(number,sizeof(number),"%u",(unsigned)i+1u);
        text(8,192u+20u*i,number,UI_TEXT,UI_BG); chinese(24,192u+20u*i,names[i],1,UI_TEXT,UI_BG);
    }
    ParticleUI_Poll();
}
void ParticleUI_OnMessage(const ParticleMessage *m)
{
    if(ParticleVote_Accept(&vote,m,HAL_GetTick())) { dirty=1; ParticleUI_Poll(); }
}
void ParticleUI_Poll(void)
{
    if(ParticleVote_Expire(&vote,HAL_GetTick())) dirty=1;
    if(dirty) { dirty=0; render_result(); }
}
