package algoProg;

/**
 * Un tableau d'entiers utilisé pour stocker un nombre variable d'entiers, dans
 * ses premières cases.
 */
class TableauEntiers {
    
    /**
     * Nombre maximal d'entiers pouvant être stockés.
     */
    final int TAILLE_MAX = 100;
    
    /**
     * Nombre d'éléments actuellement dans le tableau.
     */
    int taille;
    
    /**
     * Le tableau proprement dit.
     */
    int[] valeurs;

    /**
     * Constructeur.
     */
    TableauEntiers() {
        valeurs = new int[TAILLE_MAX];
        taille = 0;
    }
}
