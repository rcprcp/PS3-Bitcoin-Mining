	.bss	LINK, 1*4*4, 16
	.bss	perm_registers, (128-80)*4*4, 16
	.bss	temp_registers, 80*4*4, 16	
	.bss	W256, 16*4*4, 16
	.data	 

	.align 4
		
// we'll overlay these on the struct which we are passed.
	.equ	MIDSTATE, 0
	.equ	TARGET, 8*4*4
	.equ	BUFFER, 16*4*4
	.equ	REHASH_BUFFER, 32*4*4
	.equ	STARTING_NONCE, 48*4*4
	.equ	ENDING_NONCE, 49*4*4
	.equ	RCODE, 50*4*4

	.align	4
SHA256_INIT:
	.int	0x6a09e667, 0x6a09e667, 0x6a09e667, 0x6a09e667
	.int	0xbb67ae85, 0xbb67ae85, 0xbb67ae85, 0xbb67ae85
	.int	0x3c6ef372, 0x3c6ef372, 0x3c6ef372, 0x3c6ef372
	.int	0xa54ff53a, 0xa54ff53a, 0xa54ff53a, 0xa54ff53a
	.int	0x510e527f, 0x510e527f, 0x510e527f, 0x510e527f
	.int	0x9b05688c, 0x9b05688c, 0x9b05688c, 0x9b05688c
	.int	0x1f83d9ab, 0x1f83d9ab, 0x1f83d9ab, 0x1f83d9ab
	.int	0x5be0cd19, 0x5be0cd19, 0x5be0cd19, 0x5be0cd19

HIGH_BIT_SET:	
	.int	0x80000000, 0x80000000, 0x80000000, 0x80000000

SHUFFLE_MASK:	
	.int	0x03020100, 0x07060504, 0x0b0a0908, 0x0f0e0d0c 

K256:
	.int 	0x428a2f98, 0x428a2f98, 0x428a2f98, 0x428a2f98
	.int 	0x71374491, 0x71374491, 0x71374491, 0x71374491
	.int 	0xb5c0fbcf, 0xb5c0fbcf, 0xb5c0fbcf, 0xb5c0fbcf
	.int 	0xe9b5dba5, 0xe9b5dba5, 0xe9b5dba5, 0xe9b5dba5
	.int 	0x3956c25b, 0x3956c25b, 0x3956c25b, 0x3956c25b
	.int 	0x59f111f1, 0x59f111f1, 0x59f111f1, 0x59f111f1
	.int 	0x923f82a4, 0x923f82a4, 0x923f82a4, 0x923f82a4
	.int 	0xab1c5ed5, 0xab1c5ed5, 0xab1c5ed5, 0xab1c5ed5
	.int 	0xd807aa98, 0xd807aa98, 0xd807aa98, 0xd807aa98
	.int 	0x12835b01, 0x12835b01, 0x12835b01, 0x12835b01
	.int 	0x243185be, 0x243185be, 0x243185be, 0x243185be
	.int 	0x550c7dc3, 0x550c7dc3, 0x550c7dc3, 0x550c7dc3
	.int 	0x72be5d74, 0x72be5d74, 0x72be5d74, 0x72be5d74
	.int 	0x80deb1fe, 0x80deb1fe, 0x80deb1fe, 0x80deb1fe
	.int 	0x9bdc06a7, 0x9bdc06a7, 0x9bdc06a7, 0x9bdc06a7
	.int 	0xc19bf174, 0xc19bf174, 0xc19bf174, 0xc19bf174
	.int 	0xe49b69c1, 0xe49b69c1, 0xe49b69c1, 0xe49b69c1
	.int 	0xefbe4786, 0xefbe4786, 0xefbe4786, 0xefbe4786
	.int 	0x0fc19dc6, 0x0fc19dc6, 0x0fc19dc6, 0x0fc19dc6
	.int 	0x240ca1cc, 0x240ca1cc, 0x240ca1cc, 0x240ca1cc
	.int 	0x2de92c6f, 0x2de92c6f, 0x2de92c6f, 0x2de92c6f
	.int 	0x4a7484aa, 0x4a7484aa, 0x4a7484aa, 0x4a7484aa
	.int 	0x5cb0a9dc, 0x5cb0a9dc, 0x5cb0a9dc, 0x5cb0a9dc
	.int 	0x76f988da, 0x76f988da, 0x76f988da, 0x76f988da
	.int 	0x983e5152, 0x983e5152, 0x983e5152, 0x983e5152
	.int 	0xa831c66d, 0xa831c66d, 0xa831c66d, 0xa831c66d
	.int 	0xb00327c8, 0xb00327c8, 0xb00327c8, 0xb00327c8
	.int 	0xbf597fc7, 0xbf597fc7, 0xbf597fc7, 0xbf597fc7
	.int 	0xc6e00bf3, 0xc6e00bf3, 0xc6e00bf3, 0xc6e00bf3
	.int 	0xd5a79147, 0xd5a79147, 0xd5a79147, 0xd5a79147
	.int 	0x06ca6351, 0x06ca6351, 0x06ca6351, 0x06ca6351
	.int 	0x14292967, 0x14292967, 0x14292967, 0x14292967
	.int 	0x27b70a85, 0x27b70a85, 0x27b70a85, 0x27b70a85
	.int 	0x2e1b2138, 0x2e1b2138, 0x2e1b2138, 0x2e1b2138
	.int 	0x4d2c6dfc, 0x4d2c6dfc, 0x4d2c6dfc, 0x4d2c6dfc
	.int 	0x53380d13, 0x53380d13, 0x53380d13, 0x53380d13
	.int 	0x650a7354, 0x650a7354, 0x650a7354, 0x650a7354
	.int 	0x766a0abb, 0x766a0abb, 0x766a0abb, 0x766a0abb
	.int 	0x81c2c92e, 0x81c2c92e, 0x81c2c92e, 0x81c2c92e
	.int 	0x92722c85, 0x92722c85, 0x92722c85, 0x92722c85
	.int 	0xa2bfe8a1, 0xa2bfe8a1, 0xa2bfe8a1, 0xa2bfe8a1
	.int 	0xa81a664b, 0xa81a664b, 0xa81a664b, 0xa81a664b
	.int 	0xc24b8b70, 0xc24b8b70, 0xc24b8b70, 0xc24b8b70
	.int 	0xc76c51a3, 0xc76c51a3, 0xc76c51a3, 0xc76c51a3
	.int 	0xd192e819, 0xd192e819, 0xd192e819, 0xd192e819
	.int 	0xd6990624, 0xd6990624, 0xd6990624, 0xd6990624
	.int 	0xf40e3585, 0xf40e3585, 0xf40e3585, 0xf40e3585
	.int 	0x106aa070, 0x106aa070, 0x106aa070, 0x106aa070
	.int 	0x19a4c116, 0x19a4c116, 0x19a4c116, 0x19a4c116
	.int 	0x1e376c08, 0x1e376c08, 0x1e376c08, 0x1e376c08
	.int 	0x2748774c, 0x2748774c, 0x2748774c, 0x2748774c
	.int 	0x34b0bcb5, 0x34b0bcb5, 0x34b0bcb5, 0x34b0bcb5
	.int 	0x391c0cb3, 0x391c0cb3, 0x391c0cb3, 0x391c0cb3
	.int 	0x4ed8aa4a, 0x4ed8aa4a, 0x4ed8aa4a, 0x4ed8aa4a
	.int 	0x5b9cca4f, 0x5b9cca4f, 0x5b9cca4f, 0x5b9cca4f
	.int 	0x682e6ff3, 0x682e6ff3, 0x682e6ff3, 0x682e6ff3
	.int 	0x748f82ee, 0x748f82ee, 0x748f82ee, 0x748f82ee
	.int 	0x78a5636f, 0x78a5636f, 0x78a5636f, 0x78a5636f
	.int 	0x84c87814, 0x84c87814, 0x84c87814, 0x84c87814
	.int 	0x8cc70208, 0x8cc70208, 0x8cc70208, 0x8cc70208
	.int 	0x90befffa, 0x90befffa, 0x90befffa, 0x90befffa
	.int 	0xa4506ceb, 0xa4506ceb, 0xa4506ceb, 0xa4506ceb
	.int 	0xbef9a3f7, 0xbef9a3f7, 0xbef9a3f7, 0xbef9a3f7
	.int 	0xc67178f2, 0xc67178f2, 0xc67178f2, 0xc67178f2
