#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char* argv[]){
    assert(argc==4);

    int w;
    
    int out = open(argv[1], O_WRONLY | O_CREAT , 0640);
    check_syscall(out, "open out");
    
    int pos = atoi(argv[2])*sizeof(off_t);
    off_t val = atoi(argv[3]);

    lseek(out, pos, SEEK_SET);

    write(out,&val,sizeof(val));
    check_syscall(w,"write std");

    close(out);

    return EXIT_SUCCESS;
}