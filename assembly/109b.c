#include<stdio.h>

void puts_twice(const char *s);

int main(){
    char s[1000];
    while(~scanf("%s",s)){
        puts_twice(s);
    }
    return 0;
}