// end generated code

// some debugging messages...
msg_K256:	
	.asciz "K256 %8.8x\n"
msg_W256:	
	.asciz "W256 %8.8x\n"
msg_address:	
	.asciz "address %8.8x\n"
msg_starting_nonce:
	.asciz "start_nonce %d\n"
msg_ending_nonce:
	.asciz "ending_nonce %8.8x\n"
msg_target:
	.asciz "  target 20, %8.8x 21, %8.8x 22, %8.8x 23, %8.8x 24, %8.8x 25, %8.8x 26, %8.8x 27, %8.8x \n"
msg_hashvalue:
	.asciz "hash value %8.8x, %8.8x, %8.8x, %8.8x, %8.8x, %8.8x, %8.8x, %8.8x\n"
msg_answer:
	.asciz "answer %8.8x, %8.8x, %8.8x, %8.8x, %8.8x, %8.8x, %8.8x, %8.8x\n"
msg_midstate:
	.asciz "midstate 50, %8.8x 51, %8.8x 52, %8.8x 53, %8.8x 54, %8.8x 55, %8.8x 56, %8.8x 57, %8.8x \n"
msg_WDATA:
	.asciz "WDATA 30, %8.8x 31, %8.8x 32, %8.8x 33, %8.8x 34, %8.8x 35, %8.8x 36, %8.8x 37, %8.8x 38, %8.8x 39, %8.8x 40, %8.8x 41, %8.8x 42, %8.8x 43, %8.8x 44, %8.8x 45, %8.8x \n"
msg_debugging:
	.asciz "18 %8.8x 28, %8.8x\n"
msg_starting:
	.asciz "starting:\n" 
msg_ending:
	.asciz "ending:\n" 
msg_hex:
	.asciz "hex %8.8x\n"
msg_aa:
	.asciz "aa %8.8x\n"
msg_bb:
	.asciz "bb %8.8x\n"
msg_cc:
	.asciz "cc %8.8x\n" 
msg_dd:
	.asciz "dd %8.8x\n"
msg_ee:
	.asciz "ee %8.8x\n"
msg_ff:
	.asciz "ff %8.8x\n" 
msg_gg:
	.asciz "gg %8.8x\n"
msg_hh:
	.asciz "hh %8.8x\n"
msg_a:
	.asciz "a %8.8x\n"
msg_b:
	.asciz "b %8.8x\n"
msg_c:
	.asciz "c %8.8x\n"
msg_d:
	.asciz "d %8.8x\n"
msg_e:
	.asciz "e %8.8x\n"
msg_f:
	.asciz "f %8.8x\n"
msg_g:
	.asciz "g %8.8x\n"
msg_h:
	.asciz "h %8.8x\n"
msg_s0:
	.asciz "s0 %8.8x\n"
msg_s1:
	.asciz "s1 %8.8x\n"
msg_T1:
	.asciz "T1 %8.8x\n" 
msg_Maj:
	.asciz "Maj %8.8x\n" 
