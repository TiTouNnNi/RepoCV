#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main(int argc, char *argv[])
{
  check(argc == 3, "il faut trois arguments"); 
  char a;
  int r;
  FILE *in = fopen(argv[1], "r");
  check(in != NULL, "$s", argv[1]);

  FILE *out = fopen(argv[2], "w");
  check(out != NULL, "$s", argv[2]);

  while((r = fread(&a,sizeof(a),1, in))!=0)
  { 
    fwrite(&a,1, 1,out);
   }
  fclose(out);
  fclose(in);

  return 0;
}
