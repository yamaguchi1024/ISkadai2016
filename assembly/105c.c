#include<stdio.h>

int fib(int n);

int main(){
    int n;
    while(~scanf("%d",&n)){
        printf("%d\n",fib(n));
    }
    return 0;
}
