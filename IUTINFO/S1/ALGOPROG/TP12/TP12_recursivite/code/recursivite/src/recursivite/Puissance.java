package recursivite;

/**
 * Calcul de la puissance d'un entier.
 */
class Puissance {

    /**
     * Calcul de la puissance d'un entier, avec une complexité logarithmique.
     *
     * @param a l'entier à élever à la puissance
     * @param n la puissance
     * @return l'entier élevé à la puissance
     */
    static int puissance(int a, int n) {
        if(n==0){
            return 1;
        }
        switch (a % 2) {
            case 0:
                return a ^ n / 2 * a ^ n / 2;
            case 1:
                return a ^ (n - 1) / 2 * a ^ (n - 1) / 2;
        }

        return 0;
    }
}
