package algoProg;

/**
 * Stockage d'un nombre variable d'entiers dans un tableau, et fonctions
 * associées (ajout, suppression, recherche).
 */
class Tableaux {

    /**
     * Lire un entier saisi par l'utilisateur. Vous n'avez pas à comprendre ce
     * code.
     *
     * @return l'entier saisi
     */
    static int lireEntreeCommeEntier() {
        java.util.Scanner sc = new java.util.Scanner(System.in);
        int entierSaisi = 0;
        boolean saisieCorrecte = false;
        do {
            try {
                entierSaisi = sc.nextInt();
                saisieCorrecte = true;
            } catch (java.util.InputMismatchException e) {
                System.err.println("Saisie incorrecte, saisissez un entier.");
                sc.next();
            }
        } while (!saisieCorrecte);
        return entierSaisi;
    }

    /**
     * Lit autant d'entrées clavier que nécessaire pour récupérer une valeur
     * valide. Une valeur valide est un entier dans [1, n] (bornes incluses)
     *
     * @param n borne maximale
     * @return le premier entier valide entré par l'utilisateur
     */
    static int nombreValide(int n) {
        int i;
        do {
            i = lireEntreeCommeEntier();
        } while (i < 1 || i > n);

        return i;
    }

    /**
     * Permet de saisir un tableau quelconque. Sont saisis, la taille d'abord,
     * puis les éléments à insérer.
     *
     * @param tab le tableau
     */
    static void saisirTableau(TableauEntiers tab) {
        System.out.println("Entrez la taille (entre 1 et " + tab.TAILLE_MAX + ") :");
        int nbSaisies = nombreValide(tab.TAILLE_MAX);

        System.out.println("Entrez les éléments :");
        for (int i = 0; i < nbSaisies; i++) {
            tab.valeurs[i] = lireEntreeCommeEntier();
            tab.taille++;
        }
    }

    /**
     * Permet de saisir un tableau en le triant. Sont saisis, la taille d'abord,
     * puis les éléments à insérer.
     *
     * @param tab le tableau
     */
    static void saisirTableauTrie(TableauEntiers tab) {
        System.out.println("Entrez la taille (entre 1 et " + tab.TAILLE_MAX + ") :");
        int nbSaisies = nombreValide(tab.TAILLE_MAX);

        System.out.println("Entrez les éléments :");
        for (int i = 0; i < nbSaisies; i++) {
            int val = lireEntreeCommeEntier();
            ajouterTrie(tab, val);
        }
    }

    /**
     * Permet d'afficher les éléments d'un tableau. Les éléments sont affichés
     * dans l'ordre.
     *
     * @param tab le tableau
     */
    static void afficherTableau(TableauEntiers tab) {
        for (int i = 0; i < tab.taille; i++) {
            System.out.print(tab.valeurs[i] + " ");
        }
        System.out.println();
    }

    /**
     * Recherche séquentielle. Retourne la position d'un élément dans un
     * tableau, -1 si l'élément est absent
     *
     * @param elem l'élément
     * @param tab le tableau
     * @return la position de l'élément dans le tableau, ou -1 s'il est absent
     */
    static int cherchePosSeq(TableauEntiers tab, int elem) {
        int pos = 0;
        boolean trouve = false;

        while (!trouve && pos < tab.taille) {
            if (elem == tab.valeurs[pos]) {
                trouve = true;
            } 
            pos++;
        }

        if (!trouve) {
            pos = -1;
        }

        return pos;
    }

    /**
     * Recherche dichotomique. Retourne la position d'un élément dans un tableau
     * TRIÉ, -1 si l'élément est absent
     *
     * @param elem l'élement
     * @param tab le tableau
     * @return la position de l'élément, ou -1 s'il est absent
     */
    static int cherchePosDicho(TableauEntiers tab, int elem) {
        int gauche, droite, milieu = 0;
        boolean trouve;

        gauche = 0;
        droite = tab.taille - 1;
        trouve = false;

        while (!trouve && gauche <= droite) {
            milieu = (droite + gauche) / 2;
            if (elem < tab.valeurs[milieu]) {
                droite = milieu - 1;
            } else if (elem > tab.valeurs[milieu]) {
                gauche = milieu + 1;
            } else {
                trouve = true;
            }
        }

        if (!trouve) {
            milieu = -1;
        }

        return milieu;
    }

    /**
     * Ajout d'un élément dans un tableau non trié. Suppose que le tableau n'est
     * pas plein.
     *
     * @param elem l'élement
     * @param tab le tableau
     */
    static void ajouterNonTrie(TableauEntiers tab, int elem) {
        tab.valeurs[tab.taille] = elem;
        tab.taille++;
    }

    /**
     * Fonction locale utilisée par ajouterTrie. Retourne la position à laquelle
     * l'élement peut être ajouté dans le tableau (basée sur une recherche
     * séquentielle)
     *
     * @param elem l'élement
     * @param tab le tableau
     * @return position d'insertion
     */
    static int cherchePosAjout(TableauEntiers tab, int elem) {
        int pos = 0;
        boolean trouve = false;

        while (!trouve && pos < tab.taille) {
            if (elem <= tab.valeurs[pos]) {
                trouve = true;
            } else {
                pos++;
            }
        }
        return pos;
    }

