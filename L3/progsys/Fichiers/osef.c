#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <assert.h>

#include "error.h"

int main()
{
    printf("hello \n");
    fflush(stdout);
    write(1,"world", 5);
    return 1;
}
