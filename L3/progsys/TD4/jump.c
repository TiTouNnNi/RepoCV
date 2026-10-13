#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <setjmp.h>


jmp_buf buf;

void g(){
    setjmp (buf);
}

void f(){
    longjmp (buf, 1);
}

int main (int argc, char *argv[]){
    int r=0;
    setjmp (buf);
    printf("%d\n",r);
    r++;
    if(r<9){
        f();
    }
    return 0;
}