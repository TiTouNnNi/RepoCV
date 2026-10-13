#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char **argv)
{
  assert (argc == 2); // Nom du fichier de sortie attendu en ligne de commande

  char a;
  int r, w;
  /*
    _  __ ___
  rwx rwx rwx
  110 100 000
   
  -> 0640
  */
  int out = open(argv[1], O_CREAT | O_WRONLY | O_TRUNC,0640);
  check_syscall(out, "open");

  while((r = read(0,&a,1)!= 0)){
      check_syscall(r,"read");
      w = write(1,&a,1);
      check_syscall(w,"write std");
      w = write(out,&a,1);
      check_syscall(w,"write out");
  }
  return EXIT_SUCCESS;
}
