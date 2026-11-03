#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
mkdir -p verification
gcc -std=c99 -Wall -Wextra -Werror -fsanitize=address,undefined -g -IUser/particle tests/test_vote_protocol.c User/particle/particle_protocol.c User/particle/particle_vote.c -o verification/test_vote_protocol
./verification/test_vote_protocol "${1:-../verification/stm_uart_bytes.txt}" > verification/vote_protocol_test.log
gcc -std=c99 -ffunction-sections -fdata-sections -Wl,--gc-sections -Wall -Wextra -Wno-int-to-pointer-cast -Wno-pointer-to-int-cast -fsanitize=address,undefined -g -DSTM32F103xE -DUSE_HAL_DRIVER -IUser/particle -IUser -ILibraries/CMSIS/Include -ILibraries/CMSIS/Device/ST/STM32F1xx/Include -ILibraries/STM32F1xx_HAL_Driver/Inc tests/test_ui_render.c User/particle/particle_ui.c User/particle/particle_vote.c User/particle/particle_images.c User/font/fonts.c -o verification/test_ui_render
./verification/test_ui_render > verification/ui_test.log
cat verification/vote_protocol_test.log verification/ui_test.log
