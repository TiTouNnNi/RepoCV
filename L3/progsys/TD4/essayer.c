#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <setjmp.h>
#include <signal.h>

void bug(int code){
    printf("erreur\n");
}

int essayer(void * fun, void * p, int signal){
    struct sigaction a;
    a.sa_handler=bug;
    a.sa_flags = 0;
    sigemptyset(&a.sa_mask);
    sigaction(signal,&a,NULL);
}

void f(void*p){
    p+1;
}

int main(){
    int r;
    r = essayer(f,NULL,SIGSEGV);
    if(r==0){
        printf("ca marche\n");
    }
    else {
        printf("ca marche pas\n");
    }
}