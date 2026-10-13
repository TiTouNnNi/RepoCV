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
  int r, w;
  char a[];

  int err = open("ERREUR-LIRE.log", O_CREAT | O_WRONLY | O_APPEND, 0640); 
  check_syscall(err,"%s","ERREUR LOG");

  dup2(err,STDERR_FILENO);
  close(err);
  check_syscall(err,"close");


  int in = open(argv[1], O_RDONLY);
  check_syscall(in,"%s",argv[1]);

    printf()
  return 0;
}