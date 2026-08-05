PROJ = main
CPU ?= cortex-m3
BOARD ?= stm32vldiscovery

OBJ = boot.o

.PHONY: all clean

all: $(PROJ).elf

%.o: %.S
	arm-none-eabi-as -mcpu=$(CPU) -mthumb $< -o $@

$(PROJ).elf: $(OBJ)
	arm-none-eabi-ld -T map.ld $^ -o $@
	arm-none-eabi-objdump -D -S $@ > $@.lst
	arm-none-eabi-readelf -a $@ > $@.debug

qemu:
	qemu-system-arm -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJ).elf -S -gdb tcp::1234

gdb:
	gdb-multiarch -q main.elf -ex "target remote localhost:1234"
clean:
	rm -f *.o *.elf *.lst *.debug