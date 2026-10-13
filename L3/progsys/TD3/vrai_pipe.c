#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>

int valeurStatus(int s){
    if(WIFEXITED(s)) return WEXITSTATUS(s);
    return WTERMSIG(s)+128;
}

int main(int argc, char* argv[]){
    int f1,f2;
    int tube[2];
    pipe(tube);
    f1=fork();
    if(f1 == 0){ //ls
        close(tube[0]);
        dup2(tube[1],STDOUT_FILENO); 
        close(tube[1]);
        execlp(argv[1],argv[1],NULL);
        printf(stdout,"f1.txt");
    }

    if((f2=fork()) == 0){ //cat
        dup2(tube[0],STDIN_FILENO);
        close(tube[0]);
        close(tube[1]);
        execvp(argv[2],argv+2);     
    }

    close(tube[1]);
    close(tube[0]);
    int s1,s2;
    waitpid(f1,&s1,0);
    waitpid(f2,&s2,0);
    if(s1!=NULL){
        exit(s1);
    }
    else{
        exit(s2);
    }


    // le pipe est bloquant tant qu'il y a un ecrivain et non bloquant quand n'y en a plus
}