msg_Ch:
	.asciz "Ch %8.8x\n" 
msg_sigma0:
	.asciz "sigma0 %8.8x\n" 
msg_Sigma0:
	.asciz "Sigma0 %8.8x\n" 
msg_sigma1:
	.asciz "sigma1 %8.8x\n" 
msg_Sigma1:
	.asciz "Sigma1 %8.8x\n" 
msg_other_thing:
	.asciz "+= otherThing %8.8x\n" 
msg_time:
	.asciz "timebase %8.8x\n" 

	.text
	.global asm_crunch
	.type asm_crunch,@function

/*****************************************************************************/
//.include "macros"
	.macro round256_0_to_15 a, b, c, d, e, f, g, h
	
// first add the K256 and the BUFFER/W256 word.
// spu_add(K256, W256)
	// $60 will represent "j * 16" for accessing K256
	// $61 will represent "(j *16) && 0x0ff"  for accessing W256.

	lqx	$65, $78, $60	// spu_add(K256, W256)
	andi	$61, $60, 0x0ff	// spu_add(K256, W256)


// N_Ch(e, f, g)  jammed in the middle to get better pipelining.
	nand	$28, \e, \e	// N_Ch(e, f, g)  
	and	$28, $28, \g	// N_Ch(e, f, g)  

	lqx	$64, $79, $61	// spu_add(K256, W256)
	
// N_Ch(e, f, g) continued. 
	and	$19, \e, \f	// N_Ch(e, f, g) 
	xor	$19, $19, $28	// N_Ch(e, f, g) 
//$19 has the N_Ch(e,f,g)

	a	$18, $64, $65  //add K256, W256
//$18 has sum of K256, W256
	
//spu_add( N_Ch((n_e), (n_f), (n_g)), with K256 + W256
	a	$19, $19, $18

// N_Sigma1(n_e)
	roti	$18, \e, -6	// N_Sigma1(n_e)
	roti	$28, \e, -11	// N_Sigma1(n_e)
	roti	$29, \e, -25	// N_Sigma1(n_e)
	xor	$18, $18, $28	// N_Sigma1(n_e)
	xor	$29, $18, $29	// N_Sigma1(n_e)
// $29 has N_Sigma1(n_e)

// spu_add(N_Sigma1_256(n_e))
	a	$19, $19, $29	// spu_add(N_Sigma1_256(n_e))

// T1 = spu_add((n_h)
	a	$18, $19, \h
	// here $18 is T1


// (n_d) = spu_add(n_d, T1)
	a	\d, \d, $18

// N_Maj((n_a), (n_b), (n_c))
	and	$28, \b, \c
	and	$29, \a, \c
	xor	$28, $28, $29
	and	$29, \a, \b
	xor	$28, $28, $29
// N_Maj is $28

// N_Sigma0_256(n_a)
	roti	$70, \a, -2
	roti	$71, \a, -13
	roti	$72, \a, -22
	xor	$70, $70, $71
	xor	$70, $70, $72
	//N_Sigma0 is $70
	
// spu_add(T1, etc.
	a	$70, $70, $28
	a	\h, $18, $70

	ai	$60, $60, 16
// yes, that's the end of this macro.
.endm

.macro round256 a, b, c, d, e, f, g, h

//#define N_ROUND256(n_a, n_b, n_c, n_d, n_e, n_f, n_g, n_h)		   
//  s0 = N_sigma0_256(W256[(j+1)&0x0f])
	//#define N_sigma0_256(x)	(N_S32(7,  (x)) 
	//	^ N_S32(18, (x)) 
	//	^ N_R(3 ,   (x)))

	// figure out index... (j+1)&0x0f needs
	// to be converted to "rows" from scalar.
	// handle j+1
	ai	$61, $60, 16
	
	//limit check, W256 is only 16 rows of 16 bytes per row.
	andi	$61, $61, 0x0ff

	// load W256 data word...
	lqx	$62, $79, $61   //W256[j+1] for sigma0

// XYZZY stuffed in the middle for pipelining.
	// N_Ch((n_e), (n_f), (n_g)):
	nand	$28, \e, \e
	and	$29, \e, \f
	// moved other part below.

//  s1 = N_sigma1_256(W256[(j+14)&0x0f])
	ai	$61, $60, 16 * 14	

//may wrap around... W256 is only 16 rows of 16 bytes.
	andi	$61, $61, 0x0ff
	
//	pick after loading W256[j+1]
	roti	$63, $62, -7	//sigma0 on W256
	roti	$64, $62, -18
	rotmi	$65, $62, -3
	xor	$63, $63, $64
	xor	$18, $63, $65
	// $18 is sigma0.

//  s1 = N_sigma1_256(W256[(j+14)&0x0f])
	ai	$61, $60, 16 * 14	
	//may wrap around... W256 is only 16 rows of 16 bytes.
	andi	$61, $61, 0x0ff
	
	// load data word...
	lqx	$62, $79, $61

	// more of N_Ch((ne), (n_f), (n_g))
	and	$28, $28, \g
	xor	$29, $29, $28
	// $29 is the answer of N_Ch

	//#define N_sigma1_256(x)	
	//  (N_S32(17, (x)) 
	// ^ N_S32(19, (x)) 
	// ^ N_R(10,   (x)))
	roti	$3, $62, -17
	roti	$4, $62, -19
	rotmi	$5, $62, -10
	 	
	xor	$3, $3, $4
	xor	$19, $3, $5

// at this point, $18 is S0 and $19 is S1
	
//  T1 = spu_add((n_h),
//	       spu_add(N_Sigma1_256(n_e),
//		       spu_add(N_Ch((n_e), (n_f), (n_g)), V_K256[j])))

