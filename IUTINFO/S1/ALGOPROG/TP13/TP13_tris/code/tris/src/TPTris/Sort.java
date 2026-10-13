package TPTris;

import java.util.Arrays;

/**
 * Différents tris.
 */
enum Sort {

    TRI_SELECTION,
    TRI_BULLE,
    TRI_COMPTAGE,
    TRI_RAPIDE,
    TRI_PAR_INSERTION,
    TRI_FUSION,
    TRI_JAVA;

    /**
     * Trier un tableau, en choisissant un algorithme.
     *
     * @param tab le tableau à trier
     * @param typeTri l'algorithme de tri à appliquer
     */
    static void tri(int[] tab, Sort typeTri) {
        switch (typeTri) {
            case TRI_SELECTION:
                Sort.triParSelection(tab);
                break;
            case TRI_BULLE:
                Sort.triABulle(tab);
                break;
            case TRI_COMPTAGE:
                Sort.triComptage(tab);
                break;
            case TRI_RAPIDE:
                Sort.triRapide(tab);
                break;
            case TRI_FUSION:
                Sort.triFusion(tab);
                break;
            case TRI_JAVA:
                Sort.triJava(tab);
                break;
            default:
                System.out.println("Type de tri non supporte : ");
        }
    }

    /**
     * Echanger deux éléments dans un tableau.
     *
     * @param tab le tableau
     * @param i l'indice du premier élément à échanger
     * @param j l'indice du deuxoème élément à échanger
     */
    static void echanger(int[] tab, int i, int j) {
        int tmp = tab[i];
        tab[i] = tab[j];
        tab[j] = tmp;
    }

    /**
     * Tri par sélection.
     *
     * @param tab le tableau à trier
     */
    static void triParSelection(int tab[]) {
        for (int i = 0; i < tab.length; i++) {
            int min = i;
            for (int j = i + 1; j < tab.length; j++) {
                if (tab[j] < tab[min]) {
                    min = j;
                }
            }
            if (min != i) {
                echanger(tab, i, min);
            }
        }
    }

    /**
     * Tri à bulle.
     *
     * @param tab le tableau à trier
     */
    static void triABulle(int tab[]) {
        boolean echange = true;
        int i, j;
        i = tab.length - 2;
        while ((echange) && (i >= 0)) {
            echange = false;
            for (j = 0; j <= i; j++) {
                if (tab[j] > tab[j + 1]) {
                    echanger(tab, j, j + 1);
                    echange = true;
                }
            }
            i--;
        }
    }

    /**
     * Tri par comptage.
     *
     * @param tab le tableau à trier
     */
    static void triComptage(int[] tab) {
        int[] compteurs = new int[tab.length];
        for (int i = 0; i < tab.length; i++) {
            compteurs[i] = 0;
        }
        for (int i = 1; i < tab.length; i++) {
            for (int j = 0; j < i; j++) {
                if (tab[j] < tab[i]) {
                    compteurs[i]++;
                } else {
                    compteurs[j]++;
                }
            }
        }
        int[] copie = new int[tab.length];
        for (int i = 0; i < tab.length; i++) {
            copie[i] = tab[i];
        }
        for (int i = 0; i < tab.length; i++) {
            int indice = compteurs[i];
            tab[indice] = copie[i];
        }
    }

    /**
     * Tri Rapide.
     *
     * @param tab le tableau à trier
     */
    
    static int separer(int[] tab,int debut, int fin){
        int separation, i, milieu;
        milieu =(debut+fin)/2;
        echanger(tab,milieu,fin);
        separation=debut;
        for(i=debut; i< fin; i++){
            if(tab[i]<tab[fin]){
                echanger(tab,i,separation);
                separation++;
            }
            
        }
        echanger(tab,fin,separation);
        return separation;
    }
    
    static void triRapideIntervalle(int[] tab, int debut, int fin) {
        int pivot;
        if (fin>debut){
            pivot = separer(tab,debut,fin);
            triRapideIntervalle(tab,debut,pivot-1);
            triRapideIntervalle(tab,pivot+1,fin);
        }
    }

    static void triRapide(int tab[]) {
        triRapideIntervalle(tab, 0, tab.length - 1);
    }

    /**
     * Tri par défaut de Java.
     *
     * @param tab tableau à trier
     */
    static void triJava(int[] tab) {
        Arrays.sort(tab);
    }
}
