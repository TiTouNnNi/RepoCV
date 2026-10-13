#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>
 
#include "error.h"

#include <stdio.h>
#include <unistd.h>

/*
1) Ce code remplace, dans un fichier qui contient des entiers binéaires,
le i=arg entier par i puis l'entier i+2 par i+2 tant que i<10

2) Cela remplace les 9 premier entier binaire du fichier par les entier binéaire de 0 à 9

3)
*/

int main(int argc, char *argv[])
{
    int i, fd;
    if(argc != 2) {
        fprintf(stderr, "Usage: ecrire <position_depart>\n");
        exit(1);
    }
    fd = open("fich", O_WRONLY | O_CREAT, 0666);
    for(i = atoi(argv[1]); i < 10; i += 2) {
        lseek(fd, i*sizeof(int), SEEK_SET);
        write(fd, &i, sizeof(int));
        sleep(1);
    }
    close(fd);
    return 0;
}