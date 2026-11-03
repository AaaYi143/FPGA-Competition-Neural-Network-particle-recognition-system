#include "particle_vote.h"
#include <string.h>
static void clear_window(ParticleVote *v)
{
    memset(v->ring,0,sizeof(v->ring)); memset(v->votes,0,sizeof(v->votes));
    v->head=0; v->count=0; v->winner=255u;
}
void ParticleVote_Init(ParticleVote *v)
{ memset(v,0,sizeof(*v)); v->winner=255u; }
int ParticleVote_Expire(ParticleVote *v,uint32_t now)
{
    if(v->online && (uint32_t)(now-v->last_fresh_ms)>=PARTICLE_TIMEOUT_MS) {
        clear_window(v); v->online=0; v->empty=0; v->have_sequence=0;
        return 1;
    }
    return 0;
}
int ParticleVote_Accept(ParticleVote *v,const ParticleMessage *m,uint32_t now)
{
    uint8_t c,i,max_votes=0,previous;
    if(m->result>4u || (m->flags&0xFCu) ||
       ((m->result==0u)!=((m->flags&PARTICLE_FLAG_EMPTY)!=0u))) return 0;
    ParticleVote_Expire(v,now);
    previous=v->winner;
    if(v->have_sequence && m->sequence==v->sequence) { v->duplicates++; return 0; }
    if(v->have_sequence) v->missing+=(uint8_t)(m->sequence-v->sequence-1u);
    v->sequence=m->sequence; v->have_sequence=1; v->last_fresh_ms=now;
    v->online=1; v->flags=m->flags; v->accepted++;
    if(!m->result) { clear_window(v); v->empty=1; return 1; }
    v->empty=0; c=(uint8_t)(m->result-1u);
    if(v->count==PARTICLE_VOTE_SIZE) v->votes[v->ring[v->head]]--;
    else v->count++;
    v->ring[v->head]=c; v->head=(uint8_t)((v->head+1u)%PARTICLE_VOTE_SIZE);
    v->votes[c]++;
    for(i=0;i<PARTICLE_CLASS_COUNT;i++) if(v->votes[i]>max_votes) max_votes=v->votes[i];
    if(previous<PARTICLE_CLASS_COUNT && v->votes[previous]==max_votes) v->winner=previous;
    else for(i=0;i<v->count;i++) {
        c=v->ring[(v->head+PARTICLE_VOTE_SIZE-1u-i)%PARTICLE_VOTE_SIZE];
        if(v->votes[c]==max_votes) { v->winner=c; break; }
    }
    return 1;
}
uint16_t ParticleVote_Percent10(const ParticleVote *v,uint8_t c)
{
    return (v->count && c<PARTICLE_CLASS_COUNT)?
        (uint16_t)(((uint32_t)v->votes[c]*1000u+v->count/2u)/v->count):0u;
}
