#ifndef PARTICLE_LINK_H
#define PARTICLE_LINK_H
#include "particle_protocol.h"
void ParticleLink_Init(void);
int ParticleLink_Poll(ParticleMessage *message);
uint32_t ParticleLink_Errors(void);
#endif
