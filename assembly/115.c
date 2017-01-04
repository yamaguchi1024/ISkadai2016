#include<stdio.h>
#include<signal.h>
#include<errno.h>
#include<stdlib.h>
#include<setjmp.h>

double cantor(double x) {
  if(x != x) return x;
  else if(x <= 0.0) return 0.0;
  else if(x * 3 < 1.0) return cantor(x * 3.0) * 0.5;
  else if(x * 3 <= 2.0) return 0.5;
  else if(x < 1.0) return cantor((x - 0.5) * 3 - 0.5) * 0.5 + 0.5;
  else return 1.0;
}

sigjmp_buf mark;

void mymama(){
    perror("mymama\n");
    siglongjmp(mark,-1);
}
void recover(){
    printf("0.0\n");
}

int main(){
    if(sigsetjmp(mark,1) != 0){
        recover();
        exit(1);
    }

    stack_t ss;
    ss.ss_sp = malloc(SIGSTKSZ);
    ss.ss_size = SIGSTKSZ;
    ss.ss_flags = 0;
    sigaltstack(&ss,NULL);

    struct sigaction mama;
    mama.sa_sigaction = mymama;
    sigemptyset(&mama.sa_mask);
    mama.sa_flags=SA_SIGINFO|SA_ONSTACK;
    sigaction(SIGSEGV,&mama,NULL);

    double a;
    scanf("%lf",&a);
    printf("%lf\n",cantor(a));

    return 0;

}

