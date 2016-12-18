#include<stdio.h>
#include<stdlib.h>

typedef struct pair *Pair;
struct pair{
    int first;
    int second;
}; 

typedef struct pq *Pq;
struct pq{
    Pair p;
    Pq right;
    Pq left;
};

Pair pair_new(int x,int y)
{
    Pair p = malloc(sizeof(Pair)+100);
    p->first = x;
    p->second = y;
    return p;
}

Pq pq_new()
{
    Pq pque = malloc(sizeof(Pq)+100);
    pque->right = NULL;
    pque->left = NULL;
    return pque;
}

int pq_isempty(Pq pque)
{
    if(pque->right == NULL && pque->left == NULL) return 1;
    else return 0;
}

Pq pq_push(Pq pque, Pair pair){
    
}

int main(){
    return 0;
}
