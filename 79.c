#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
#define LAGE 100000000

char a[1003][1000];
int map[1003][1000];
char start[1000];
char fin[1000];
char tmp[1000];
int dis;
int d[1003];
int used[1003];
int prev[1003];
int size = 0;

int stoi(char * tmp){
    int i=0;
    for(i=0;i<1003;i++){
        if(!strcmp(a[i],tmp)){
            break;
        }else if(a[i][0]==0){
            strcpy(a[i],tmp);
            break;
        }
    }
    return i;
}
void init(){
    int i,j;
    for(i=0;i<1002;i++){
        for(j=0;j<1002;j++){
            map[i][j]=LAGE;
            a[i][j]=0;
        }
    }
}

void dijekstra(int s){
    int i;
    for(i=0;i<=size;i++){
        d[i]=LAGE;
        used[i]=0;
        prev[i]=-1;
    }
    d[s]=0;

    while(1){
        int v = -1;
        int u=0;
        for(u=0;u<size;u++){
            if(!used[u] && (v == -1 || d[u] < d[v])) v=u;
        }

        if(v==-1) break;
        used[v]=1;

        for(u=0;u<size;u++){
            if(d[u] > d[v] + map[v][u]){
                d[u] = d[v] + map[v][u];
                prev[u] = v;
            }
        }
    }
}


void get_path(int f){
    int tmp[2000];
    int t;
    for(t=0;t<=size;t++) tmp[t]=LAGE;
    int si = 0;
    for(; f!= -1; f=prev[f]) {
        tmp[si]=f;
        si++;
    }
    int i=si;
    for(i=si-1;i>=0;i--){
        printf("%s\n",a[tmp[i]]);
    }
}

int main(){
    init();
    scanf("%s",start);
    scanf("%s",fin);
    while(1){
        if(scanf("%s",tmp)==EOF) break;
        int s = stoi(tmp);
        scanf("%s",tmp);
        int f = stoi(tmp);
        scanf("%d",&dis);
        map[s][f]=dis;
    }
    int st = stoi(start);
    int fi = stoi(fin);
    while(1){ if(a[size][0]==0) break;
        size++;}

    dijekstra(st);
    get_path(fi);

    return 0;
}
