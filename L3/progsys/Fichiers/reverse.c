#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char *argv[])
{  
    check(argc == 3, "il faut quatre arguments"); 
    char a;
    int r, w;
    int in = open(argv[1], O_RDONLY);
    check_syscall(in,"%s",argv[1]);
    int len = lseek(fd,0,SEEK_END);

    int out = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0640);
    check_syscall(out,"%s",argv[2]);

    while((r = read(in,&buffer,taille)) != 0 )
    { 
        check_syscall(r,"read");
        // w = write(1,&a,1);
        // check_syscall(w,"write std");
        w = write(out,&buffer,r);
        check_syscall(w,"write out");
    }

    int c = close(out);
    check_syscall(c,"close");
    c = close(in);
    check_syscall(c,"close");
    return 0;
}
