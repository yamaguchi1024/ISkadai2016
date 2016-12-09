#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>

char po[]="\0";
typedef char *String;
typedef struct list *List;
struct list {
    String key;
    String value;
    List next;
};
List hashtable[30];

char quit[]="quit";
char insert[]="insert";
char search[]="search";
char delete[]="delete";


void list_free1(List l){
    free(l->key);
    free(l->value);
    free(l);
}

void list_free2(List l){
    free(l->key);
    free(l->value);
    if(l->next != NULL) list_free2(l->next);
    free(l);
}
List list_empty(){
    List l = malloc(30);
    l->key = (char*)malloc(100);
    l->value = (char*)malloc(100);
    strcpy(l->key,po);
    strcpy(l->value,po);
    l->next=NULL;
    return l;
}

int is_list_empty(List l){
    if(!strcmp(l->key,po)) return 1;
    else return 0;
}

int cal_hash(String key){
    int len = strlen(key);
    int i;
    int res=0;
    for(i=0;i<len;i++){
        res += (int) key[i];
    }
    return (res%30);
}

void list_insert2(List l,String key,String value){
    if(is_list_empty(l)){
        strcpy(l->key,key);
        strcpy(l->value,value);
        l->next = list_empty();
    }
    else if(!strcmp(l->key,key)){
        strcpy(l->value,value);
    }
    else{
        list_insert2(l->next,key,value);
    }
    return;
}

void list_insert(String key, String value){
    int hash = cal_hash(key);
    list_insert2(hashtable[hash],key,value);
    return;
}

List list_delete2(List l,String key){
    if(!strcmp(l->key,key)){
        list_free1(l);
        if(l->next == NULL) return list_empty();
        else return l->next;
    }else{
        l->next = list_delete2(l->next,key);
        return l;
    } 
}

void list_delete(String key){
    int hash = cal_hash(key);
    hashtable[hash] = list_delete2(hashtable[hash],key);
    return;
}

String list_search2(List l,String key){
    if(!strcmp(l->key,key)) return l->value;
    else if(!strcmp(l->key,po)) return l->value;
    else return list_search2(l->next,key);
}

String list_search(String key){
    int hash = cal_hash(key);
    String s = list_search2(hashtable[hash],key);
    return s;
}


int main(int argc,char *argv[])
{
    char cmd[20];
    char key[20];
    char val[20];

    int i;
    for(i=0;i<30;i++) hashtable[i]=list_empty();

    while((scanf("%19s",cmd) !=EOF) && (strcmp(quit,cmd))){
        if(!strcmp(insert,cmd)){
            scanf("%19s",key);
            scanf("%19s",val);
            list_insert(key,val);
        }
        else if(!strcmp(delete,cmd)){
            scanf("%19s",key);
            list_delete(key);
        }
        else if(!strcmp(search,cmd)){
            scanf("%19s",key);
            String res = list_search(key);
            if(!strcmp(res,po)) printf("(not found)\n");
            else printf("%s\n",res);
        }
    }
    for(i=0;i<30;i++) list_free2(hashtable[i]);
    return 0;
}