/*******  XYZZY  moved up. 
	// N_Ch((n_e), (n_f), (n_g)):
	nand	$28, \e, \e
	and	$28, $28, \g
	and	$29, \e, \f
	xor	$29, $29, $28
	// $29 is the answer of N_Ch
*************/
	
	// fetch K256
	lqx	$66, $78, $60
	// K256 is $66

// spu_add(N_Sigma1_256(n_e),
	// N_Sigma1(n_e)
	roti	$63, \e, -6
	roti	$64, \e, -11
	roti	$65, \e, -25

	xor	$63, $63, $64
	xor	$63, $63, $65
	// $63 has the N_Sigma1(n_e) answer.

//  W256[j&0x0f] = spu_add(W256[j&0x0f],
//			 spu_add(s1,
//				 spu_add(s0, W256[(j+9) & 0x0f])))
	//out of order for better pipelining.
	
	andi	$70, $60, 0x0ff		// may wrap around?	
	lqx	$71, $79, $70		// fetch W256[j]	
	// $71 is W256[j]

	/// spu_add(s0, W256[(j+9) & 0x0f])))
	ai	$68, $60, 16*9		// copy j and add 9*16
	andi 	$68, $68, 0x00ff	// mask with 16*16-1
	lqx	$62, $79, $68		// fetch W256[j+9] data
	// $62 is W256[j+9]

// now add up the parts of T1:
// at this point Sigma1 is $63, S0 is $18 and S1 is $19.
// $29 is Ch(), and $66 is K256
// $71 is W256[j]
// $62 is W256[j+9]

	a	$71, $71, $19		// add S1 to W256[j+9]
	a	$71, $71, $18		// add S0 to W256[j+9]
	a	$71, $71, $62		// add W256[j] to W256[j+9]
	stqx	$71, $79, $70		// save modified W256[j]

	a	$71, $71, \h		// plus h
	a	$71, $71, $63		// plus Sigma1_256(e)
	a	$71, $71, $29		// plus Ch
	a	$71, $71, $66		// plus K256
// at this point, $71 should be T1.	

//  (n_d) = spu_add((n_d), T1);
	a	\d, \d, $71
	
//  (n_h) = spu_add(T1,
//		  spu_add( N_Sigma0_256(n_a), N_Maj((n_a), (n_b), (n_c))));
	//N_Maj((n_a), (n_b), (n_c))
	and	$28, \b, \c
	and	$29, \a, \c
	xor	$28, $28, $29

	and	$29, \a, \b
	xor	$28, $28, $29
	// $28 has the N_Maj answer.	

	// N_Sigma0_256(n_a)
	roti	$65, \a, -2
	roti	$66, \a, -13
	roti	$67, \a, -22

	xor	$65, $65, $66
	xor	$65, $65, $67
	//$65 has the N_Sigma0 answer.	

	//xyzzy
	// add N_Maj  and N_Sigma0
	a	$65, $65, $28
	
	// add T1 to the subtotal, replace \h.
	a	\h, $65, $71
	
	//  j++
	ai	$60, $60, 16 
.endm

.macro save_temp_registers
// Generated by do4.pl
	stqd	$0, 0($119)
	stqd	$1, 16($119)
	stqd	$2, 32($119)
	stqd	$3, 48($119)
	stqd	$4, 64($119)
	stqd	$5, 80($119)
	stqd	$6, 96($119)
	stqd	$7, 112($119)
	stqd	$8, 128($119)
	stqd	$9, 144($119)
	stqd	$10, 160($119)
	stqd	$11, 176($119)
	stqd	$12, 192($119)
	stqd	$13, 208($119)
	stqd	$14, 224($119)
	stqd	$15, 240($119)
	stqd	$16, 256($119)
	stqd	$17, 272($119)
	stqd	$18, 288($119)
	stqd	$19, 304($119)
	stqd	$20, 320($119)
	stqd	$21, 336($119)
	stqd	$22, 352($119)
	stqd	$23, 368($119)
	stqd	$24, 384($119)
	stqd	$25, 400($119)
	stqd	$26, 416($119)
	stqd	$27, 432($119)
	stqd	$28, 448($119)
	stqd	$29, 464($119)
	stqd	$30, 480($119)
	stqd	$31, 496($119)
	stqd	$32, 512($119)
	stqd	$33, 528($119)
	stqd	$34, 544($119)
	stqd	$35, 560($119)
	stqd	$36, 576($119)
	stqd	$37, 592($119)
	stqd	$38, 608($119)
	stqd	$39, 624($119)
	stqd	$40, 640($119)
	stqd	$41, 656($119)
	stqd	$42, 672($119)
	stqd	$43, 688($119)
	stqd	$44, 704($119)
	stqd	$45, 720($119)
	stqd	$46, 736($119)
	stqd	$47, 752($119)
	stqd	$48, 768($119)
	stqd	$49, 784($119)
	stqd	$50, 800($119)
	stqd	$51, 816($119)
	stqd	$52, 832($119)
	stqd	$53, 848($119)
	stqd	$54, 864($119)
	stqd	$55, 880($119)
	stqd	$56, 896($119)
	stqd	$57, 912($119)
	stqd	$58, 928($119)
	stqd	$59, 944($119)
	stqd	$60, 960($119)
	stqd	$61, 976($119)
	stqd	$62, 992($119)
	stqd	$63, 1008($119)
	stqd	$64, 1024($119)
	stqd	$65, 1040($119)
	stqd	$66, 1056($119)
	stqd	$67, 1072($119)
	stqd	$68, 1088($119)
	stqd	$69, 1104($119)
	stqd	$70, 1120($119)
	stqd	$71, 1136($119)
	stqd	$72, 1152($119)
	stqd	$73, 1168($119)
	stqd	$74, 1184($119)
	stqd	$75, 1200($119)
	stqd	$76, 1216($119)
	stqd	$77, 1232($119)
	stqd	$78, 1248($119)
	stqd	$79, 1264($119)
