#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>

#include "error.h"

int main(int argc, char **argv)
{
  assert (argc == 4); // Nom du fichier de sortie attendu en ligne de commande

  int buffer = atoi(argv[3]);
  char a[buffer];

  int r, w;
  /*
    _  __ ___
  rwx rwx rwx
  110 100 000
   
  -> 0640
  */
  int in = open(argv[1], O_RDONLY);
  check_syscall(in, "open in");
  int out = open(argv[2], O_CREAT | O_WRONLY | O_TRUNC, 0640);
  check_syscall(out, "open out");
  
  while((r = read(in,a,buffer)) > 0){
      check_syscall(r,"read");
      w = write(out,a,r);
      check_syscall(w,"write std");
  }

  close(in);
  close(out);

  return EXIT_SUCCESS;
}
