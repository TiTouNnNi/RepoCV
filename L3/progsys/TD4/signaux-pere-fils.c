#define XOPEN_SOURCE 600

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

#define NSIGNORT 32

int emetteur(int pere, int argc, char * argv[]) {
  int k = atoi(argv[1]);

  sleep(1); 
  //si on decommente le wait alors on va envoyer un signal envoie que le recepteur aie fait ses sidactions
  //et sans sidaction les signaux termine le programme 

  for(int i = 0 ; i < k ; i++)
    for(int j = 2; j < argc; j++){
      kill(pere,atoi(argv[j]));
      sleep(1);
  }
  kill(pere,9);
  return 0;
}

void afficher(int num){
  static int occ[32];
  occ[num]++;
  printf("%d recu %d fois\n",num,occ[num]);
}

int recepteur(int fils) {
  printf("récepteur : %d\n", getpid());

  // installation du handler pour tous les signaux non RT  
  struct sigaction a;
  a.sa_handler=afficher;
  a.sa_flags = 0;
  sigemptyset(&a.sa_mask);

  for(int sig = 1 ; sig < NSIGNORT ; sig++) {
    if(sigaction(sig,&a,NULL) == -1){
      printf("erreur avec %d\n", sig);
    }
  }
    
  while(1) 
    pause();
  
  return 0;
}


int main(int argc, char *argv[]){
  pid_t pid = fork();  
  if (pid == 0)
    emetteur(getppid(),argc,argv);
  else
    recepteur(pid);  
}
