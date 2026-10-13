#define _XOPEN_SOURCE 1000

#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>     
#include <string.h>
#include <assert.h>
#include <sys/stat.h>

#define BUF_SIZE 4096

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define BUF_SIZE 4096  // Taille du buffer pour la lecture

int regularFile(int inputFile, int outputFile, int nbLine) {

    int lineCount = 0; 
    char c;
    off_t size = lseek(inputFile, 0, SEEK_END);  

    if (size == -1) {
        perror("Erreur lors de l'obtention de la taille du fichier");
        return EXIT_FAILURE;
    }

    off_t pos = size - 1; 
    int byteToRead;
    char buffer[BUF_SIZE];

    while (pos >= 0 && lineCount <= nbLine) {
        lseek(inputFile, pos, SEEK_SET);  
        
        if (read(inputFile, &c, sizeof(char)) <= 0) {
            break;  
        }

        if (c == '\n') { 
            
            lineCount++;
            printf("Coucou\n");  
            printf("LineCount : %d\n", lineCount);  

            if (lineCount == nbLine) {
                pos++;  
                break;  
            } 
            
        }
        pos--; 
    }

    if (lineCount < nbLine) {
        pos = 0; 
    }

    lseek(inputFile, pos, SEEK_SET);  
    while ((byteToRead = read(inputFile, buffer, BUF_SIZE)) > 0) {
        write(outputFile, buffer, byteToRead);  
    }

    return 0; 
}



/*int buf_index = 0;
char **linesToDisplay = malloc(nbLine * sizeof(char*)); 
if (linesToDisplay == NULL) {
    perror("Erreur malloc");
    close(inputFile);
    close(outputFile);
    return EXIT_FAILURE;
}

for (int j = 0; j < nbLine; j++) {
    linesToDisplay[j] = NULL;
}


while (lineCount != nbLine && i < size) {
    lseek(inputFile, size - i - 1, SEEK_SET);
    read(inputFile, &c, sizeof(char));

    buffer[buf_index++] = c;

    if (c == '\n' || i == size - 1) {
        buffer[buf_index] = '\0'; 

        int len = strlen(buffer);
        for (int k = 0; k < len / 2; k++) {
            char temp = buffer[k];
            buffer[k] = buffer[len - k - 1];
            buffer[len - k - 1] = temp;
        }

        linesToDisplay[linePrinted] = strdup(buffer);

        linePrinted++;
        buf_index = 0;
    }

    i++;
}

for (int j = linePrinted - 1; j >= 0; j--) {
    write(outputFile, linesToDisplay[j], strlen(linesToDisplay[j]));
    free(linesToDisplay[j]);
}

free(linesToDisplay);
close(outputFile);
close(inputFile);
return EXIT_SUCCESS;*/

int unregularFile(int inputFile, int outputFile, int nbLine) {
    int lineCount = 0;
    char c;
    char buffer[BUF_SIZE];
    int buf_index = 0;
    char *linesToDisplay[nbLine];

    if (inputFile < 0) {
        perror("Erreur open input");
        return EXIT_FAILURE;
    }

    if (outputFile < 0) {
        perror("Erreur open output");
        close(inputFile);
        return EXIT_FAILURE;
    }

    for (int j = 0; j < nbLine; j++) {
        linesToDisplay[j] = NULL;
    }

    while (read(inputFile, &c, sizeof(char)) > 0) {
        if (c == '\n') {
            buffer[buf_index] = '\0';
            linesToDisplay[lineCount % nbLine] = strdup(buffer);
            if (linesToDisplay[lineCount % nbLine] == NULL) {
                perror("Erreur malloc");
                close(inputFile);
                close(outputFile);
                return EXIT_FAILURE;
            }
            buf_index = 0;
            lineCount++;
        } else {
            buffer[buf_index++] = c;
        }
    }

    if (buf_index > 0) {
        buffer[buf_index] = '\0'; 
        linesToDisplay[lineCount % nbLine] = strdup(buffer); 
        if (linesToDisplay[lineCount % nbLine] == NULL) { 
            perror("Erreur malloc");
            close(inputFile);
            close(outputFile);
            return EXIT_FAILURE;
        }
        lineCount++;
    }


    for (int j = 0; j < nbLine; j++) {
        int index = (lineCount + j) % nbLine;
        if (linesToDisplay[index]) {
            write(outputFile, linesToDisplay[index], strlen(linesToDisplay[index]));
            write(outputFile, "\n", sizeof(char)); 
            free(linesToDisplay[index]);
        }
    }

    close(outputFile);
    close(inputFile);
    return EXIT_SUCCESS;
}

int tailFile(int inputFile, int outputFile, int nbLine) {
    struct stat stat;
    fstat(0, &stat);
    printf("Je rentre dans le main\n");

    if (S_IFREG == (stat.st_mode & S_IFMT)) {
        printf("Je suis un fichier régulier\n");
        regularFile(inputFile, outputFile, nbLine);
    } else {
        printf("Je suis un fichier irrégulier\n");
        regularFile(inputFile, outputFile, nbLine);
    }

    return EXIT_SUCCESS;
}

int main() {
    int inputFD = open("Loremipsum.txt", O_RDONLY);
    int outputFD = open("message.txt", O_CREAT | O_WRONLY | O_TRUNC, 0640);
    regularFile(inputFD, outputFD, 3);
}
