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

    int status;

    if (expr->type == ET_SIMPLE) {
        pid_t pid = fork();
        if (pid == 0) {
            execvp(expr->argv[0], expr->argv);
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
                    dup2(fd, STDIN_FILENO);
                    close(fd);
                    break;

                case REDIR_OUT:
                    fd = open(expr->redirect.fileName, O_CREAT | O_WRONLY | O_TRUNC, 0666);
                    dup2(fd, STDOUT_FILENO);
                    if (expr->redirect.fd == -1) {
                        dup2(fd, STDERR_FILENO);
                    }
                    close(fd);
                    break;

                case REDIR_APP:
                    fd = open(expr->redirect.fileName, O_CREAT | O_WRONLY | O_APPEND, 0666);
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
