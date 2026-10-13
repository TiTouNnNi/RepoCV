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
        // TODO
    }

    /**
     * Tri par sélection.
     *
     * @param tab le tableau à trier
     */
    static void triParSelection(int tab[]) {
        // TODO
    }

    /**
     * Tri à bulle.
     *
     * @param tab le tableau à trier
     */
    static void triABulle(int tab[]) {
        // TODO
    }

    /**
     * Tri par comptage.
     *
     * @param tab le tableau à trier
     */
    static void triComptage(int[] tab) {
        // TODO
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
