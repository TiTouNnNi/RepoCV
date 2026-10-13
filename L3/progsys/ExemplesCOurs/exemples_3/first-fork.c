#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define pprintf(format, ...) printf ("[PID %d] " format, getpid(), ##__VA_ARGS__)

int main (int argc, char *argv[])
{
  pprintf ("Avant\n");
  fork (); fork();
  
  pprintf ("Bonjour !\n");

  return 0;
}
