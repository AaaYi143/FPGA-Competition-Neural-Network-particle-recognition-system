#ifndef PARTICLE_VOTE_H
#define PARTICLE_VOTE_H
#include "particle_protocol.h"
#define PARTICLE_VOTE_SIZE 20u
#define PARTICLE_TIMEOUT_MS 2000u
typedef struct {
    uint8_t ring[PARTICLE_VOTE_SIZE], votes[PARTICLE_CLASS_COUNT];
    uint8_t head, count, winner, online, empty, have_sequence, sequence, flags;
    uint32_t last_fresh_ms, accepted, duplicates, missing;
} ParticleVote;
void ParticleVote_Init(ParticleVote *v);
int ParticleVote_Expire(ParticleVote *v, uint32_t now);
int ParticleVote_Accept(ParticleVote *v, const ParticleMessage *m, uint32_t now);
/* Tenths of a percent, rounded to nearest. Empty/offline returns 0. */
uint16_t ParticleVote_Percent10(const ParticleVote *v, uint8_t class_id);
#endif
