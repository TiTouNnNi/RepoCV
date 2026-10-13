#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>

#define _XOPEN_SOURCE 600

//creation de la barriere
pthread_barrier_t barrier;

//fonction des threads, qui attends que tout les autres thread soit arrivé
//a la porte pour faire le 2eme printf
void *HelloGoodbye(void *p)
{
  printf("%d: bonjour\n", *((int *)p)); 
  sleep(1);
  pthread_barrier_wait(&barrier);
  printf("%d: a bientot\n", *((int *)p)); 
  return NULL;
}

int main(int argc, char *argv[])
{
  //recuperer le parametre
  assert(argc==2);
  char* end;
  int NB_THREAD = strtol(argv[1],&end,10);
  assert(*end=='\0');

  //creer le tableau des numeros/id des threads
  pthread_t thread[NB_THREAD];
  int threadId[NB_THREAD];

  //initition de la barriere, qui attendra que NB_THREAD 
  //soit arrivé à la barriere pour la libérer
  pthread_barrier_init(&barrier, NULL, NB_THREAD);

  //creation des thread avec pour parametre leur numero
  for(int i=0;i<NB_THREAD;i++){
    threadId[i]=i+1;
    assert(pthread_create(&(thread[i]),NULL,HelloGoodbye,&threadId[i])==0);
  }

  //attente de la fin de tout les threads
  for(int i=0;i<NB_THREAD;i++){
    assert(pthread_join(thread[i],NULL)==0);
  }

  //destruction de la barriere
  pthread_barrier_destroy(&barrier);

  return EXIT_SUCCESS;
}