    /**
     * Fonction locale utilisée par ajouterTrie. Décale vers la droite tous les
     * éléments de tab à partir de la position indice
     *
     * @param indice la position d'insertion
     * @param tab le tableau
     */
    static void decalageDroite(TableauEntiers tab, int indice) {
        for (int i = tab.taille; i >= indice; i--) {
            tab.valeurs[i] = tab.valeurs[i - 1];
        }
    }

    /**
     * Ajout d'un élément dans un tableau trié. Suppose que le tableau n'est pas
     * plein
     *
     * @param tab le tableau
     * @param elem l'élément à ajouter
     */
    static void ajouterTrie(TableauEntiers tab, int elem) {
        int pos = cherchePosAjout(tab, elem);
        decalageDroite(tab, pos);
        tab.valeurs[pos] = elem;
    }

    /**
     * Affichage du menu.
     */
    static void afficherMenu() {
        System.out.println(" 0. Sortir");
        System.out.println(" 1. Saisie d'un tableau quelconque");
        System.out.println(" 2. Saisie d'un tableau en le triant");
        System.out.println("11. Recherche séquentielle d'un élément");
        System.out.println("12. Suppression d'un élément");
        System.out.println("13. Ajout d'un élément");
        System.out.println("21. Recherche séquentielle d'un élément dans un tableau trié");
        System.out.println("22. Recherche dichotomique d'un élément");
        System.out.println("23. Suppression d'un élément dans un tableau trié");
        System.out.println("24. Ajout d'un élément dans un tableau trié");
        System.out.print("Votre choix : ");
    }

    /**
     * Traiter une demande de recherche séquentielle.
     * @param tab le tableau
     */
    static void traiterRechercheSeq(TableauEntiers tab) {
        int element, pos;

        System.out.println("\nÉlement à rechercher dans le tableau : ");
        element = lireEntreeCommeEntier();
        pos = cherchePosSeq(tab, element);
        if (pos != -1) {
            System.out.println("L'élement " + element + " est à la position " + pos);
        } else {
            System.out.println("L'élement " + element + " n'est pas présent");
        }
    }

    /**
     * Traiter une demande d'ajout dans un tableau non trié.
     * @param tab le tableau
     */
    static void traiterAjoutNonTrie(TableauEntiers tab) {
        int element;

        if (tab.taille == tab.TAILLE_MAX) {
            System.out.println("Impossible : tableau plein");
        } else {
            System.out.println("Élement à ajouter dans le tableau : ");
            element = lireEntreeCommeEntier();
            ajouterNonTrie(tab, element);
        }
    }

    /**
     * Traiter une demande de recherche d'un élément dans le tableau trié, en 
     * appliquant une recherche dichotomique.
     * @param tab le tableau trié
     */
    static void traiterRechercheDicho(TableauEntiers tab) {
        int element, pos;

        System.out.println("Élement à rechercher dans le tableau : ");
        element = lireEntreeCommeEntier();
        pos = cherchePosDicho(tab, element);
        if (pos != -1) {
            System.out.println("L'element " + element + " est à la position " + pos);
        } else {
            System.out.println("L'element " + element + " n'est pas present");
        }
    }

    /**
     * Traiter une demande d'ajout dans un tableau trié.
     * @param tab le tableau trié
     */
    static void traiterAjoutTrie(TableauEntiers tab) {
        int element;

        if (tab.taille == tab.TAILLE_MAX) {
            System.out.println("Impossible : tableau plein");
        } else {
            System.out.println("Élement à ajouter dans le tableau trié : ");
            element = lireEntreeCommeEntier();
            ajouterTrie(tab, element);
        }
    }

    /**
     * Lancement de tous les tests unitaires.
     */
    static void lancerTests() {
        System.out.println("Début des tests...");
        System.out.println("Tests terminés avec succès");
    }

    /**
     * Gestion du menu.
     */
    static void lancerMenu() {
        TableauEntiers tabl = new TableauEntiers();
        int menuChoice;
        do {
            System.out.println("Contenu du tableau :");
            afficherTableau(tabl);
            afficherMenu();
            menuChoice = lireEntreeCommeEntier();
            switch (menuChoice) {
                case 0: // sortir
                    break;
                case 1: // saisie tableau quelconque
                    saisirTableau(tabl);
                    break;
                case 2: // saisie tableau en le triant
                    saisirTableauTrie(tabl);
                    break;
                case 11: // recherche seq
                    traiterRechercheSeq(tabl);
                    break;
                case 12: // suppression
                    System.out.println("À FAIRE");
                    break;
                case 13: // ajout
                    traiterAjoutNonTrie(tabl);
                    break;
                case 21: // recherche seq trié
                    System.out.println("À FAIRE");
                    break;
                case 22: // recherche dicho
                    traiterRechercheDicho(tabl);
                    break;
                case 23: // suppression trié
                    System.out.println("À FAIRE");
                    break;
                case 24: // ajout trié
                    traiterAjoutTrie(tabl);
                    break;
                default:
                    System.out.println("Erreur de saisie");
                    break;
            }

        } while (menuChoice != 0);

        System.out.println("Fin de programme");

    }

    /**
     * Action principale.
     * @param args arguments de la ligne de commande
     */
    public static void main(String[] args) {
        lancerMenu();
    }

}
