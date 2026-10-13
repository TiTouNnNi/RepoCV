#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char *argv[])
{
  check(argc == 3, "il faut trois arguments"); 
  off_t val=-1;
  off_t pos = atoi(argv[2]) * sizeof val;

  int in = open(argv[1], O_RDONLY);
  check_syscall(in,"%s",argv[2]);

  lseek(in, pos, SEEK_SET);

  int r = read(in,&val, sizeof val);
  check_syscall(r, "read");
  printf("%ld\n", val);

  int c = close(in);

 return 0;
}
