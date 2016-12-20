#include<stdio.h>

void swap_gt(int *x,int*y);

int main(){
    int x;
    int y;
    while(~scanf("%d %d",&x,&y)){
        swap_gt(&x,&y);
        printf("%d %d\n",x,y);
    }

    return 0;
}
