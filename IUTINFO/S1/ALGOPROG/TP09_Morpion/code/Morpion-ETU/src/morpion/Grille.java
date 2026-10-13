package morpion;

/**
 * Grille (carrée) du jeu de morpion.
 */
class Grille {

    /**
     * Taille d'un côté de la grille.
     */
    int taille;

    /**
     * Contenu de la grille.
     */
    int[][] contenu;

    /**
     * Constructeur.
     *
     * @param laTaille taille de la grille
     */
    Grille(int laTaille) {
        taille = laTaille;
        contenu = new int[taille][taille];
        // mettre 0 dans toutes les cases
        int lig, col;
        for (lig = 0; lig < taille; lig++) {
            for (col = 0; col < taille; col++) {
                contenu[lig][col] = 0;
            }
        }
    }

    /**
     * Récupérer le contenu d'une case, depuis ses coordonnées.
     *
     * @param c coordonnées de la case
     * @return contenu de la case
     */
    int contenuCase(Coordonnees c) {
        return contenu[c.ligne][c.colonne];
    }

    /**
     * Changer le contenu d'une case.
     *
     * @param c coordonnées de la case
     * @param nouvelleValeur nouvelle valeur de la case
     */
    void changerContenuCase(Coordonnees c, int nouvelleValeur) {
        contenu[c.ligne][c.colonne] = nouvelleValeur;
    }

    /**
     * Changer tout le contenu d'une grille.
     *
     * @param nouveauContenu nouveau contenu de la grille
     */
    void changerContenuGrille(int[][] nouveauContenu) {
        contenu = nouveauContenu;
    }
    
    /**
     * Indique si une case est vide.
     *
     * @param coord les coordonnées de la case
     * @return vrai ssi la case est vide
     */
    boolean caseVide(Coordonnees coord) {
        return contenuCase(coord) == 0;
    }

    /**
     * Nombre de cases voisines d'une case, et appartenant à un joueur.
     *
     * @param joueur le joueur considéré
     * @param c les coordonnées de la case dont on considère les voisins
     * @return le nombre de cases voisines appartenant au joueur
     */
    int nbVoisinsAppartenantAuJoueur(int joueur, Coordonnees c) {
        int nbVoisAmis = 0;
        // TODO
        return nbVoisAmis;
    }

    boolean isLigneComplete(int lig) {
        Coordonnees premiereCaseLigne = new Coordonnees(lig, 0);
        boolean ligneComplete = true;
        int col = 1;
        while (ligneComplete && col < taille) {
            Coordonnees caseLigne = new Coordonnees(lig, col);
            if (contenuCase(caseLigne) != contenuCase(premiereCaseLigne)
                    || caseVide(premiereCaseLigne)
                    || caseVide(caseLigne)) {
                ligneComplete = false;
            }
            col++;
        }
        return ligneComplete;
    }

    boolean isColonneComplete(int col) {
        Coordonnees premiereCaseCol = new Coordonnees(0, col);
        boolean colonneComplete = true;
        int lig = 1;
        while (colonneComplete && lig < taille) {
            Coordonnees caseCol = new Coordonnees(lig, col);
            if (contenuCase(caseCol) != contenuCase(premiereCaseCol)
                    || caseVide(caseCol)
                    || caseVide(premiereCaseCol)) {
                colonneComplete = false;
            }
            lig++;
        }
        return colonneComplete;
    }

    boolean isDiagonaleD() {
        Coordonnees hautGauche = new Coordonnees(0, 0);
        boolean diag = true;
        int i = 1;
        while (diag && i < taille) {
            Coordonnees caseDiag = new Coordonnees(i, i);
            if (contenuCase(caseDiag) != contenuCase(hautGauche)
                    || caseVide(caseDiag)) {
                diag = false;
            }
            i++;
        }
        return diag;
    }

    boolean isDiagonaleI() {
        Coordonnees basGauche = new Coordonnees(0, taille - 1);
        boolean diag = true;
        int i = 1;
        while (diag && i < taille) {
            Coordonnees caseDiag = new Coordonnees(i, taille - i - 1);
            if (contenuCase(caseDiag) != contenuCase(basGauche)
                    || caseVide(caseDiag)) {
                diag = false;
            }
            i++;
        }
        return diag;
    }

    boolean diagonaleComplete(Coordonnees coord) {
        int lig = coord.ligne;
        int col = coord.colonne;
        if (col == lig && col != 0 && col != taille - 1) {
            return (isDiagonaleD() && isDiagonaleI());
        } else if (col == lig) {
            return isDiagonaleD(); // test diagonale directe
        } else if (col == taille - 1 - lig) {
            return isDiagonaleI(); // test diagonale indirecte
        } else {
            return false; // lig,col pas sur une diagonale
        }
    }

    /**
     * Afficher une ligne de séparation.
     */
    void afficherLigneSep() {
        System.out.print(" ");
        for (int i = 0; i < taille - 1; i++) {
            System.out.print("---+");
        }
        System.out.println("---");
    }

    /**
     * Afficher une ligne de la grille.
     * 
     * @param lig numéro de la ligne à afficher
     */
    void afficherLigne(int lig) {
        System.out.print(" ");
        for (int col = 0; col < taille - 1; col++) {
            System.out.print(" " + carac(contenu[lig][col]) + " |");
        }
        System.out.println(" " + carac(contenu[lig][taille - 1]));
    }

    /**
     * Afficher toute la grille.
     */
    void afficher() {
        System.out.println(" ");
        for (int lig = 0; lig < taille - 1; lig++) {
            afficherLigne(lig);
            afficherLigneSep();
        }
        afficherLigne(taille - 1);
        System.out.println("");
    }

    /**
     * Caractère utilisé pour afficher le contenu d'une case.
     *
     * @param n le contenu de la grille dans cette case
     * @return le caractère à afficher pour cette case
     */
    static char carac(int n) {
        char c;
        switch (n) {
            case 0:
                c = ' ';
                break;
            case 1:
                c = 'X';
                break;
            case 2:
                c = 'O';
                break;
            case 3:
                c = '*';
                break;
            default:
                c = 'E'; // erreur = carac pas dispo
                break;
        }
        return c;
    }
}
