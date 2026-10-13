#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "error.h"

char *FILENAME="output.txt";

int main (int argc, char *argv[])
{
  int fd = open (FILENAME, O_WRONLY | O_CREAT, 0666);
  check_syscall (fd, "Cannot open %s file", FILENAME);

  dup2 (fd, STDOUT_FILENO); close (fd);

  printf ("I am about to become \"ls -l > output.txt\"\n");

  execl ("/bin/ls", "ls", "-l", NULL);
  perror ("execl");

  return EXIT_FAILURE;
}
