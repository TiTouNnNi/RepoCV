#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/wait.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

int tailFile(int inputFD, int outputFD, int numLines){

    //on test si on veut afficher aucune ligne => fin du programme
    if(numLines==0){
        return EXIT_SUCCESS;
    }
    if(numLines<0){
        return EXIT_FAILURE;
    }

    //on test si le fichier est régulié
    struct stat stat;
    fstat(inputFD, &stat);
    if (S_ISREG(stat.st_mode)){

        //compteur du nombre de caractere qu'on lira/ecrira
        int compteur=0;
        //tableau de la taille du fichier (pour le cas où on veut afficher tout les caracteres)
        //qui contiendra les caracteres dans l'ordre inverse
        char buffTab[stat.st_size];

        //on se met à la fin du fichier et on lit le 1er caractere
        lseek(inputFD,-1,SEEK_END);
        read(inputFD,(buffTab+compteur),sizeof(char));
        compteur++;

        //boucle qui parcours le fichier source dans l'ordre inverse et qui ajoute ses caractere dans le tableau
        //on arrete de lire les caracteres si on a atteint le bon nombre de ligne ou si on est arrivé à la fin du tableau
        while((numLines>0) && (lseek(inputFD,-2,SEEK_CUR)!=-1)){
            read(inputFD,(buffTab+compteur),sizeof(char));
            //printf("line = %d / char = %c / compteur = %d\n",numLines,buffTab[compteur],compteur);
            if(buffTab[compteur]=='\n'){
                numLines--;
            }
            compteur++;
        }

        //on met a jour le compteur selon si le dernier caractere lu était un retour à la ligne, car on ne veut pas l'afficher
        compteur--;
        if(buffTab[compteur]=='\n'){
            compteur--;
        }

        //on inverse le tableau pour qu'il contienne les caractere à écrire dans le bonne ordre
        for(int i=0, j=compteur;i<=j;i++, j--){
            int temp=buffTab[i];
            buffTab[i]=buffTab[j];
            buffTab[j]=temp;
        }

        //on écrit le tableau avec le bon nombre de caractere dans le fichier cible 
        write(outputFD,buffTab,(compteur+1)*sizeof(char));
    }
    else {

        //compteur du nombre de caractere qu'on lira/ecrira
        int compteur=0;
        //tableau de la taille du fichier (pour le cas où on veut afficher tout les caracteres)
        //qui contiendra les caracteres dans l'ordre inverse
        char buffTab[stat.st_size];

        //on va jusqu'au dernier caractere puis on recule de 1
        while(read(inputFD,buffTab,sizeof(char)>0));
        lseek(inputFD,-1,SEEK_CUR);

        //on lit le 1er caractere
        read(inputFD,(buffTab+compteur),sizeof(char));
        compteur++;

        //boucle qui parcours le fichier source dans l'ordre inverse et qui ajoute ses caractere dans le tableau
        //on arrete de lire les caracteres si on a atteint le bon nombre de ligne ou si on est arrivé à la fin du tableau
        while((numLines>0) && (lseek(inputFD,-2,SEEK_CUR)!=-1)){
            read(inputFD,(buffTab+compteur),sizeof(char));
            //printf("line = %d / char = %c / compteur = %d\n",numLines,buffTab[compteur],compteur);
            if(buffTab[compteur]=='\n'){
                numLines--;
            }
            compteur++;
        }

        //on met a jour le compteur selon si le dernier caractere lu était un retour à la ligne, car on ne veut pas l'afficher
        compteur--;
        if(buffTab[compteur]=='\n'){
            compteur--;
        }

        //on inverse le tableau pour qu'il contienne les caractere à écrire dans le bonne ordre
        for(int i=0, j=compteur;i<=j;i++, j--){
            int temp=buffTab[i];
            buffTab[i]=buffTab[j];
            buffTab[j]=temp;
        }

        //on écrit le tableau avec le bon nombre de caractere dans le fichier cible 
        write(outputFD,buffTab,(compteur+1)*sizeof(char));    
    }

    return EXIT_SUCCESS;
}



int main(int argc, char* argv[]){
    assert(argc==4);
    int fdin=open(argv[1],O_RDONLY);
    int fdout=open(argv[2],O_WRONLY | O_TRUNC);
    assert(fdin!=-1);
    assert(fdout!=-1);
    if(tailFile(fdin,fdout,atoi(argv[3]))){
        printf("Program error\n");
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}