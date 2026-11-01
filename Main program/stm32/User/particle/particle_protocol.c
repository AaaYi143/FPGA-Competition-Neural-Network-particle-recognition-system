#include "particle_protocol.h"
#include <string.h>
uint8_t Particle_CRC8(const uint8_t *data, uint8_t length)
{
    uint8_t crc=0, i, j;
    for(i=0;i<length;i++) {
        crc^=data[i];
        for(j=0;j<8;j++) crc=(uint8_t)((crc&0x80u)?(((unsigned)crc<<1)^0x07u):((unsigned)crc<<1));
    }
    return crc;
}
void ParticleParser_Init(ParticleParser *parser) { memset(parser,0,sizeof(*parser)); }
int ParticleParser_Feed(ParticleParser *p, uint8_t byte, ParticleMessage *m)
{
    if(p->length==PARTICLE_PACKET_SIZE) {
        memmove(p->window,p->window+1,PARTICLE_PACKET_SIZE-1u);
        p->length--;
    }
    p->window[p->length++]=byte;
    if(p->length<PARTICLE_PACKET_SIZE) return 0;
    if(p->window[0]!=0xA5u || p->window[1]!=0x5Au) return 0;
    if((p->window[2]!=1u && p->window[2]!=2u) ||
       (p->window[2]==1u && p->window[4]>=PARTICLE_CLASS_COUNT) ||
       (p->window[2]==2u && (p->window[4]>PARTICLE_CLASS_COUNT ||
          ((p->window[4]==0u)!=((p->window[5]&PARTICLE_FLAG_EMPTY)!=0u)))) ||
       (p->window[5]&0xFCu)!=0u || p->window[7]!=0x0Du ||
       Particle_CRC8(p->window+2,4)!=p->window[6]) {
        p->rejected++;
        return 0;
    }
    m->sequence=p->window[3]; m->flags=p->window[5]; m->version=p->window[2];
    m->result=(m->flags&PARTICLE_FLAG_EMPTY)?0u:
        ((m->version==1u)?(uint8_t)(p->window[4]+1u):p->window[4]);
    m->class_id=m->result?(uint8_t)(m->result-1u):255u;
    p->accepted++;
    p->length=0;
    return 1;
}
