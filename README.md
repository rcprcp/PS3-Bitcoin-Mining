# PS3-Bitcoin-Mining
PS3 bitcoin mining test program in assembler for Cell/BE processor.

_(I know a PS3 is a slow Bitcoin mining rig by current standards, but i wanted to see if i could get it to work)_

This program is written for the Cell/BE processor which is in the PS3 game console.  The Cell/BE processor is also available in the IBM QS20 Blade, which is deployed in the IBM Blade Center chassis.  This source code should be able to be used on the QS20, but you probably will have to adapt the tool chain, since the PS3 is is running a very old version of Linux.  If someone out there has a Blade Center with a QS20 blade, and would let me ssh into it, I'd be happy to port, test and scale the code.

The Cell/BE processor is a dual-core PPC (Power PC) chip, clocked at 3.2Ghz.  There is one Cell/BE in the PS3, there are 2 in an IBM QS20 blade.  The PS3 has 256 Mb of memory, which is not a huge amount of memory, but more than enough for bitcoin mining.  Cell/BE chips are manufactured with 8 SPEs (Synergistic Processing Elements) attached.  On the PS3, Linux identifies 7 of the SPEs, reserves one for the System, leaving application developers with access to 6 of the SPEs.  

Each SPE is actually a 4-way vector processor which you can program in the SIMD (Single Instruction Multiple Data) model.  
The processor loads and stores data in quadwords (4 x 32 bit words).  SIMD refers to the fact that each operation, 
say an add or a multiply, is applied to all 4 elements of the quadword simultaneously.  Each of the 32-bit words in 
the quadword are referred to as lanes, and each instruction executes simultaneously on all 4 lanes. Given the 
right problem, algorithm and implementation, vector processing executes 4 times as much work per CPU instruction as a standard 
scalar processor.  

There are several challenges to programming the SPE processor.  The SPEs do not have direct access to PPC memory. The SPE has a very small amount of local memory - only 128k.  Data is moved from the PPC memory to the SPE memory in with a sort of DMA programming.  Bitcoin mining sidesteps this problem.  When mining, we pass all the data we need when invoking the function.  In bitcoin mining the SHA256 checksum is calculates from a relatively small chunk of data.  If the SHA256 does not meet the difficulty level, a field in the data is incrememted and the SHA256 is calculated again.  Continue to iterate like this until all 2B combinations have been tried or a SHA256 that is less than the difficulty is found. 

The there are a few challenging aspects of SIMD programming.  One point to note is that you really have to have an embarassingly parallel problem to get the full effect of processing 4 data elements at a time.  If you have a lot of decision logic or other scalar code, you will not see a huge benefit from SIMD programming.    

As it turns out calculating SHA-256 for Bitcoin Mining is a great match for the Cell/BE architecture.  

TODO:
* get better timing information for a single process version of the program.  Bitcoin is a "double SHA256 hash" where the resulting SHA-256 is hashed again.  a single processor can do 2.5 million hashes per second, giving 1.25 million Bitcoin double hashes per second. 
* write a test driver that can feed in more test cases.  currently one test case is hard-coded in drive.c
* write a driver that can run the test cases in parallel.
* continue to look at the instruction scheduling with /opt/cell/sdk/usr/bin/spu_timing
* better comments, as we mix the instructions for the different parts of the algorithm, it _will_ get confusing. 
