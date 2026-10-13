#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char *argv[])
{
  check(argc == 2, "il faut deux arguments"); 
  char a;
  int r, w;
  int out = open(argv[1], O_CREAT | O_WRONLY | O_TRUNC, 0640);
  check_syscall(out,"%s",argv[1]);

  while((r = read(0,&a,1))!=0)
  { // on peut mettre stdin aussi à la place de 0
    check_syscall(r,"read");
    w = write(1,&a,1);
    check_syscall(w,"write std");
    w = write(out,&a,1);
    check_syscall(w,"write out");
   }
  int c = close(out);
  check_syscall(c,"close");
  return 0;
}
