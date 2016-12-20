#include<stdio.h>

char *mystrcat(char *dest,const char *src);

int main(){
    char s[1000];
    char a[1000];

    while(~scanf("%s %s",s,a)){
        printf("%s\n",mystrcat(s,a));
    }
    return 0;
}
