#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include "error.h"

void System(char* c){
    pid_t pid = fork();
    if(pid==0){
        execl("/bin/sh","coui","-c",c,NULL);
        perror("/bin/sh");
        exit(1);
    }
    waitpid(pid,NULL,0);
    //wait(NULL); //mieux
}
int main(){
    System("sleep 2 ; echo bjr");
    System("echo bye");
    return 0;
}
