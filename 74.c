#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

typedef struct lnode *List;
struct lnode {
  int data;
  List next;
};

List stack_push(List, int);
int stack_read(List);
List stack_pop(List);
List calc_add(List);
List calc_sub(List);
List calc_mul(List);

List stack_push(List l,int x){
  List n = malloc(sizeof(List));
  n->data = x;
  n->next = l;
  return n;
}
int stack_read(List l){
  return l->data;
}
List stack_pop(List l){
  List n = l->next;
  list_free(l);
  return n;
}
List calc_add(List l){
  int a = stack_read(l);
  l = stack_pop(l);
  int b = stack_read(l);
  l = stack_pop(l);
  l = stack_push(l,a + b);
  return l;
}
List calc_sub(List l){
  int a = stack_read(l);
  l = stack_pop(l);
  int b = stack_read(l);
  l = stack_pop(l);
  l = stack_push(l,b - a);
  return l;
}
List calc_mul(List l){
  int a = stack_read(l);
  l = stack_pop(l);
  int b = stack_read(l);
  l = stack_pop(l);
  l = stack_push(l,a * b);
  return l;
}


List list_empty()
{
  /* 空リストを返す。 */
  List l = malloc(sizeof(List));
  l->data = NULL;
  l->next = NULL;
  return l;
}
int list_isempty(List l)
{
  /* `l'が空リストなら0以外を、そうでないなら0を返す。 */
  if(l->data == NULL && l->next == NULL) return 1;
  else return 0;
}
void list_free(List l)
{
  free(l);
}

int main(int argc, char *argv[])
{
  List st;
  char cmd[10];

  st = list_empty();

  while ((scanf("%9s", cmd) != EOF) && (cmd[0] != '=')) {
    if (isdigit(cmd[0])) {
      st = stack_push(st, atoi(cmd));
    } else if (cmd[0] == '+') {
      st = calc_add(st);
    } else if (cmd[0] == '-') {
      st = calc_sub(st);
    } else if (cmd[0] == '*') {
      st = calc_mul(st);
    } else {
      printf("(unknown command)\n");
    }
    cmd[0] = '\0';
  }
  if (! list_isempty(st)) {
    printf("%d\n", stack_read(st));
  }

  list_free(st);

  return 0;
}
