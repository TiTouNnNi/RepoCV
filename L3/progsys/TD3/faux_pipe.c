#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>


#define TEMP_FILE "/tmp/faux_pipe.tmp"

int main(int argc, char* argv[]){
    if(fork() == 0){ //ls
        int out = open(TEMP_FILE, O_WRONLY,0600);
        dup2(out,STDOUT_FILENO);
        close(out);
        execlp(argv[1],argv[1],NULL);
    }
    // cat
    wait(NULL);
    int in = open(TEMP_FILE,O_RDONLY || O_CREAT || O_TRUNC);
    dup2(in,STDIN_FILENO);
    close(in);
    execvp(argv[2],argv+2);
}