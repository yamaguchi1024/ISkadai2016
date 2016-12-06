#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>

char po[]="\0";
typedef char *String;
typedef struct tnode *BTree;
struct tnode {
    String key;
    String value;
    BTree left;
    BTree right;
};

void btree_free(BTree t)
{
    if((t->right)!=0) free(t->right);
    if((t->left)!=0) free(t->left);
    if(t->value !=NULL) free(t->value);
    if(t->key != NULL) free(t->key);
    free(t);
}


BTree btree_empty()
{
    BTree bt = malloc(sizeof(BTree)+100);
    bt->value = (char *)malloc(100);
    bt->key = (char *)malloc(100);
    strcpy(bt->value,po);
    strcpy(bt->key,po);
    bt->left = 0;
    bt->right = 0;
    return bt;
}
int btree_isempty(BTree t)
{
    if(t->left == 0 && t->right == 0) return 1;
    else return 0;
}

BTree btree_insert(String key,String val,BTree t)
{
    if(btree_isempty(t))
    {
        strcpy(t->key,key);
        strcpy(t->value,val);
        t->left = btree_empty();
        t->right = btree_empty();
    }
    else if(!strcmp(t->key,key))
    {
        strcpy(t->value,val);
    }
    else if(strcmp(t->key,key)<0)
    {
        btree_insert(key,val,t->right);
    }
    else
    {
        btree_insert(key,val,t->left);
    }
    return t;
}
BTree btree_delete1(String key,BTree t)
{
    btree_free(t);
    t = btree_empty();
    return t;
}

BTree btree_delete2(String key,BTree t)
{
    if(btree_isempty(t->right)) t = t->left;
    else t = t->right;
    return t;
}
BTree search_min(BTree t)
{
    if(btree_isempty(t->left)) return t;
    else return search_min(t->left);
}
void del_min(BTree min,BTree t)
{
    if(t->left == min){ btree_free(t->left); t->left = btree_empty();}
    else del_min(min,t->left);
}
BTree btree_delete3(String key,BTree t)
{
    BTree min = search_min(t->right);
    strcpy(t->key,min->key);
    strcpy(t->value,min->value);
    del_min(min,t->right);
    return t;
}

BTree btree_delete(String key,BTree t)
{
    if(!strcmp(key,t->key))
    {
        if(btree_isempty(t->right) && (btree_isempty(t->left)))
        {
            btree_delete1(key,t);
        }
        else if(btree_isempty(t->right) || (btree_isempty(t->left)))
        {
            btree_delete2(key,t);
        }
        else btree_delete3(key,t);
    }
    else
    {
        if(strcmp(t->key,key)<0) btree_delete(key,t->right);
        else btree_delete(key,t->left);
    }
    return t;

}
struct tnode *btree_search(String key,BTree t)
{
    if(btree_isempty(t)) return t;
    else if(!strcmp(key,t->key))
    {
        return t;
    }else
    {
        if(strcmp(key,t->key)>0) return btree_search(key,t->right);
        else return btree_search(key,t->left);
    }
}

char quit[]="quit";
char insert[]="insert";
char search[]="search";
char delete[]="delete";
int main(int argc,char *argv[])
{
    BTree bt;
    char cmd[20];
    char key[20];
    char val[20];

    bt = btree_empty();

    while((scanf("%19s",cmd) !=EOF) && (strcmp(quit,cmd))){
        if(!strcmp(insert,cmd)){
            scanf("%19s",key);
            scanf("%19s",val);
            bt = btree_insert(key,val,bt);
        }
        else if(!strcmp(delete,cmd)){
            scanf("%19s",key);
            bt =  btree_delete(key,bt);
        }
        else if(!strcmp(search,cmd)){
            scanf("%19s",key);
            struct tnode *res = btree_search(key,bt);
            if(!strcmp(res->value,po)) printf("(not found)\n");
            else printf("%s\n",res->value);
        }
    }
    btree_free(bt);
    return 0;
}
