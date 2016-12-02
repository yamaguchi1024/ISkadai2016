#include<stdio.h>
#define half(x) x/2
#define half3(x) (x)/2
double half2(int x){
  return (double)x/2;
}

int main(){
        printf("x: \"3*4+3\" \n");
        printf("#define half(x) x/2: %f\n",(double)half(3*4+3));
        printf("double half2(int x){ return (double)x/2;}: %f\n",(double)half2(3*4+3));
        printf("#define half(x) (x)/2: %f\n",(double)half3(3*4+3));

        return 0;
}