// end generated code
 .endm

 .macro restore_temp_registers
// Generated by do3.pl
	lqd	$0, 0($119)
	lqd	$1, 16($119)
	lqd	$2, 32($119)
	lqd	$3, 48($119)
	lqd	$4, 64($119)
	lqd	$5, 80($119)
	lqd	$6, 96($119)
	lqd	$7, 112($119)
	lqd	$8, 128($119)
	lqd	$9, 144($119)
	lqd	$10, 160($119)
	lqd	$11, 176($119)
	lqd	$12, 192($119)
	lqd	$13, 208($119)
	lqd	$14, 224($119)
	lqd	$15, 240($119)
	lqd	$16, 256($119)
	lqd	$17, 272($119)
	lqd	$18, 288($119)
	lqd	$19, 304($119)
	lqd	$20, 320($119)
	lqd	$21, 336($119)
	lqd	$22, 352($119)
	lqd	$23, 368($119)
	lqd	$24, 384($119)
	lqd	$25, 400($119)
	lqd	$26, 416($119)
	lqd	$27, 432($119)
	lqd	$28, 448($119)
	lqd	$29, 464($119)
	lqd	$30, 480($119)
	lqd	$31, 496($119)
	lqd	$32, 512($119)
	lqd	$33, 528($119)
	lqd	$34, 544($119)
	lqd	$35, 560($119)
	lqd	$36, 576($119)
	lqd	$37, 592($119)
	lqd	$38, 608($119)
	lqd	$39, 624($119)
	lqd	$40, 640($119)
	lqd	$41, 656($119)
	lqd	$42, 672($119)
	lqd	$43, 688($119)
	lqd	$44, 704($119)
	lqd	$45, 720($119)
	lqd	$46, 736($119)
	lqd	$47, 752($119)
	lqd	$48, 768($119)
	lqd	$49, 784($119)
	lqd	$50, 800($119)
	lqd	$51, 816($119)
	lqd	$52, 832($119)
	lqd	$53, 848($119)
	lqd	$54, 864($119)
	lqd	$55, 880($119)
	lqd	$56, 896($119)
	lqd	$57, 912($119)
	lqd	$58, 928($119)
	lqd	$59, 944($119)
	lqd	$60, 960($119)
	lqd	$61, 976($119)
	lqd	$62, 992($119)
	lqd	$63, 1008($119)
	lqd	$64, 1024($119)
	lqd	$65, 1040($119)
	lqd	$66, 1056($119)
	lqd	$67, 1072($119)
	lqd	$68, 1088($119)
	lqd	$69, 1104($119)
	lqd	$70, 1120($119)
	lqd	$71, 1136($119)
	lqd	$72, 1152($119)
	lqd	$73, 1168($119)
	lqd	$74, 1184($119)
	lqd	$75, 1200($119)
	lqd	$76, 1216($119)
	lqd	$77, 1232($119)
	lqd	$78, 1248($119)
	lqd	$79, 1264($119)
// end generated code
 .endm

 /*****************************************************************************/
	 .align 2
 asm_crunch:	
 //preamble... save link register.
	stqa	$lr, LINK

 //save the caller's "permanent" registers.
	stqa	$80, perm_registers+0
	stqa	$81, perm_registers+16
	stqa	$82, perm_registers+32
	stqa	$83, perm_registers+48
	stqa	$84, perm_registers+64
	stqa	$85, perm_registers+80
	stqa	$86, perm_registers+96
	stqa	$87, perm_registers+112
	stqa	$88, perm_registers+128
	stqa	$89, perm_registers+144
	stqa	$90, perm_registers+160
	stqa	$91, perm_registers+176
	stqa	$92, perm_registers+192
	stqa	$93, perm_registers+208
	stqa	$94, perm_registers+224
	stqa	$95, perm_registers+240
	stqa	$96, perm_registers+256
	stqa	$97, perm_registers+272
	stqa	$98, perm_registers+288
	stqa	$99, perm_registers+304
	stqa	$100, perm_registers+320
	stqa	$101, perm_registers+336
	stqa	$102, perm_registers+352
	stqa	$103, perm_registers+368
	stqa	$104, perm_registers+384
	stqa	$105, perm_registers+400
	stqa	$106, perm_registers+416
	stqa	$107, perm_registers+432
	stqa	$108, perm_registers+448
	stqa	$109, perm_registers+464
	stqa	$110, perm_registers+480
	stqa	$111, perm_registers+496
	stqa	$112, perm_registers+512
	stqa	$113, perm_registers+528
	stqa	$114, perm_registers+544
	stqa	$115, perm_registers+560
	stqa	$116, perm_registers+576
	stqa	$117, perm_registers+592
	stqa	$118, perm_registers+608
	stqa	$119, perm_registers+624
	stqa	$120, perm_registers+640
	stqa	$121, perm_registers+656
	stqa	$122, perm_registers+672
	stqa	$123, perm_registers+688
	stqa	$124, perm_registers+704
	stqa	$125, perm_registers+720
	stqa	$126, perm_registers+736
	stqa	$127, perm_registers+752

//initialize:	load the starting_nonce
	lqd	$7, STARTING_NONCE($3)

// save a copy - used during initialization
// calls to printf for debugging whack the value in $3.  
	lr	$6, $3		#copy address of passed in struct. 

//initialize:	load the ending_nonce
	lqd	$8, ENDING_NONCE($3)

