#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
  printf ("I am about to become \"ls -l\"\n");

  // TODO
  execlp ("ls", "ls", "-l", NULL);

  printf ("Ouf!\n");
  
  return EXIT_FAILURE;
}
