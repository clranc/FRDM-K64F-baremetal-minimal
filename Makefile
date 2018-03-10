#Fernando Luiz Cola
#25/09/2015

#Toolchain and Path Configuration
#TOOLCHAIN=/opt/gcc-arm-none-eabi-7-2017-q4-major/bin/
TOOLCHAIN=$(shell whereis arm-none-eabi-gcc | sed -e "s/arm-none-eabi-gcc: //" -e "s/arm-none-eabi-gcc//")
PREFIX=$(TOOLCHAIN)arm-none-eabi-
CC=$(PREFIX)gcc
LD=$(PREFIX)gcc
DB=$(PREFIX)gdb
AS=$(PREFIX)as
OBJCOPY=$(PREFIX)objcopy
SIZE=$(PREFIX)size
RM=rm -f

#Files Location
SRC=$(wildcard *.c)
OBJ=$(patsubst  %.c, %.o, $(SRC) )
ASSRC=$(wildcard *.S)
ASOBJ=$(patsubst  %.S, %.o, $(ASSRC) )

#GNU ARM GCC Configuration and Platform configurations
ARCHFLAGS=-mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mfpu=fpv4-sp-d16
INCLUDE=-I./includes/
CFLAGS= -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -g3 \
	 -Xlinker --gc-sections -specs=nano.specs -specs=nosys.specs
LDFLAGS= $(ARCHFLAGS) -T "MK64FN1M0xxx12_flash.ld" -L"./" -Wl,-Map,$(TARGET).map

#GNU ARM GDB Flags
DBFLAGS=--batch --command=gdbinit

#Output file
TARGET=main

#Makefile rules
all: build bin size
build: elf
builds: assem
elf: $(TARGET).elf
bin: $(TARGET).bin
assem: $(TARGET).s
#srec: $(TARGET).srec

clean:
	$(RM) $(TARGET).bin $(TARGET).srec $(TARGET).elf $(TARGET).map $(OBJ) $(ASOBJ)
	echo $(TEST)

#Compiling each source file
%.o: %.c 
	$(CC) -c $(ARCHFLAGS) $(CFLAGS) $(INCLUDE) -o $@ $<

%.s: %.c
	$(CC) -c $(ARCHFLAGS) $(CFLAGS) $(INCLUDE) -S -o $@ $<

#Linking project
$(TARGET).elf: $(OBJ) $(ASOBJ)
	@echo '### Linking files ###'
	$(LD) $(LDFLAGS) $(CFLAGS) $(OBJ) $(ASOBJ) -o $@
%.bin: %.elf
	@echo 'Binary'
	$(OBJCOPY) -O binary $< $@
size:
	@echo "---- RAM/Flash Usage ----"
	$(SIZE) $(TARGET).elf

#%.srec: %.elf
#	$(OBJCOPY) -O srec $< $@

flash:
	sudo $(DB) $(DBFLAGS) 