// initial load of midstate.
// treat these as READ_ONLY
// we'll reference and make copies these registers as necessary: 
	lqd	$10, MIDSTATE+(0*16)($6)
	lqd	$11, MIDSTATE+(1*16)($6)
	lqd	$12, MIDSTATE+(2*16)($6)
	lqd	$13, MIDSTATE+(3*16)($6)
	lqd	$14, MIDSTATE+(4*16)($6)
	lqd	$15, MIDSTATE+(5*16)($6)
	lqd	$16, MIDSTATE+(6*16)($6)
	lqd	$17, MIDSTATE+(7*16)($6)

// initial load of SHA256_INIT midstate.
// treat these as READ_ONLY
// we'll reference and make copies these registers as necessary: 
	lqr	$80, SHA256_INIT+(0*16)
	lqr	$81, SHA256_INIT+(1*16)
	lqr	$82, SHA256_INIT+(2*16)
	lqr	$83, SHA256_INIT+(3*16)
	lqr	$84, SHA256_INIT+(4*16)
	lqr	$85, SHA256_INIT+(5*16)
	lqr	$86, SHA256_INIT+(6*16)
	lqr	$87, SHA256_INIT+(7*16)

//SHOULD THE ANSWER BE REVERSED?  what will the answers look like? 
// this data will be used every time we compare an answer data. 
	lqd	$20, TARGET+(0*16)($6)
	lqd	$21, TARGET+(1*16)($6)
	lqd	$22, TARGET+(2*16)($6)
	lqd	$23, TARGET+(3*16)($6)
	lqd	$24, TARGET+(4*16)($6)
	lqd	$25, TARGET+(5*16)($6)
	lqd	$26, TARGET+(6*16)($6)
	lqd	$27, TARGET+(7*16)($6)

//load the data we're going to hash into registers 
// we'll treat these as READ_ONLY.
	lqd	$30, BUFFER+(0*16)($6)
	lqd	$31, BUFFER+(1*16)($6)
	lqd	$32, BUFFER+(2*16)($6)	
	lqd	$33, BUFFER+(3*16)($6)
	lqd	$34, BUFFER+(4*16)($6)
	lqd	$35, BUFFER+(5*16)($6)
	lqd	$36, BUFFER+(6*16)($6)
	lqd	$37, BUFFER+(7*16)($6)
	lqd	$38, BUFFER+(8*16)($6)
	lqd	$39, BUFFER+(9*16)($6)
	lqd	$40, BUFFER+(10*16)($6)
	lqd	$41, BUFFER+(11*16)($6)
	lqd	$42, BUFFER+(12*16)($6)
	lqd	$43, BUFFER+(13*16)($6)
	lqd	$44, BUFFER+(14*16)($6)
	lqd	$45, BUFFER+(15*16)($6)

// permanently used registers:
// $6 is pointer to input buffer. 	 
// $7 is starting nonce.
// $8 is the ending nonce.
// $9 is used as the rcode.
// $10 - $17 RO - as the MIDSTATE value.
// $20 - $27 RO - TARGET values.

// these are RW, and are loaded each iteration. 
// $30 - $45 RO - BUFFER data to hash (aka W256[]).
// FYI... $33 position of the nonce row in the BUFFER.
	 
// $50 - $57 RW - output or new MIDSTATE. (a, b, c, d, e, f, g, h)


// transient registers:	
// regs $3 - $5, $18, $19, $28, $29
// although $3 is defined to be the function return value.
// and $46 - $49, $58, $59 and $61 - $127 are available.

// load data buffer
// this is the second half of the BITCOIN_HEADER data.
// the first 64-byte block has already been processed,
// giving MIDSTATE.

// addresses and immediate data we need.
	ila	$79, W256
	ila	$78, K256

	ila	$77, OUTER_LOOP
	ila	$127, msg_hex
	lqa	$126, HIGH_BIT_SET
	il	$125, 0x100		// end flag for the second hash. 
	il	$124, 0	
	lqa	$123, SHUFFLE_MASK
	il	$122, 1

	ila	$121, msg_ending_nonce
	ila	$120, msg_starting_nonce
	ila	$119, temp_registers
	ila	$118, perm_registers
	ila	$117, msg_hashvalue
	ila	$116, msg_answer
	ila	$115, msg_debugging
	
OUTER_LOOP:

// shuffle and plop nonce values into the 4th row of the BUFFER.
	shufb	$33, $7, $7, $123

// XYZZY
// store the W256 data in the RW buffer.	
// and copy the MIDSTATE from the other registers.
// intermix them to get both pipelines working.
// using register $60 throughout the program to represent "j" 
// as the index into the K256 and W256.
// but times 16 to make it per row instead of per word.
	stqa	$30, W256+(0*16)
	il	$60, 0

	stqa	$31, W256+(1*16)
	lr	$50, $10

	stqa	$32, W256+(2*16)
	lr	$51, $11

	stqa	$33, W256+(3*16)
	lr	$52, $12

	stqa	$34, W256+(4*16)
	lr	$53, $13

	stqa	$35, W256+(5*16)
	lr	$54, $14

	stqa	$36, W256+(6*16)
	lr	$55, $15

	stqa	$37, W256+(7*16)
	lr	$56, $16

	stqa	$38, W256+(8*16)
	lr	$57, $17	

	stqa	$39, W256+(9*16)
	stqa	$40, W256+(10*16)
	stqa	$41, W256+(11*16)
	stqa	$42, W256+(12*16)
	stqa	$43, W256+(13*16)
	stqa	$44, W256+(14*16)
	stqa	$45, W256+(15*16)

	round256_0_to_15 $50, $51, $52, $53, $54, $55, $56, $57
	round256_0_to_15 $57, $50, $51, $52, $53, $54, $55, $56
	round256_0_to_15 $56, $57, $50, $51, $52, $53, $54, $55
	round256_0_to_15 $55, $56, $57, $50, $51, $52, $53, $54
	round256_0_to_15 $54, $55, $56, $57, $50, $51, $52, $53
	round256_0_to_15 $53, $54, $55, $56, $57, $50, $51, $52
	round256_0_to_15 $52, $53, $54, $55, $56, $57, $50, $51
	round256_0_to_15 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256_0_to_15 $50, $51, $52, $53, $54, $55, $56, $57
	round256_0_to_15 $57, $50, $51, $52, $53, $54, $55, $56
	round256_0_to_15 $56, $57, $50, $51, $52, $53, $54, $55
	round256_0_to_15 $55, $56, $57, $50, $51, $52, $53, $54
	round256_0_to_15 $54, $55, $56, $57, $50, $51, $52, $53
	round256_0_to_15 $53, $54, $55, $56, $57, $50, $51, $52
	round256_0_to_15 $52, $53, $54, $55, $56, $57, $50, $51
	round256_0_to_15 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50

