all: drive

asm_crunch.o: asm_crunch.S
	spu-gcc -O3 -Wall -std=c99  -c asm_crunch.S  
##	spu-gcc -O3 -Wall -Wa,-almn=asm_crunch.lst -std=c99  -c asm_crunch.S  

drive.o:
	spu-gcc -O3 -Wall -std=c99  -c drive.c 

clean:
	rm *.o

drive: drive.o asm_crunch.o
	spu-gcc -o drive drive.o asm_crunch.o 
##end
