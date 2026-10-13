#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <assert.h>

#include "error.h"

void quelques_prints (void)
{
  printf ("Juste");
  printf (" histoire");
  printf (" de tester...\n");
  printf ("...que la redirection");
  printf (" marche !\n");
}

void rediriger_vers (void (*f)(void), char *file)
{
  int out = open(file, O_WRONLY | O_CREAT | O_TRUNC, 0640);
  check_syscall(out, "open file");

  int w,r,backup;
  char c;

  backup = dup(1);
  dup2(out,1);

  f();

  dup2(backup,1);

  close(out);
}

int main(int argc, char *argv[])
{
  printf ("*** DEBUT ***\n");

  rediriger_vers (quelques_prints, "sortie.txt");

  printf ("*** FIN ***\n");

  return EXIT_SUCCESS;
}
  