// compute the intermediate hash value...
// this is the sum of the original MIDSTATE and the
// answer we just hashed from the BUFFER.
	a $50, $10, $50	
	a $51, $11, $51	
	a $52, $12, $52	
	a $53, $13, $53	
	a $54, $14, $54	
	a $55, $15, $55	
	a $56, $16, $56	
	a $57, $17, $57

// XYZZY intermingle stqa/lr for effective pipelining
// stqa's save the intermediate hash in the RW buffer. 
	stqa	$50, W256+(0*16)
// copy the hash to the registers, too.
	stqa	$51, W256+(1*16)
	stqa	$52, W256+(2*16)
	stqa	$53, W256+(3*16)
	stqa	$54, W256+(4*16)
	stqa	$55, W256+(5*16)
	stqa	$56, W256+(6*16)
	stqa	$57, W256+(7*16)

// fill the rest of the data buffer registers, and
// remember to save the data in memory.
	stqa	$126, W256+(8*16)
	
	stqa	$124, W256+(9*16)
	stqa	$124, W256+(10*16)
	stqa	$124, W256+(11*16)
	stqa	$124, W256+(12*16)
	stqa	$124, W256+(13*16)
	stqa	$124, W256+(14*16)
	
	stqa	$125, W256+(15*16)
	
//load the SHA256_INIT words for the this SHA256 calculation.
	lr	$50,$80
	lr	$51,$81
	lr	$52,$82
	lr	$53,$83
	lr	$54,$84
	lr	$55,$85
	lr	$56,$86
	lr	$57,$87

// using register $60 as the index into the K256 and W256.
// aka "j", but times 16 to make it per row instead of per word.
	il	$60, 0
	
	round256_0_to_15 $50, $51, $52, $53, $54, $55, $56, $57
	round256_0_to_15 $57, $50, $51, $52, $53, $54, $55, $56
	round256_0_to_15 $56, $57, $50, $51, $52, $53, $54, $55
	round256_0_to_15 $55, $56, $57, $50, $51, $52, $53, $54
	round256_0_to_15 $54, $55, $56, $57, $50, $51, $52, $53
	round256_0_to_15 $53, $54, $55, $56, $57, $50, $51, $52
	round256_0_to_15 $52, $53, $54, $55, $56, $57, $50, $51
	round256_0_to_15 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256_0_to_15 $50, $51, $52, $53, $54, $55, $56, $57
	round256_0_to_15 $57, $50, $51, $52, $53, $54, $55, $56
	round256_0_to_15 $56, $57, $50, $51, $52, $53, $54, $55
	round256_0_to_15 $55, $56, $57, $50, $51, $52, $53, $54
	round256_0_to_15 $54, $55, $56, $57, $50, $51, $52, $53
	round256_0_to_15 $53, $54, $55, $56, $57, $50, $51, $52
	round256_0_to_15 $52, $53, $54, $55, $56, $57, $50, $51
	round256_0_to_15 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50
	
	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54
	round256 $54, $55, $56, $57, $50, $51, $52, $53
	round256 $53, $54, $55, $56, $57, $50, $51, $52
	round256 $52, $53, $54, $55, $56, $57, $50, $51
	round256 $51, $52, $53, $54, $55, $56, $57, $50

	round256 $50, $51, $52, $53, $54, $55, $56, $57
	round256 $57, $50, $51, $52, $53, $54, $55, $56
	round256 $56, $57, $50, $51, $52, $53, $54, $55
	round256 $55, $56, $57, $50, $51, $52, $53, $54

	// branch hint telling the SPU we'll take the branch from
	// "BRANCH" and go to "OUTER_LOOP"
	//hbr	BRANCH, $77
	//	dsync
	
	round256 $54, $55, $56, $57, $50, $51, $52, $53		//60
	a	$18, $87, $57
	brz	$18, GO_ON

	rotqbyi	$18, $18, 4
	brz	$18, GO_ON
	
	rotqbyi	$18, $18, 4
	brz	$18, GO_ON
	
	rotqbyi	$18, $18, 4
	brz	$18, GO_ON
	br	SKIPPED_LAST_3

GO_ON:		
	round256 $53, $54, $55, $56, $57, $50, $51, $52		//61
	round256 $52, $53, $54, $55, $56, $57, $50, $51		//62
	round256 $51, $52, $53, $54, $55, $56, $57, $50		//63

// compute the intermediate hash value...
// this is the sum of the original MIDSTATE and the
// answer we just hashed from the BUFFER.	
// NOTE: we're using the $80's here - SHA256_INIT!!
// NOTE: since we're going through a second time we 
// don't use the original MIDSTATE 
	a	$50, $80, $50	
	a	$51, $81, $51	
	a	$52, $82, $52	
	a	$53, $83, $53	
	a	$54, $84, $54	
	a	$55, $85, $55	
	a	$56, $86, $56	
	a	$57, $87, $57

