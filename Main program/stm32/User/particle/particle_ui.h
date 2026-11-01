#ifndef PARTICLE_UI_H
#define PARTICLE_UI_H
#include "particle_protocol.h"
void ParticleUI_Init(void);
void ParticleUI_OnMessage(const ParticleMessage *message);
void ParticleUI_Poll(void);
#endif
