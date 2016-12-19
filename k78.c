#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
typedef struct _node node;
int n;
char* dic[1005];
int s2i(char* s){
    int i;
    for(i=0;i<1005;i++){
        if(n<i+1)n=i+1;
        if(dic[i]==NULL){
            dic[i] = malloc(strlen(s)+1);
            strcpy(dic[i],s);
            return i;
        }
        if(strcmp(dic[i],s)==0)return i;
    }
    return -1;
}
int ds[1005][1005];
int ts[1005][1005];
int en[1005];
void add(int a,int b,int d){
    //printf("%d %d %d\n",a,b,d);
    ds[a][en[a]]=d;
    ts[a][en[a]]=b;
    en[a]++;
}
int h[1005];
void velm(int st,int gl){
    int i,j,k,ud,no,to,d,nt;
    memset(h,0,sizeof(h));
    for(i=0;i<n;i++)h[i]=-1;
    h[st]=0;
    for(;;){
        ud=0;
        for(no=0;no<n;no++){
            if(h[no]<0)continue;
            for(k=0;k<en[no];k++){
                to=ts[no][k];
                d=ds[no][k];
                if(h[to]<0 || h[no]+d<h[to]){
                    h[to]=h[no]+d;
                    ud=1;
                }
            }
        }
        if(ud)continue;
        break;
    }
    for(i=0;i<n;i++) printf("%s %d\n",dic[i],h[i]);
    no=gl;
    for(;no!=st;){
        puts(dic[no]);
        for(k=0;k<en[no];k++){
            to=ts[no][k];
            if(h[no]==h[to]+ds[no][k]){
                no=to;
                break;
            }
        }
    }
    puts(dic[st]);
}
int main(){
    int st,gl,a,b,c,d,i,ans,nd;
    char s[105],ss[105];
    memset(dic,0,sizeof(dic));
    memset(en,0,sizeof(en));
    scanf("%s\x0a",s);
    st = s2i(s);
    scanf("%s\x0a",s);
    gl = s2i(s);
    for(;~scanf("%s	%s	%d\x0a", s,ss,&d);){
        a = s2i(s);
        b = s2i(ss);
        //printf("%d %d %d\n",a,b,d);
        add(a,b,d);
        add(b,a,d);
    }
    velm(gl,st);

    /*
       if(en[st]==0)ans=st;
       else{
       nd=ds[st][0]; ans=ts[st][0];
       for(i=1;i<en[st];i++){
       if(ds[st][i]<nd){
       nd=ds[st][i];
       ans=ts[st][i];
       }
       }
       }
    //printf("%d\n",ans);
    printf("%s\n",dic[ans]);
    */

    //for(i=0;i<10;i++)printf("%s\n",dic[i]);


    return 0;
}
