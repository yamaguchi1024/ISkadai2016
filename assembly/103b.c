#include<stdio.h>

int enlarge(int x);

int main(){
    int x;
    while(scanf("%d",&x) != EOF){
    printf("%d\n",enlarge(x));
    }
    return 0;
}
