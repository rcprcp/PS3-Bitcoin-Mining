# PS3-Bitcoin-Mining
PS3 bitcoin mining test program in assembler for Cell/BE processor.

_(I know a PS3 is a slow Bitcoin mining rig by current standards, but i wanted to see if i could get it to work)_

This program is written for the Cell/BE processor which is in the PS3 game console.  The Cell/BE processor is also available in the IBM QS20 Blade, which is deployed in the IBM Blade Center chassis.  This source code should be able to be used on the QS20; the tool chain may need to be adapted, since this PS3 is is running a very old version of Linux and the GNU compiler toolkit.  

If someone out there has a Blade Center with a QS20 blade, and would let me ssh into it, I'd be happy to port, test and scale the code.

The Cell/BE processor is a dual-core PPC (Power PC) chip, clocked at 3.2Ghz.  There is one Cell/BE in the PS3, there are 2 in an IBM QS20 blade.  The PS3 has 256 Mb of memory, which is not a huge amount of memory, but more than enough for bitcoin mining.  Cell/BE chips are manufactured with 8 SPEs (Synergistic Processing Elements) attached.  On the PS3, Linux identifies 7 of the SPEs, reserves one for the System, leaving application developers with access to 6 of the SPEs.  

Each SPE is actually a 4-way vector processor which can be programmed in the SIMD (Single Instruction Multiple Data) model.  The processor loads and stores data in quadwords (4 x 32 bit words).  SIMD refers to the fact that each operation, 
say an add or a multiply, is applied to all 4 elements of the quadword simultaneously.  Each of the 32-bit words in 
the quadword are referred to as lanes, and each instruction executes simultaneously on all 4 lanes. Given the 
right problem, algorithm and implementation, vector processing on the Cell/BE executes 4 times as much work per 
CPU instruction as a standard scalar processor.  

There are several challenges to programming the SPE processor.  SPEs do not have direct access to PPC memory. The SPE has a very small amount of local memory - only 128k.  Data is moved from the PPC memory to the SPE memory with a sort of DMA programming.  Bitcoin mining sidesteps this problem.  When mining, all the data necessary for the calculations is assembled into a C struct and DMAed from PPC system memory to the SPE local memory in one chunk as the assembly language function is invoked.  

In bitcoin mining the SHA256 checksum is calculated from a relatively small chunk of data.  If the SHA256 does not meet the difficulty level, a 32-bit integer field in the data is incrememted and the SHA256 is calculated again.  Continue to iterate like this until all 2B combinations have been tried or a winning SHA256 -- one that is less than the difficulty is found. 

The there are a few challenging aspects of SIMD programming.  One point to note is that you really have to have an embarassingly parallel problem to get the full effect of SIMD programming - processing 4 data elements at a time.  If you have a lot of decision logic or other scalar code, you will not see a huge benefit from SIMD programming.    

As it turns out calculating SHA256 for Bitcoin Mining is a great match for the Cell/BE architecture.

Calculating SHA256 is done in the assembly code - and the instructions need to be effectively scheduled.  Obviously the C compiler can reorder the instructions and speed up execution, this has to be done by hand when writing assembler code.  

-- more to come.
Current Test Driver:
this is a C program with the second block (block number 1), basically hard coded into the program. the block is formatted into a struct and passed to the assembly routine.  

the assembly routine can call code from the C libraries, basically the entire thing was debugged via printf(s), since there is no debugger which supports the SPEs available in the old version of Yellow Dog Linux (6.2) which I'm using.  

References:


TODO:
* get better timing information for a single process version of the program.  Bitcoin is a "double SHA256 hash" where the resulting SHA-256 is hashed again.  a single processor can do 2.5 million hashes per second, giving 1.25 million Bitcoin double hashes per second. 
* write a test driver that can feed in more test cases.  currently one test case is hard-coded in drive.c
* write a driver that can run the test cases in parallel.
* continue to look at the instruction scheduling with /opt/cell/sdk/usr/bin/spu_timing
* better comments, as we mix the instructions for the different parts of the algorithm, it _will_ get confusing. 
