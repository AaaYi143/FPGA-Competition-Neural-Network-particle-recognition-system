from pathlib import Path
import re,json,hashlib
root=Path(__file__).resolve().parents[1]
font=(root/'tests/GB2312_H1616.FON').read_bytes()
old=(root/'User/particle/particle_glyphs.h').read_text()
# Existing font includes standard GB2312 offset, verify against deployed glyph.
b='小'.encode('gb2312'); off=((b[0]-0xa1)*94+b[1]-0xa1)*32
hexes=re.search(r'0xD0A1u,\{([^}]+)',old).group(1)
assert bytes(int(v,16) for v in re.findall(r'0x([0-9A-Fa-f]{2})',hexes))==font[off:off+32]
chars='小米珍珠粉细盐白砂糖颗粒识别无连接超时临结果最近投票占比'
lines=['#ifndef PARTICLE_GLYPHS_H','#define PARTICLE_GLYPHS_H','#include <stdint.h>','#include <string.h>','typedef struct { uint16_t code; uint8_t pixels[32]; } ParticleGlyph;','static const ParticleGlyph particle_glyphs[] = {']
for c in dict.fromkeys(chars):
 b=c.encode('gb2312'); off=((b[0]-0xa1)*94+b[1]-0xa1)*32
 lines.append('{0x'+b.hex().upper()+'u,{'+','.join('0x%02X'%v for v in font[off:off+32])+'}},')
lines+=['};','static int ParticleGlyph_Get(uint16_t code,uint8_t out[32]) { unsigned i; for(i=0;i<sizeof(particle_glyphs)/sizeof(particle_glyphs[0]);i++) if(particle_glyphs[i].code==code) { memcpy(out,particle_glyphs[i].pixels,32); return 1; } memset(out,0,32); return 0; }','#endif']
(root/'User/particle/particle_glyphs.h').write_text('\n'.join(lines)+'\n')
(root/'tests/glyph_source.json').write_text(json.dumps({'source':'D:/32 board example GB2312_H1616.FON','sha256':hashlib.sha256(font).hexdigest(),'characters':''.join(dict.fromkeys(chars)),'glyph_bytes':len(dict.fromkeys(chars))*32},ensure_ascii=False,indent=2),encoding='utf-8')
p=root/'User/particle/particle_vote.c';s=p.read_text().replace('previous=v->winner;','previous;').replace('ParticleVote_Expire(v,now);','ParticleVote_Expire(v,now);\n    previous=v->winner;');p.write_text(s)
p=root/'User/main.c';s=p.read_text().replace('ID0 millet, ID1 pearl, ID2 salt, ID3 sugar; flags bit1: no particles','protocol v1/v2; RESULT 0 empty, 1 millet, 2 pearl, 3 salt, 4 sugar; latest 20 votes');p.write_text(s)
