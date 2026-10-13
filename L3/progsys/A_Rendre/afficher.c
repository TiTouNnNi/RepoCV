#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define SUFFIXE ".idx"

int main(int argc, char *argv[])
{
  assert(argc == 3);
  int i;
  int first = 0;
  int last = 0;
  char a;
  // construire le chemin au fichier index
  int l = strlen(argv[1]);
  char idx_filename[l + strlen(SUFFIXE) + 1];

  strncpy(idx_filename, argv[1], l);
  strcpy(idx_filename + l, SUFFIXE);

  int numline = atoi(argv[2]);

  int file_idx = open(idx_filename, O_RDONLY);
  int file = open(argv[1], O_RDONLY);


  if(numline < 0){
    printf("Le numéro de la ligne doit être supérieur ou égal à zéro.");
    return EXIT_SUCCESS;
  }
  
  else if(numline > 0){
   lseek(file_idx, (numline - 1) * sizeof(int), SEEK_SET);
   read(file_idx, &first, sizeof(int));
  }

   read(file_idx, &last, sizeof(int));
   lseek(file, first, SEEK_SET);

   char *line_to_display = malloc(last - first) + 1;
    line_to_display[last - first] = '\0';

    read(file, line_to_display, last - first);
    write(STDOUT_FILENO, line_to_display, last-first + 1);


  return EXIT_SUCCESS;
}
