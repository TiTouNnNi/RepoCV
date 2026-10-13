package morpion;

import java.util.Arrays;

/**
 * Coordonnées d'une case du plateau.
 */
class Coordonnees {

    /**
     * Numéro de la ligne.
     */
    int ligne;

    /**
     * Numéro de la colonne.
     */
    int colonne;

    /**
     * Constructeur prenant les numéros de ligne/colonne en paramètre.
     *
     * @param numLigne numéro de la ligne
     * @param numColonne numéro de la colonne
     */
    Coordonnees(int numLigne, int numColonne) {
        ligne = numLigne;
        colonne = numColonne;
    }

    /**
     * Renvoie les coordonnées de la case suivante, en suivant une direction
     * donnée.
     *
     * @param d la direction à suivre
     * @return les coordonnées de la case suivante
     */
    Coordonnees suivante(Direction d) {
        return new Coordonnees(ligne + d.mvtVertic(), colonne + d.mvtHoriz());
    }

    /**
     * Indique si ces coordonnées sont dans le plateau.
     *
     * @param taille taille du plateau (carré)
     * @return vrai ssi ces coordonnées sont dans le plateau
     */
    boolean estDansPlateau(int taille) {
        return true; // TODO
    }

    /**
     * Retourne les coordonnées de toutes les cases voisines.
     * 
     * @param taille taille du plateau (carré)
     * @return les coordonnées de toutes les cases voisines
     */
    Coordonnees[] voisines(int taille) {
        Coordonnees[] voisines = new Coordonnees[8];
        int nbVoisines = 0;
        // TODO
        return Arrays.copyOf(voisines, nbVoisines);
    }
    
    @Override
    public String toString() {
        return "(" + ligne + "," + colonne + ")";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Coordonnees other = (Coordonnees) obj;
        if (this.ligne != other.ligne) {
            return false;
        }
        if (this.colonne != other.colonne) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + this.ligne;
        hash = 53 * hash + this.colonne;
        return hash;
    }
    
    
}
