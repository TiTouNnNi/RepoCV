#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "error.h"

#define SUFFIXE ".idx"

int main(int argc, char *argv[])
{
  assert(argc == 3);

  // construire le chemin au fichier index
  int l = strlen(argv[1]);
  char idx_filename[l + strlen(SUFFIXE) + 1];

  strncpy(idx_filename, argv[1], l);
  strcpy(idx_filename + l, SUFFIXE);

  int in,index,r;

  in = open(argv[1],O_RDONLY);
  check_syscall(in,"open in\n");

  index = open(idx_filename, O_RDONLY);
  check_syscall(index,"open out\n");

  char buff;
  int i = atoi(argv[2]);

  while(i!=0){
    r=read(index,&buff,sizeof(char));
    if(buff=='/'){
      i--;
    }
  }

  char chaine[10]="";

  r=read(index,&buff,sizeof(char));
  while(buff!='/'){
    check_syscall(r,"read in\n");
    char temp[2] = {buff, '\0'};
    strcat(chaine,temp);
    r=read(index,&buff,sizeof(char));
  }

  int pos = atoi(chaine);

  if(atoi(argv[2])==0){
    lseek(in,(pos),SEEK_SET);
  }
  else{
    lseek(in,(pos+1),SEEK_SET);
  }

  r=read(in,&buff,sizeof(char));
  while(buff!='\n' && buff!='\0'){
    check_syscall(r,"read in\n");
    printf("%c",buff);
    r=read(in,&buff,sizeof(char));
  }
  printf("\n");

  close(index);
  close(in);

  return EXIT_SUCCESS;
}
