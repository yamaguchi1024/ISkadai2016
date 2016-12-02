#include <stdio.h>
#include <string.h>
 
#define SIZE 1000
 
void init(char a[][100], int j)
{
    int i;
    for (i = 0; i < j; i++) {
        a[i][0] = '\0';
    }
}
 
void puta(char a[][100], int j)
{
    int i;
    for (i = 0; i < j; i++) {
        printf("%s\n", a[i]);
    }
}
 
void my_qsort(char a[][100], int i, int j)
{
  int left = i, right = j;
  char pi[100];
  int pivot = (left+right)/2;
  strcpy(pi,a[pivot]);

  while(1){
    //printf("strcmp: %d pi: %c a[left]: %c left: %d \n",strcmp(pi,a[left]),pi[0],a[left][0],left);
    //printf("strcmp: %d pi: %c a[right]: %c right: %d \n",strcmp(pi,a[right]),pi[0],a[right][0],right);
    while(strcmp(pi,a[left])>0) left++;
    while(strcmp(pi,a[right])<0) right--;
    if(left>=right) break;
    char tmp[100];
    strcpy(tmp,a[left]);
    strcpy(a[left],a[right]);
    strcpy(a[right],tmp);
    left++;
    right--;
  }
  if(i < left - 1) my_qsort(a,i,left - 1);
  if(right + 1 < j) my_qsort(a,right + 1,j);
}

void my_sort(char a[][100], int n)
{
  my_qsort(a, 0, n-1);
}

int main(int argc, char *argv[])
{
  char a[SIZE][100];
  int j;

  init(a, SIZE);

  for (j = 0; j < SIZE; j++) {
    if (scanf("%99s", a[j]) == EOF) break;
  }

  my_sort(a, j);

  puta(a, j);

  return 0;
}
