#ifndef PARTICLE_IMAGES_H
#define PARTICLE_IMAGES_H
#include <stdint.h>
#define PARTICLE_IMAGE_WIDTH 144u
#define PARTICLE_IMAGE_HEIGHT 96u
/* Zero-based model class: millet, pearl powder, fine salt, white sugar. */
extern const uint16_t particle_images[4][PARTICLE_IMAGE_WIDTH * PARTICLE_IMAGE_HEIGHT];
const uint16_t *ParticleImage_Get(uint8_t class_id);
#endif
