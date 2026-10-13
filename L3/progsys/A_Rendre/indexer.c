#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define SUFFIXE ".idx"
#define BUF_SIZE 2048

int main(int argc, char *argv[])
{
  assert(argc == 2);

  // construire le chemin au fichier index
  int l = strlen(argv[1]);
  char c;
  char file_idx_name[l + strlen(SUFFIXE) + 1];
  strncpy(file_idx_name, argv[1], l);
  strcpy(file_idx_name + l, SUFFIXE);

  int file = open(argv[1], O_RDONLY);

  int file_idx = open(file_idx_name, O_CREAT | O_WRONLY | O_TRUNC, 0640);

  int pos = 0;
  while(read(file,&c,sizeof(char)) != 0){
    if(c == '\n'){
      write(file_idx,&pos,sizeof(int));
    }
    pos++;
  }

  return EXIT_SUCCESS;
}
