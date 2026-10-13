#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include "error.h"

int main(int argc, char** argv){

    pid_t child = fork();
    if(child==0){
        execvp(argv[1], argv+1);
        perror("/bin/sh");
        exit(EXIT_FAILURE);
    }

    int status;
    wait(&status);
    printf("Code de retour : %d\n",status);

    exit(EXIT_SUCCESS);
}