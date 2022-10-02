##################################################
# Makefile
##################################################

BOOT:=boot.asm
LDR:=loader.asm
BOOT_BIN:=$(subst .asm,.bin,$(BOOT))
LDR_BIN:=$(subst .asm,.bin,$(LDR))

.PHONY : everything

everything : $(BOOT_BIN) $(LDR_BIN)
	@dd if=/dev/zero of=a.img bs=512 count=2880
	@mkfs -t vfat a.img
	@dd if=$(BOOT_BIN) of=a.img bs=512 count=1 conv=notrunc
	@ mount -o loop a.img /mnt
	@ cp $(LDR_BIN) /mnt -v
	@ umount /mnt
	@ qemu-system-x86_64 -boot order=c -drive file=a.img,format=raw

clean :
	@rm -f $(BOOT_BIN) $(LDR_BIN)

$(BOOT_BIN) : $(BOOT)
	@nasm $< -o $@

$(LDR_BIN) : $(LDR)
	@nasm $< -o $@


run:
	@qemu-system-i386		\
	-boot order=c			\
	-drive file=a.img,format=raw	\

gdb:
	@qemu-system-i386		\
	-boot order=c			\
	-drive file=a.img,format=raw	\
	-S -s

monitor:
	@gdb				\
	-ex 'set architecture i8086' \
	-ex 'target remote localhost:1234' \
	-ex 'b *0x9400' 
	
bin:
	@nasm boot.asm -o boot.bin 
	@nasm loader.asm -o loader.bin

