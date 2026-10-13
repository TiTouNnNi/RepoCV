#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>

void traitant(int s){
    struct sigaction b;
    b.sa_handler = SIG_DFL;
    b.sa_flags = 0;
    sigemptyset(&(b.sa_mask));
    sigaction(SIGINT,&b, NULL);
    printf("ctrl-c\n");
}

int main(){
    struct sigaction a;
    a.sa_handler = traitant;
    a.sa_flags = 0;
    sigemptyset(&(a.sa_mask));

    sigaction(SIGINT, &a, NULL);

    while(1){
        pause();
    }
}