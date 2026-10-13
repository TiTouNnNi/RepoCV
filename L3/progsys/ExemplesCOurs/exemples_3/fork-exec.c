#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define pprintf(format, ...) printf ("[PID %d] " format, getpid(), ##__VA_ARGS__)

int main (int argc, char *argv[])
{
  pid_t pid;

  pid = fork ();
  if (pid) { // father
    // TODO
    // pprintf ("Child exited with return code %d\n", WEXITSTATUS (status));
  } else { // Child
    // TODO
  }

  return 0;
}