// reorder the bytes in each word of the result.
	shufb	$50, $50, $50, $123
	shufb	$51, $51, $51, $123	
	shufb	$52, $52, $52, $123
	shufb	$53, $53, $53, $123
	shufb	$54, $54, $54, $123
	shufb	$55, $55, $55, $123
	shufb	$56, $56, $56, $123
	shufb	$57, $57, $57, $123

// check if the SHA256 is less than the target.
// the answers to check are in $50-$57
// the target is stored in $20-$27

// we need a register for the resulting count...
	il	$18, 0
/***************
//DEBUG:	print it out.
	save_temp_registers
	lr	$11, $50 
	lr	$10, $51 
	lr	$9, $52 
	lr	$8, $53 
	lr	$7, $54 
	lr	$6, $55 
	lr	$5, $56 
	lr	$4, $57 
	lr	$3, $116
	brsl	$lr, printf
	restore_temp_registers
	**********/
	clgt	$28, $50, $27
	andi	$28, $28, 1
	a	$18, $18, $28
	
	clgt	$28, $51, $26
	andi	$28, $28, 1
	a	$18, $18, $28

	clgt	$28, $52, $25
	andi	$28, $28, 1
	a	$18, $18, $28

	clgt	$28, $53, $24
	andi	$28, $28, 1
	a	$18, $18, $28

	clgt	$28, $54, $23
	andi	$28, $28, 1
	a	$18, $18, $28

	clgt	$28, $55, $22
	andi	$28, $28, 1
	a	$18, $18, $28

	clgt	$28, $56, $21
	andi	$28, $28, 1
	a	$18, $18, $28

	clgt	$28, $57, $20
	andi	$28, $28, 1
	a	$18, $18, $28

// if a word is zero, it's a winning nonce.
	brz	$18, LANE1

	rotqbyi	$19, $18, 4
	rotqbyi	$28, $18, 8
	rotqbyi	$29, $18, 12
	
	brz	$19, LANE2
	brz	$28, LANE3
	brz	$29, LANE4

SKIPPED_LAST_3:	
// sigh, add four to each nonce since we're running 4 lanes,
// and let's loop again.
	ai	$7, $7, 4

// "compare logical .gt." the just-incremented starting_nonce
// and the ending_nonce.
	clgt	$5, $7, $8

BRANCH:
	brz	$5, OUTER_LOOP

// out of iterations and potential nonces - 
// nothing left to do...
	
// $4 has the rcode. 
	il	$4, 0
	
// $3 is the function's return value	
	il	$3, 0

////////////
// when we get here, the RCODE should be in $4,
// the nonce (winning nonce, or 0 for a loser) should be in $3.
EXIT:	
// epilogue...
// save return code in struct. 
	stqd $4, RCODE($6)
	
// Restore link register
	lqa $lr, LINK

// Restore "permanent" registers.
	lqa	$80, perm_registers+0
	lqa	$81, perm_registers+16
	lqa	$82, perm_registers+32
	lqa	$83, perm_registers+48
	lqa	$84, perm_registers+64
	lqa	$85, perm_registers+80
	lqa	$86, perm_registers+96
	lqa	$87, perm_registers+112
	lqa	$88, perm_registers+128
	lqa	$89, perm_registers+144
	lqa	$90, perm_registers+160
	lqa	$91, perm_registers+176
	lqa	$92, perm_registers+192
	lqa	$93, perm_registers+208
	lqa	$94, perm_registers+224
	lqa	$95, perm_registers+240
	lqa	$96, perm_registers+256
	lqa	$97, perm_registers+272
	lqa	$98, perm_registers+288
	lqa	$99, perm_registers+304
	lqa	$100, perm_registers+320
	lqa	$101, perm_registers+336
	lqa	$102, perm_registers+352
	lqa	$103, perm_registers+368
	lqa	$104, perm_registers+384
	lqa	$105, perm_registers+400
	lqa	$106, perm_registers+416
	lqa	$107, perm_registers+432
	lqa	$108, perm_registers+448
	lqa	$109, perm_registers+464
	lqa	$110, perm_registers+480
	lqa	$111, perm_registers+496
	lqa	$112, perm_registers+512
	lqa	$113, perm_registers+528
	lqa	$114, perm_registers+544
	lqa	$115, perm_registers+560
	lqa	$116, perm_registers+576
	lqa	$117, perm_registers+592
	lqa	$118, perm_registers+608
	lqa	$119, perm_registers+624
	lqa	$120, perm_registers+640
	lqa	$121, perm_registers+656
	lqa	$122, perm_registers+672
	lqa	$123, perm_registers+688
	lqa	$124, perm_registers+704
	lqa	$125, perm_registers+720
	lqa	$126, perm_registers+736
	lqa	$127, perm_registers+752

// Return to caller...
	bi $lr

///////////////////////////
// Winning nonces will be processed here:
LANE1:	
	il	$4, 1	//lane
	lr	$3, $7
	br	EXIT		

LANE2:
	rotqbyi	$3, $7, 4
	il	$4, 2	//lane
	br	EXIT
	
LANE3:
	rotqbyi	$3, $7, 8
	il	$4, 3	//lane
	br	EXIT 
		
LANE4:
	rotqbyi	$3, $7, 12
	il	$4, 4	//lane
	br	EXIT

//DEBUG:	print it out.
	save_temp_registers
	lr	$11, $50 
	lr	$10, $51 
	lr	$9, $52 
	lr	$8, $53 
	lr	$7, $54 
	lr	$6, $55 
	lr	$5, $56 
	lr	$4, $57 
	lr	$3, $117
	brsl	$lr, printf
	restore_temp_registers

// THE END.
