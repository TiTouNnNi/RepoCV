#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include "error.h"

int main(){
    __pid_t pere = getpid(); //on aurait pu utiliser getppid
    check_syscall(pere,"fork pere");
    __pid_t fils = fork();
    check_syscall(fils,"fork fils");

    if(fils==0){ //code utilisé par les fils
        getchar(); //pour tester orphelin
        printf("je suis %d le fils de %d\n",getpid(), pere);
        exit(0);
    }
    //code executé que part le pere
    printf("je suis %d le pere de %d\n",pere,fils);
    //wait(NULL); //deterministe car le wait attend que le processus fils soit terminé
    printf("seul le pere dit au revoir\n");

    return EXIT_SUCCESS;
}