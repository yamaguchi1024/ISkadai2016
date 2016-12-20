#include<stdio.h>

int enlarge(int x);

int main(){
    long x;
    while(scanf("%ld",&x) != EOF){
    printf("%ld\n",enlarge(x));
    }
    return 0;
}
