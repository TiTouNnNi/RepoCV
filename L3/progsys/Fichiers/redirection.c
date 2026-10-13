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
  int fd = open(file, O_CREAT | O_WRONLY | O_TRUNC, 0640);
  int backup = dup(STDOUT_FILENO); 
  dup2(fd, STDOUT_FILENO);
  close(fd);
  f();
  dup2(backup, STDOUT_FILENO);
}

int main(int argc, char *argv[])
{
  printf ("*** DEBUT ***\n");

  rediriger_vers (quelques_prints, "sortie.txt");

  printf ("*** FIN ***\n");

  return EXIT_SUCCESS;
}
  
