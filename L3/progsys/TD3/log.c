#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>

int main(int argc, char* argv[]){
    assert(argc>=3);

    char* file = argv[1];
    char* command = argv[2];

    int tube[2];
    pipe(tube);

    int f1,f2;

    if((f1=fork())==0){
        dup2(tube[1],STDOUT_FILENO);
        close(tube[0]);
        close(tube[1]);
        execvp(command,argv+2);
    }

    if((f2=fork())==0){
        dup2(tube[0],STDIN_FILENO);
        close(tube[0]);
        close(tube[1]);
        execlp("tee","tee",file,NULL);
    }

    close(tube[0]);
    close(tube[1]);

    int s1,s2; //il faut que le pere termine tout le temps
    waitpid(f1,&s1,0);
    waitpid(f1,&s2,0);
    printf("command exit code = %d\n",s1);
    printf("tee exit code = %d\n",s2);

    return EXIT_SUCCESS;
}