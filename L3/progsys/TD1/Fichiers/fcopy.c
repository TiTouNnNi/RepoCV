#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char **argv)
{
  assert (argc == 3); // Nom du fichier de sortie attendu en ligne de commande

  char a;
  FILE* in = fopen(argv[1], "r");
  FILE* out = fopen(argv[2], "w");
  assert(in!=0 && out!=0);

  while(fread(&a,sizeof(char),1,in)){
        fwrite(&a,sizeof(char),1,out);
  }

  fclose(in);
  fclose(out);
  
  return EXIT_SUCCESS;
}