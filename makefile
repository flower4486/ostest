boot.bin:boot.asm
	nasm boot.asm -o boot.bin

run:
	qemu-system-x86_64 -boot order=c  -drive file=boot.bin,format=raw
clean:
	rm boot.bin
