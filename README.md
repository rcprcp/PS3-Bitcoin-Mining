# PS3-Bitcoin-Mining
PS3 bitcoin mining test program in assembler for Cell/BE processor.

(I know a PS3 is a slow Bitcoin mining rig by current standards, but i really wanted to see if i could get it to work)

This program is written for the Cell/BE processor which is in the PS3 game console.  The Cell/BE processor has 
a dual-core PPC chip, with (usually) 8 SPEs (Synergistic Processing Elements) attached.  When running Linux on 
the PS3, you actually only have access to 6 of the SPEs.  For some reason, Linux will find 7 of the SPEs,  
and one of the 7 is reserved for Linux itself.  This leaves 6 SPEs for application programming.  

Each SPE is actually a 4-way vector processor which you can program in the SIMD (Single Instruction Multiple Data) model.  
You load and store data in quadwords (4 x 32 bit words).  SIMD refers to the fact that each "operation" you want to 
perform is applied to all 4 elements of the quadword simultaneously.  The 4 words in the quadword are referred to as lanes, and 
we're executing 4 times as much work as a standard scalar processor.  The interesting part of SIMD programming is that 
you really have to have an embarassingly parallel problem to get the full effect of processing 4 data elements at a time.

As it turns out calculating SHA-256 for Bitcoin Mining is a great match for the Cell/BE architecture.  

TODO:
* get better timing information for a single process version of the program.
* write a test driver that can feed in more test cases.  currently one test case is hard-coded in drive.c
* write a driver that can run the test cases in parallel.
* continue to look at the instruction scheduling with /opt/cell/sdk/usr/bin/spu_timing
* better comments, as we mix the instructions for the idfferent parts of the algorithm, it _will_ get confusing. 
