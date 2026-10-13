#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char* argv[]){
    int r;
    int w;
    int d;
    off_t buff;

    int err = open("ERREUR-LIRE.log",O_WRONLY | O_CREAT | O_APPEND, 0600);
    check_syscall(err, "open out2");

    d=dup2(err,2);
    check_syscall(d,"dup2");

    if(argc!=2){
        fprintf(stderr,"pas assez d'arg\n");
        return EXIT_FAILURE;
    }

    int out = open(argv[1], O_RDONLY);
    check_syscall(out, "open out");

    int pos = atoi(argv[2])*sizeof(off_t);

    lseek(out, pos, SEEK_SET);

    r=read(out,&buff,sizeof(off_t));
    check_syscall(r,"read file");

    printf("%jd\n", buff);

    close(out);
    close(err);
    
    return EXIT_SUCCESS;
}