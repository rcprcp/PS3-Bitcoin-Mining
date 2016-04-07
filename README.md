# PS3-Bitcoin-Mining
PS3 bitcoin mining test program in assembler for Cell/BE processor.

(I know a PS3 is a slow Bitcoin mining rig by current standards, but i really wanted to see if i could get it to work)

This program is written for the Cell/BE processor which is in the PS3 game console.  The Cell/BE processor has 
a dual-core PPC (Power PC) chip.  The chips are manufactured with 8 SPEs (Synergistic Processing Elements) attached.  
Linux identifies 7 of the SPEs, reserves one for the Syste, so therefore you actually only have access to 6 of the SPEs.  
This leaves 6 SPEs for application programming.  

Each SPE is actually a 4-way vector processor which you can program in the SIMD (Single Instruction Multiple Data) model.  
You load and store data in quadwords (4 x 32 bit words).  SIMD refers to the fact that each "operation" you want to 
perform is applied to all 4 elements of the quadword simultaneously.  The 4 words in the quadword are referred to as lanes, and 
we're executing 4 times as much work as a standard scalar processor.  

There are several challenges to programming the SPE processor.  first, the SPE has a very small amount of local memory - only 128k.  The SPEs do not have direct access to the PPCs memory.  in with programming the SPE processor.  the largest one, which we sidestep in Bitcoin mining, is that you have to manage data flow to the procesor itself.   
The there are a few challenging aspects of SIMD programming.  One point to note is that you really have to have an embarassingly parallel problem to get the full effect of processing 4 data elements at a time.  If you have a lot of decision logic or other scalar code, you will not see a huge benefit from SIMD programming.    

As it turns out calculating SHA-256 for Bitcoin Mining is a great match for the Cell/BE architecture.  

TODO:
* get better timing information for a single process version of the program.  Bitcoin is a "double SHA256 hash" where the resulting SHA-256 is hashed again.  a single processor can do 2.5 million hashes per second, giving 1.25 million Bitcoin double hashes per second. 
* write a test driver that can feed in more test cases.  currently one test case is hard-coded in drive.c
* write a driver that can run the test cases in parallel.
* continue to look at the instruction scheduling with /opt/cell/sdk/usr/bin/spu_timing
* better comments, as we mix the instructions for the idfferent parts of the algorithm, it _will_ get confusing. 
