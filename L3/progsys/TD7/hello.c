#include <stdio.h>
#include <omp.h>

int main()
{
  int a=0;
#pragma omp parallel
  {
    #pragma omp critical 
    a+=100;
    printf("Bonjour de %d !\n",omp_get_thread_num());
    #pragma omp master
    printf("Au revoir %d !\n",omp_get_thread_num());
  }
  printf("a=%d\n",a);
  return 0;
}
