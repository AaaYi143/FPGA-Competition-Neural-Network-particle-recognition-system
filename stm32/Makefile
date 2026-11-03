###############################################################################
# Makefile - GSM phone prototype (STM32F103RCT6), GCC toolchain.
#
# Builds the same sources as the Keil project but with arm-none-eabi-gcc,
# so there is NO 32 KB code-size limit.
#
# Command line (from this folder):
#     make            -> build/F103RC_Phone.elf / .hex / .bin
#     make clean
#
# In STM32CubeIDE: File > Import > C/C++ > Existing Code as Makefile Project,
# select "Cross ARM GCC" and this Makefile, then press Build (hammer icon).
#
# Toolchain: arm-none-eabi-gcc must be on PATH (STM32CubeIDE bundles it; or
# install "Arm GNU Toolchain"). Override PREFIX below if it lives elsewhere.
###############################################################################

TARGET    = F103RC_Particle_Display
SHELL = cmd.exe
BUILD_DIR = build_vote20

# ---- Toolchain ------------------------------------------------------------
PREFIX   = arm-none-eabi-
CC       = $(PREFIX)gcc
AS       = $(PREFIX)gcc -x assembler-with-cpp
OBJCOPY  = $(PREFIX)objcopy
SZ       = $(PREFIX)size
HEX      = $(OBJCOPY) -O ihex
BIN      = $(OBJCOPY) -O binary -S

# ---- CPU (STM32F103 = Cortex-M3, no FPU) ----------------------------------
MCU = -mcpu=cortex-m3 -mthumb

# ---- Build options ---------------------------------------------------------
OPT   = -Os          # optimise for debugging; use -O2 or -Os for release
DEBUG = -g3

# ---- Defines / includes (same as the Keil project) -------------------------
C_DEFS = -DUSE_HAL_DRIVER -DSTM32F103xE

C_INCLUDES = \
-ILibraries/CMSIS/Include \
-ILibraries/CMSIS/Device/ST/STM32F1xx/Include \
-ILibraries/STM32F1xx_HAL_Driver/Inc \
-IUser

# ---- Sources ----------------------------------------------------------------
# HAL: compile every module; unused ones are discarded by --gc-sections.
# ST ships *_template.c files (timebase TIM/RTC, msp) meant to be copied and
# edited, NOT built as-is: building them all yields duplicate HAL_InitTick /
# HAL_SuspendTick / HAL_ResumeTick symbols. Exclude them, like Keil does.
HAL_SOURCES  = $(wildcard Libraries/STM32F1xx_HAL_Driver/Src/*.c)
HAL_SOURCES := $(filter-out %_template.c, $(HAL_SOURCES))

# User/ includes its own system_stm32f1xx.c (the one Keil actually built),
# so we use it rather than the CMSIS template copy to mirror Keil exactly.
C_SOURCES = \
$(HAL_SOURCES) \
$(wildcard User/*.c) \
User/usart/bsp_debug_usart.c User/usart/syscalls.c \
User/led/bsp_led.c User/lcd/bsp_ili9341_lcd.c User/font/fonts.c \
User/flash/bsp_spi_flash.c \
$(wildcard User/particle/*.c)

ASM_SOURCES = startup/startup_stm32f103xe.s

# ---- Objects ----------------------------------------------------------------
OBJECTS  = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

# ---- Flags ------------------------------------------------------------------
CFLAGS  = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) $(DEBUG) -Wall \
          -fdata-sections -ffunction-sections -MMD -MP
ASFLAGS = $(MCU) $(C_INCLUDES) $(OPT) $(DEBUG) -Wall \
          -fdata-sections -ffunction-sections

LDSCRIPT = STM32F103RCTx_FLASH.ld
LDFLAGS  = $(MCU) -specs=nano.specs -T$(LDSCRIPT) \
           -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections \
           -Wl,--no-warn-rwx-segments

# ---- Rules ------------------------------------------------------------------
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(ASFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@

$(BUILD_DIR):
	if not exist "$(BUILD_DIR)" mkdir "$(BUILD_DIR)"

clean:
	@echo Use a new BUILD_DIR to rebuild; old artifacts are retained.

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean
