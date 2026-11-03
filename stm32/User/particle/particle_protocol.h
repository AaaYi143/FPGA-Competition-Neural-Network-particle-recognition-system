#ifndef PARTICLE_PROTOCOL_H
#define PARTICLE_PROTOCOL_H
#include <stdint.h>
#define PARTICLE_PACKET_SIZE 8u
#define PARTICLE_CLASS_COUNT 4u
#define PARTICLE_FLAG_EMPTY 2u
typedef struct {
    uint8_t sequence, class_id, flags;
    /* Normalized wire result: 0 empty, 1..4 materials. class_id is 0..3,
       or 255 when empty. version preserves v1/v2 provenance. */
    uint8_t result, version;
} ParticleMessage;
typedef struct {
    uint8_t window[PARTICLE_PACKET_SIZE];
    uint8_t length;
    uint32_t accepted, rejected;
} ParticleParser;
void ParticleParser_Init(ParticleParser *parser);
uint8_t Particle_CRC8(const uint8_t *data, uint8_t length);
int ParticleParser_Feed(ParticleParser *parser, uint8_t byte, ParticleMessage *message);
#endif
