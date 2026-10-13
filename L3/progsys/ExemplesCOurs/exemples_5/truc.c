#include "Evaluation.h"
#include "Shell.h"

#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>

int shellStatus;

int getStatus(int status){
    if(WIFEXITED(status)){
        return WEXITSTATUS(status);
    }
    return WTERMSIG(status) +128;
}

int executeAndRedirect(Expression *expr) {
    if (expr->type == ET_EMPTY) {
        return shellStatus; 
    }

    int status, statusLeft, statusRight;

    if (expr->type == ET_SIMPLE) {
        pid_t pid = fork();
        if (pid == 0) {
            execvp(expr->argv[0], expr->argv);
            perror("execvp failed"); // Ajout de message d'erreur
            exit(EXIT_FAILURE);
        }
        waitpid(pid, &status, 0);
        shellStatus = getStatus(status);
        return shellStatus;
    }

    if (expr->type == ET_REDIRECT) {
        pid_t pid = fork();
        if (pid == 0) {
            int fd;
            switch (expr->redirect.type) {
                case REDIR_IN:
                    fd = open(expr->redirect.fileName, O_RDONLY);
                    if (fd == -1) {
                        perror("open failed"); // Message d'erreur si open échoue
                        exit(EXIT_FAILURE);
                    }
                    dup2(fd, STDIN_FILENO);
                    close(fd);
                    break;

                case REDIR_OUT:
                    fd = open(expr->redirect.fileName, O_CREAT | O_WRONLY | O_TRUNC, 0666);
                    if (fd == -1) {
                        perror("open failed");
                        exit(EXIT_FAILURE);
                    }
                    dup2(fd, STDOUT_FILENO);
                    if (expr->redirect.fd == -1) {
                        dup2(fd, STDERR_FILENO);
                    }
                    close(fd);
                    break;

                case REDIR_APP:
                    fd = open(expr->redirect.fileName, O_CREAT | O_WRONLY | O_APPEND, 0666);
                    if (fd == -1) {
                        perror("open failed");
                        exit(EXIT_FAILURE);
                    }
                    dup2(fd, STDOUT_FILENO);
                    if (expr->redirect.fd == -1) {
                        dup2(fd, STDERR_FILENO);
                    }
                    close(fd);
                    break;
            }
            executeAndRedirect(expr->left);
            exit(EXIT_FAILURE);
        }
        waitpid(pid, NULL, 0);
        return shellStatus;
    }

    pid_t pidRight;

    if(expr->type == ET_SEQUENCE){
        pid_t pidLeft = fork();
        if (pidLeft == 0) {
            execvp(expr->left.argv[0], expr->left.argv);
            perror("execvp failed"); // Message d'erreur
            exit(EXIT_FAILURE);
        }

        pidRight = fork();
        if(pidRight == 0 ){
            execvp(expr->right.argv[0], expr->right.argv);
            perror("execvp failed");
            exit(EXIT_FAILURE);
        }

        waitpid(pidLeft, &statusLeft, 0);
        waitpid(pidRight, &statusRight, 0);
        shellStatus = getStatus(statusRight);
        return shellStatus;
    }

    if(expr->type == ET_SEQUENCE_AND){

        pid_t pidLeft = fork();
        if (pidLeft == 0) {
            execvp(expr->left.argv[0], expr->left.argv);
            exit(EXIT_FAILURE);
        }

        waitpid(pidLeft, &statusLeft, 0);

        if (getStatus(statusLeft) == 0) {
            pidRight = fork();
            if (pidRight == 0) {
                execvp(expr->right.argv[0], expr->right.argv);
                exit(EXIT_FAILURE);
            }
            waitpid(pidRight, &statusRight, 0);
            shellStatus = getStatus(statusRight);
            return shellStatus;
        }
        return getStatus(statusLeft);
    }

    if(expr->type == ET_SEQUENCE_OR){

        pid_t pidLeft = fork();
        if(pidLeft == 0){
            execvp(expr->left.argv[0], expr->left.argv);
            exit(EXIT_FAILURE);
        }
        
        waitpid(pidLeft, &statusLeft, 0);
        if (getStatus(statusLeft) != 0) { // Si la commande de gauche échoue
            pidRight = fork();
            if(pidRight == 0 ){
                execvp(expr->right.argv[0], expr->right.argv);
                exit(EXIT_FAILURE);
            }
            waitpid(pidRight, &statusRight, 0);
            shellStatus = getStatus(statusRight);
            return shellStatus;
        }
        return getStatus(statusLeft);
    }

    if(expr->type == ET_PIPELINE){
        int pipefd[2];
        pipe(pipefd);

        pid_t leftPid = fork();
        if (leftPid == 0) {
            close(pipefd[0]);
            dup2(pipefd[1], STDOUT_FILENO);
            close(pipefd[1]);
            execvp(expr->left.argv[0], expr->left.argv);
            exit(EXIT_FAILURE);
        }

        pid_t rightPid = fork();
        if (rightPid == 0) {
            close(pipefd[1]); 
            dup2(pipefd[0], STDIN_FILENO);
            close(pipefd[0]);
            execvp(expr->right.argv[0], expr->right.argv);
            exit(EXIT_FAILURE);
        }

        close(pipefd[0]);
        close(pipefd[1]);

        waitpid(leftPid, &statusLeft, 0);
        waitpid(rightPid, &statusRight, 0);

        shellStatus = getStatus(statusRight);
        return shellStatus;
    }

    return 1; 
}

int evaluateExpr(Expression *expr) {
    static int first = 1;
    if (first) {
        first = 0;
    }
    shellStatus = executeAndRedirect(expr);
    return shellStatus;
}
