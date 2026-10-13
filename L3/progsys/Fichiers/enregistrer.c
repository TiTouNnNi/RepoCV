#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char *argv[])
{
  check(argc == 4, "il faut quatre arguments"); 
  off_t val = atoi(argv[3]);

  off_t pos = atoi(argv[2]);

  int out = open(argv[1], O_WRONLY | O_TRUNC | O_CREAT, 0640);
  check_syscall(out,"%s",argv[1]);

  lseek(out, pos, SEEK_SET);
  
  int w = write(out,&val, sizeof val);
  check_syscall(w, "write out");

  int c = close(out);

 return 0;
}
