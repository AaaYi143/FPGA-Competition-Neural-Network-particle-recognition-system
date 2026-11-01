#include "particle_protocol.h"
#include "particle_vote.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define CHECK(x) do { if(!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); return 1; } } while(0)
static ParticleMessage msg(uint8_t seq,uint8_t result) { ParticleMessage m={0};m.sequence=seq;m.result=result;m.class_id=result?result-1u:255u;m.flags=result?0:2;m.version=2;return m; }
static void packet(uint8_t *p,uint8_t version,uint8_t sequence,uint8_t value,uint8_t flags) { p[0]=0xa5;p[1]=0x5a;p[2]=version;p[3]=sequence;p[4]=value;p[5]=flags;p[6]=Particle_CRC8(p+2,4);p[7]=13; }
static int feed(ParticleParser *p,const uint8_t *b,unsigned n,ParticleMessage *m) { int got=0;while(n--)got+=ParticleParser_Feed(p,*b++,m);return got; }
int main(int argc,char **argv) {
 ParticleParser p;ParticleVote v;ParticleMessage m;uint8_t b[8],bad[8];unsigned i,j,k,n=0,raw=0,wrap=0,last=0,results=0;FILE *f;
 ParticleParser_Init(&p);ParticleVote_Init(&v);
 for(i=0;i<1024;i++) { uint8_t r=i%5u;packet(b,2,(uint8_t)i,r,r?i%2u:2u);CHECK(feed(&p,b,i%8u,&m)==0);CHECK(feed(&p,b+i%8u,8-i%8u,&m)==1);CHECK(m.result==r && m.sequence==(uint8_t)i && m.version==2); }
 for(i=0;i<256;i++)for(j=0;j<4;j++) {packet(b,1,(uint8_t)i,j,(i%4u));CHECK(feed(&p,b,8,&m)==1);CHECK(m.result==((i&2u)?0:j+1u));}
 for(i=0;i<8;i++)for(j=0;j<8;j++){packet(b,2,12,3,0);memcpy(bad,b,8);bad[i]^=1u<<j;CHECK(feed(&p,bad,8,&m)==0);CHECK(feed(&p,b,8,&m)==1);}
 packet(b,2,0,5,0);CHECK(feed(&p,b,8,&m)==0);packet(b,2,0,0,0);CHECK(feed(&p,b,8,&m)==0);packet(b,2,0,2,2);CHECK(feed(&p,b,8,&m)==0);packet(b,1,0,4,0);CHECK(feed(&p,b,8,&m)==0);
 for(i=0;i<8;i++){packet(b,2,(uint8_t)i,1,0);CHECK(feed(&p,b,i,&m)==0);CHECK(feed(&p,b,8,&m)==1);}
 for(i=0;i<20;i++){m=msg(i,i<18?1:2);CHECK(ParticleVote_Accept(&v,&m,i));CHECK(v.count==i+1u);CHECK(v.winner==0);}
 CHECK(ParticleVote_Percent10(&v,0)==900 && ParticleVote_Percent10(&v,1)==100);
 CHECK(!ParticleVote_Accept(&v,&m,1000));CHECK(v.duplicates==1 && v.last_fresh_ms==19);
 CHECK(!ParticleVote_Expire(&v,2018));CHECK(ParticleVote_Expire(&v,2019));CHECK(!v.online && !v.count && !v.have_sequence);
 CHECK(ParticleVote_Accept(&v,&m,2020));CHECK(v.count==1 && v.winner==1);
 m=msg(20,0);CHECK(ParticleVote_Accept(&v,&m,2021));CHECK(v.empty && !v.count && v.winner==255 && v.online);
 m=msg(21,3);CHECK(ParticleVote_Accept(&v,&m,2022));CHECK(!v.empty && v.count==1 && v.winner==2);
 /* Previous winner tie: [3,4] retains 3. */
 m=msg(22,4);CHECK(ParticleVote_Accept(&v,&m,2023));CHECK(v.winner==2);
 /* FIFO reference for 10000 sliding votes. Keeps previous winner on ties,
    otherwise finds most recent tied class by independent linear history. */
 {uint8_t history[10000],counts[4];unsigned seed=7,old=255,win=255,start,c,mx,t;
 ParticleVote_Init(&v);
 for(i=0;i<10000;i++){
  seed=seed*1664525u+1013904223u;c=(seed>>24)&3u;history[i]=c;m=msg((uint8_t)i,c+1u);CHECK(ParticleVote_Accept(&v,&m,i*10u));
  memset(counts,0,4);start=i>=19?i-19:0;for(j=start;j<=i;j++)counts[history[j]]++;
  mx=0;for(j=0;j<4;j++)if(counts[j]>mx)mx=counts[j];
  if(old<4 && counts[old]==mx)win=old;else for(j=i+1;j>start;j--){t=history[j-1];if(counts[t]==mx){win=t;break;}}
  CHECK(v.winner==win && v.count==i-start+1);CHECK(!memcmp(v.votes,counts,4));old=win;
 }
 }
 /* Tick rollover and malformed direct caller. */
 ParticleVote_Init(&v);m=msg(255,4);CHECK(ParticleVote_Accept(&v,&m,0xfffffff0u));CHECK(!ParticleVote_Expire(&v,500));m=msg(0,3);CHECK(ParticleVote_Accept(&v,&m,600));CHECK(v.missing==0);m.result=9;CHECK(!ParticleVote_Accept(&v,&m,700));CHECK(ParticleVote_Expire(&v,2600));
 if(argc==2) {
  ParticleParser_Init(&p);ParticleVote_Init(&v);f=fopen(argv[1],"r");CHECK(f);while(fscanf(f,"%x",&k)==1){raw++;if(ParticleParser_Feed(&p,(uint8_t)k,&m)){if(n && m.sequence<last)wrap++;last=m.sequence;results|=1u<<m.result;CHECK(ParticleVote_Accept(&v,&m,n*10u));CHECK(v.count<=20);if(!m.result)CHECK(v.empty && !v.count);n++;}}
  fclose(f);CHECK(n==274);CHECK(raw==n*8);CHECK(wrap>=1);CHECK(results==31);CHECK(!p.rejected);printf("RTL_E2E_PASS packets=%u bytes=%u wraps=%u all_results_mask=%u gaps=%lu final_count=%u winner=%u\n",n,raw,wrap,results,(unsigned long)v.missing,v.count,v.winner);
 }
 printf("STM32_ALL_PASS v2=1024 v1=1024 bit_corruptions=64 random_fifo_votes=10000 warmup_18of20_90pct empty_duplicate_timeout_wrap_invalid_resync\n");return 0;
}
