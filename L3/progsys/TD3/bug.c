#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>

int main(){
    int tube[2];
    pipe(tube);

    //1.2
    /*for(int i;;i++){
        write(tube[1],&i,1);
        printf("%d\n",i);
    }
    */

    //1.3

    close(tube[0]);
    int i=2;
    int r = write(tube[1],&i,1);
    printf("%d\n",r);
    //141=13+128
    //man 7 signal
    //SIGPIPE car on demande à écrire dans un pipe dans lecteur

    return EXIT_SUCCESS;
}