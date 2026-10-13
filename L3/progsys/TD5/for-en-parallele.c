#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

//entre 2 et 200 pour 2 threads sans mutex

pthread_mutex_t mutex;

unsigned long volatile k = 0;
const unsigned long MAX = 100 * 100000;

void *for_en_parallele(void *p)
{
  pthread_mutex_lock(&mutex);
  for(unsigned long i=0; i < MAX; i++)
    k++;
  pthread_mutex_unlock(&mutex);
  return NULL;
}

int 
main(int argc, char *argv[])
{
  pthread_mutex_init(&mutex,NULL);
  int n = atoi(argv[1]);
  pthread_t tids[n];
  
  for(int i = 0; i <n ; i++)
    pthread_create(tids + i, NULL, for_en_parallele, NULL);

  for(int i = 0; i <n ; i++)
    pthread_join(tids[i],NULL);

  printf("%lu\n",k);

  pthread_mutex_destroy(&mutex);

  return EXIT_SUCCESS;
}
