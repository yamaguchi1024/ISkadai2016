//二次元配列で頑張らなくてもいいかなあと思いました。この方が単純だし。

#include<stdio.h>
#include<string.h>

int main(){
  char a[100],f[100],c[100],d[100];
  scanf("%s",a);
  scanf("%s",f);
  int p;
  int res = 1000000000;
  char mama[200];
  strcpy(mama,a);
  while(scanf("%s",c)!=EOF){
    scanf("%s",d);
    scanf("%d",&p);
    if(!strcmp(a,c)) if(res > p) {res = p; strcpy(mama,d);}
    if(!strcmp(a,d)) if(res > p) {res = p; strcpy(mama,c);}
  }
  printf("%s\n",mama);

  return 0;
}
