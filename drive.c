#include <stdio.h>
#include <string.h>

typedef struct mystruct { 
  // all data items are ALL!! in SIMD format.
  unsigned int midstate[8][4];
  unsigned int target[8][4];
  unsigned int buffer[16][4];
  unsigned int rehash_buffer[16][4];
  unsigned int starting_nonce[4];
  unsigned int ending_nonce[4];
  int rcode[4];
} MYSTRUCT ;

MYSTRUCT s  __attribute__ ((aligned(16)))  ;

int asm_crunch(MYSTRUCT *s);

inline void hexdump(unsigned char* data, int len)
{
  int c;
	
  c=0;
  while(c < len)
    {
      printf("%.2x", data[c++]);
    }
  printf("\n");
}

int main(int argc, char *argv[]) { 
  

  unsigned int midstate[] = {
    0x6a09e667,     
    0xbb67ae85,    
    0x3c6ef372,     
    0xa54ff53a,    
    0x510e527f,    
    0x9b05688c,    
    0x1f83d9ab,    
    0x5be0cd19
};

  unsigned int buffer[] = { 
    0x01000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x3ba3edfd,
    0x7a7b12b2,
    0x7ac72c3e,
    0x67768f61,
    0x7fc81bc3,
    0x888a5132,
    0x3a9fb8aa
  };

  unsigned int second_half_buffer[] = { 
    0x4b1e5e4a,
    0x29ab5f49,
    0xffff001d,
    // 0x7c2bac1d,
    0x1dac2b7c, 
    0x80000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000000,
    0x00000280 
};

  unsigned int second_half_midstate[] = { 
    0xbc909a33,
    0x6358bff0,
    0x90ccac7d,
    0x1e59caa8,
    0xc3c8d8e9,
    0x4f0103c8,
    0x96b18736,
    0x4719f91b
  };

  unsigned int target[] = {
    0x6fe28c0a,
    0xb6f1b372,
    0xc1a6a246,
    0xae63f74f,
    0x931e8365,
    0xe15a089c,
    0x68d61900,
    0x00000000,
  };

 
  memset(&s, 0, sizeof(s));
  printf("sizeof s %zu\n", sizeof(s));

  // save the buffer of data to hash... 
  for(int j   = 0 ; j < 16; j++) {
    for(int i = 0 ; i < 4; i++) {
      s.buffer[j][i] = second_half_buffer[j];
    }
  }

  //  hexdump((unsigned char *)&(s.buffer), 16*4*4);

  // save the midstate.
  for(int j   = 0 ; j < 8; j++) {
    for(int i = 0 ; i < 4; i++) {
      s.midstate[j][i] = second_half_midstate[j];
    }
  }
  
  unsigned int temp_target[8];
  unsigned int new_target[8];
  //byte reverse each word of target data. 
  for(int j = 0 ; j < 8 ; j++) {
    int a = target[j] >> 24;
    int b = (target[j] & 0x00ff0000) >> 16;
    int c = (target[j] & 0x0000ff00) >> 8;
    int d = target[j] & 0x000000ff;
    temp_target[j] = (d << 24)  + (c << 16)  + (b << 8) + a;
  }

  for(int j = 0 ; j < 8 ; j++ ) {
    new_target[j] = temp_target[7-j];
    printf("old %8.8x new %8.8x\n", new_target[j], temp_target[7-j]); 
  }

  // save the target data... 
  for(int j   = 0 ; j < 8; j++) {
    for(int i = 0 ; i < 4; i++) {
      s.target[j][i] = new_target[j];
    }
  }

   // starting nonces:
  //int starting_nonce = 2083236893 ;
  // int starting_nonce =   2083236578 ;
  int starting_nonce = 2000000004 ;
  //int starting_nonce = 0 ;
  for(int i = 0 ; i < 4; i++) {
    s.starting_nonce[i] = starting_nonce+i;
  }

  // FIXME:  need the real ending nonce. 
  unsigned int ending_nonce = starting_nonce ;
  for(int i = 0 ; i < 4; i++) {
    //s.ending_nonce[i] = ending_nonce + 100000000;
    s.ending_nonce[i] = 0x0ffffffff;
  }

  // FIXME: dummy this up so it's easy to recognise.  
  for(int i = 0 ; i < 4; i++) {
    s.rcode[i] = 0x13131313;
  }

  //hexdump((unsigned char *)&(s), sizeof(s));
  printf("BEFORE: s %p buffer[0] %8.8x and buffer[15] %8.8x\n", &s, buffer[0], buffer[15]);
  printf("starting nonce %d\n", starting_nonce);
 
  int nonce = asm_crunch(&s);

  printf("AFTER: nonce = %u rcode = %i %i %i %i \n", 
	 nonce, s.rcode[0],
	 s.rcode[1],
	 s.rcode[2],
	 s.rcode[3]);

  return 0;  
}
