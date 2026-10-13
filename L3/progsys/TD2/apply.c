#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include <dirent.h>
#include <fnmatch.h>
#include <string.h>
#include "error.h"

int main(int argc, char** argv){

    assert(argc>=3);

    char* motif=argv[argc-1];
    argv[argc-1]=NULL;

    DIR* dossier = opendir(".");
    check(dossier!=NULL,"lecture de .\n");

    struct dirent* fichier;
    while((fichier = readdir(dossier))!=NULL){
        if(fnmatch(motif,fichier->d_name,0)==0){
            int child = fork();
            if(child==0){
                execvp(argv[1], argv+1);
                perror(argv[1]);
                exit(1);
            }
            waitpid(child,NULL,0);
        }
    }

    exit(EXIT_SUCCESS);
}