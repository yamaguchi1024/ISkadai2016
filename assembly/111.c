#include<stdio.h>
#include<stdlib.h>

typedef struct myuint128 {
    unsigned long digit0;
    unsigned long digit1;
} myuint128_t;

int eq128(myuint128_t a,myuint128_t b){
    return a.digit0 == b.digit0 && a.digit1 == b.digit1;
}

myuint128_t add128(myuint128_t a,myuint128_t b){
    unsigned long digit0,digit1;
    __asm__("addc %0,%1,%2"
            : "=r"(digit0)
            : "r"(a.digit0),"r"(b.digit0)
            : "ca");
    __asm__("adde %0,%2,%1"
            : "=r"(digit1)
            : "r"(a.digit1),"r"(b.digit1)
            : "ca");
    return (myuint128_t){digit0,digit1};
}

const myuint128_t tests[][3] = {
    {{0xA05F44019BD79748UL, 0x0000000000003995UL}, {0x7B6F88EC052868B8UL, 0x0000000000009A2CUL}, {0x1BCECCEDA1000000UL, 0x000000000000D3C2UL}},
    {{0xBEAED78ACDC6F714UL, 0x1934D10F478850D4UL}, {0xE69D35AFE6995719UL, 0x0805961D75476A77UL}, {0xA54C0D3AB4604E2DUL, 0x213A672CBCCFBB4CUL}},
    {{0xD97482C3148C06ADUL, 0x81981582D4ED6486UL}, {0xEFBBAA3E5DD5089FUL, 0x8FE78CB9DAD947E9UL}, {0xC9302D0172610F4CUL, 0x117FA23CAFC6AC70UL}}
};

int main() {
    int i;
    for(i = 0; i < (int)(sizeof(tests) / sizeof(*tests)); ++i) {
        myuint128_t r = add128(tests[i][0], tests[i][1]);
        printf("add128(0x%016lx%016lx, 0x%016lx%016lx) = 0x%016lx%016lx\n",
                tests[i][0].digit1, tests[i][0].digit0,
                tests[i][1].digit1, tests[i][1].digit0,
                r.digit1, r.digit0);
        if(!eq128(r, tests[i][2])) 
	    printf("wrong!!:%d\n",i);
        
    }
    return 0;
}

