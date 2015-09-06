##########################################################################
# User configuration and firmware specific object files
##########################################################################

# The target, flash and ram of the LPC1xxx microprocessor.
# Use for the target the value: LPC11xx, LPC13xx or LPC17xx
TARGET = LPC11xx
# FLASH = 32K
FLASH = 16K
SRAM = 4K

# For USB support the LPC1xxx reserves 384 bytes from the sram,
# if you don't want to use the USB features, just use 0 here.
SRAM_USB = 0

VPATH =
OBJS = main.o

##########################################################################
# Debug settings
##########################################################################

# Set DEBUGBUILD to 'TRUE' for full debugging (larger, slower binaries),
# or to 'FALSE' for release builds (smallest, fastest binaries)
DEBUGBUILD = FALSE

##########################################################################
# IDE Flags (Keeps various IDEs happy)
##########################################################################
OPTDEFINES = -D __NEWLIB__

##########################################################################
# Project-specific files
##########################################################################
VPATH += core/cmd/commands/ core/cmd/commands/cmd_deepsleep.c
VPATH += core/cmd/commands/cmd_reset.c core/cmd/commands/cmd_sysinfo.c
OBJS  += cmd_deepsleep.o cmd_sysinfo.o cmd_reset.o

#VPATH += core/cmd/commands/cmd_ls.c core/cmd/commands/cmd_rm.c
#VPATH += core/cmd/commands/cmd_less.c cor/cmd/commands/cmd_write.c
#OBJS  += cmd_ls.o cmd_rm.o cmd_less.o cmd_write.o

##########################################################################
# Optional driver files
##########################################################################
VPATH += drivers/sensors/bno055
OBJS += bno055.o

VPATH += drivers/sensors/bmp180
OBJS += bmp180.o

VPATH += drivers/sensors/mtk3339
OBJS += mtk3339.o

VPATH += drivers/ulogfs
OBJS += ulogfs.o

VPATH += drivers/flash/w25qxx
OBJS += w25qxx.o

##########################################################################
# Library files
##########################################################################
VPATH += core core/adc core/cpu core/gpio core/i2c core/pmu
VPATH += core/ssp core/systick core/timer16 core/timer32 core/uart
VPATH += core/libc core/wdt core/iap core/cmd

OBJS += adc.o cpu.o gpio.o i2c.o pmu.o ssp.o systick.o timer16.o
OBJS += timer32.o uart.o uart_buf.o stdio.o string.o wdt.o sysinit.o
OBJS += iap.o cmd.o

##########################################################################
# GNU GCC compiler prefix and location
##########################################################################
CROSS_COMPILE = arm-none-eabi-
AS = $(CROSS_COMPILE)gcc
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)gcc
SIZE = $(CROSS_COMPILE)size
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump
OUTFILE = firmware

##########################################################################
# Flash Configuration
##########################################################################
UPLOAD = ./tools/lpc21isp/lpc21isp
PORT = /dev/ttyUSB0
BAUD = 115200
KFREQ = 1200
ISP = -control -controlswap
TERM = -termonly

##########################################################################
# GNU GCC compiler flags
##########################################################################
ROOT_PATH = .
INCLUDE_PATHS = -I$(ROOT_PATH) -I$(ROOT_PATH)/project

##########################################################################
# Startup files
##########################################################################

LD_PATH = lpc1xxx
LD_SCRIPT = $(LD_PATH)/linkscript.ld
LD_TEMP = $(LD_PATH)/memory.ld

ifeq (LPC11xx,$(TARGET))
  CORTEX_TYPE=m0
else
  CORTEX_TYPE=m3
endif

CPU_TYPE = cortex-$(CORTEX_TYPE)
VPATH += lpc1xxx
OBJS += $(TARGET)_handlers.o LPC1xxx_startup.o

##########################################################################
# Compiler settings, parameters and flags
##########################################################################
ifeq (TRUE,$(DEBUGBUILD))
  CFLAGS  = -c -g -O0 $(INCLUDE_PATHS) -Wall -Werror -mthumb -ffunction-sections -fdata-sections -fmessage-length=0 -mcpu=$(CPU_TYPE) -DTARGET=$(TARGET) -fno-builtin $(OPTDEFINES)
  ASFLAGS = -c -g -O0 $(INCLUDE_PATHS) -Wall -Werror -mthumb -ffunction-sections -fdata-sections -fmessage-length=0 -mcpu=$(CPU_TYPE) -D__ASSEMBLY__ -x assembler-with-cpp
else
  CFLAGS  = -c -g -Os $(INCLUDE_PATHS) -Wall -Werror -mthumb -ffunction-sections -fdata-sections -fmessage-length=0 -mcpu=$(CPU_TYPE) -DTARGET=$(TARGET) -fno-builtin $(OPTDEFINES)
  ASFLAGS = -c -g -Os $(INCLUDE_PATHS) -Wall -Werror -mthumb -ffunction-sections -fdata-sections -fmessage-length=0 -mcpu=$(CPU_TYPE) -D__ASSEMBLY__ -x assembler-with-cpp
endif
LDFLAGS = -nostartfiles -mcpu=$(CPU_TYPE) -mthumb -Wl,--gc-sections
LDLIBS  = -lm
OCFLAGS = --strip-unneeded

all: firmware

%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<

%.o : %.s
	$(AS) $(ASFLAGS) -o $@ $<

firmware: $(OBJS) $(SYS_OBJS)
	-@echo "MEMORY" > $(LD_TEMP)
	-@echo "{" >> $(LD_TEMP)
	-@echo "  flash(rx): ORIGIN = 0x00000000, LENGTH = $(FLASH)" >> $(LD_TEMP)
	-@echo "  sram(rwx): ORIGIN = 0x10000000+$(SRAM_USB), LENGTH = $(SRAM)-$(SRAM_USB)" >> $(LD_TEMP)
	-@echo "}" >> $(LD_TEMP)
	-@echo "INCLUDE $(LD_SCRIPT)" >> $(LD_TEMP)
	$(LD) $(LDFLAGS) -T $(LD_TEMP) -o $(OUTFILE).elf $(OBJS) $(LDLIBS)
	-@echo ""
	$(SIZE) $(OUTFILE).elf
	-@echo ""
	$(OBJCOPY) $(OCFLAGS) -O binary $(OUTFILE).elf $(OUTFILE).bin
	$(OBJCOPY) $(OCFLAGS) -O ihex $(OUTFILE).elf $(OUTFILE).hex
	@mv *.o build
	@mv *.hex build
	@mv *.elf build
	@mv *.bin build

clean:
	rm -f build/*.o build/$(LD_TEMP) build/$(OUTFILE).elf build/$(OUTFILE).bin build/$(OUTFILE).hex

program: clean firmware
	$(UPLOAD) $(ISP) build/$(OUTFILE).hex $(PORT) $(BAUD) $(KFREQ)

serial:
	$(UPLOAD) $(ISP) $(TERM) build/$(OUTFILE).hex $(PORT) 9600 $(KFREQ)

test: program serial
