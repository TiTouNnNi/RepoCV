#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include "error.h"

int main(int argc, char** argv){
    assert(argc==2);
    int count = atoi(argv[1]);

    for(int i=0;i<(count+1);i++){
        pid_t child = fork();
        check_syscall(child,"fork child\n");
        if(child==0){
            printf("%d\n",i);
            exit(0);
        }
        wait(NULL);
    }
    printf("fin venant du pere\n");
    exit(0);
}