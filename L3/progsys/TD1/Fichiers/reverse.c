#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h> 
#include "error.h"
#include <string.h>

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

int main(int argc, char* argv[]){
    assert(argc=2);

    int in, out, w, r;

    in = open(argv[1], O_RDONLY);
    check_syscall(in,"open in file\n");

    out = open(strcat(argv[1],".rev"),O_WRONLY | O_CREAT | O_TRUNC, 0640);
    check_syscall(out,"open out file\n");

    off_t lenin = lseek (in, 0, SEEK_END);
    char *inmap = mmap (NULL, lenin, PROT_READ, MAP_SHARED, in, 0);

    char* dest = malloc(lenin*sizeof(char));

    /*lseek(out,lenin*sizeof(char),SEEK_SET);
    char tmp = 'l';
    write(out,&tmp,sizeof(char));

    char *outmap = mmap (NULL, lenin*sizeof(char), PROT_WRITE, MAP_SHARED, out, 0);
    printf("%p",outmap);*/

    for(int i=strlen(inmap), j=0;i!=1;i--, j++){
        printf("%c %d\n",inmap[i],j);
        //outmap[j]=inmap[i];
        dest[j]=inmap[i];
    }
    write(out,dest,lenin*sizeof(char));


}