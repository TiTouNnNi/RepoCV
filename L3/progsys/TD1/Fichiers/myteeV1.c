#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main()
{
    char a;
    int r, w;
    while((r = read(0,&a,1)!= 0)){
        check_syscall(r,"read");
        w = write(STDOUT_FILENO,&a,1);
        check_syscall(r,"write");
    }
  return EXIT_SUCCESS;
}
