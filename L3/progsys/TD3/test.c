#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>
#include <signal.h>

int main(){
    int f1=fork();

    if(f1==0){
        while(1){
            sleep(1);
            printf("test\n");
        }
    }

    int code=1;
    sleep(4);
    kill(f1,SIGKILL);
    waitpid(f1,&code,0);

    printf("command exit code = %d\n",code);

    return EXIT_SUCCESS;
}