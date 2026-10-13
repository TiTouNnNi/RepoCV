#include "heap.h"
#include <stdlib.h>

heap heap_create(int k, int (*f)(const void *, const void *)) {
  heap h = malloc(sizeof(*h));

  h->array = malloc((k+1) * sizeof(void*));

  h->n = 0;
  h->nmax = k;
  h->f = f;

  return h;
}

void heap_destroy(heap h) {
  free(h->array);
  free(h);
}

bool heap_empty(heap h) {
  return h->n == 0;
}

bool heap_add(heap h, void *object) {
  if(h->n >= h->nmax){
    return true;
  }

  h->n++;
  int i = h->n;
  // Réorganise le tas en remontant l'élément ajouté
  while (i > 1 && h->f(h->array[i / 2], object) > 0) {
      h->array[i] = h->array[i / 2]; // Descend le père
      i = i / 2; // Remonte à la position du père
  }

  h->array[i] = object;
  return false;
}

void *heap_top(heap h) {
  if(heap_empty(h)){
    return NULL;
  }
  return h->array[1];
}

void *heap_pop(heap h) {
  if(heap_empty(h)){
    return NULL;
  }

  void* min = heap_top(h);
  void* last = h->array[h->n];
  h->n--;
  int i = 1; // On commence à la racine

  return min;
}
