package distributeurfriandise;

import java.util.Scanner;

/**
 * Classe gérant le menu principal.
 */
class DistributeurFriandise {

    /**
     * Afficher le menu et retourner le choix fait pas l'utilisateur.
     *
     * @return le choix fait par l'utilisateur
     */
    static int menu() {
        int choix;
        System.out.println("Que souhaitez-vous faire ?");
        System.out.println("\t 1. Ajouter un bonbon dans le distributeur");
        System.out.println("\t 2. Retirer un bonbon du distributeur");
        System.out.println("\t 3. Retirer x bonbon(s) du distributeur");
        System.out.println("\t 4. Connaitre le nombre de bonbons du distributeur");
        System.out.println("\t 5. Afficher le distributeur");
        System.out.println("\t 6. Dessiner le distributeur");
        System.out.println("\t 7. Quitter");
        Scanner sc = new Scanner(System.in);
        choix = sc.nextInt();
        return choix;
    }

    /**
     * Permettre de choisir un bonbon parmi les bonbons définis.
     *
     * @return le type de bonbon
     */
    static int choixBonbon() {
        System.out.println("Quel bonbon ?");
        System.out.println("\t 1. Chypresers");
        System.out.println("\t 2. Tigre");
        System.out.println("\t 3. Venus");
        System.out.println("\t 4. Noisettes");
        System.out.println("\t 5. Chewing gum");

        Scanner sc = new Scanner(System.in);
        int choix = sc.nextInt();
        return choix;
    }

    /**
     * Affiche la liste des parfums pour un bonbon.
     */
    static void afficheParfum() {
        System.out.println("Quel parfum ?");
        int i = 1;
        for (Parfum p : Parfum.values()) {
            System.out.print(i + ".");
            System.out.println(p);
            i++;
        }
    }

    /**
     * Choix du parfum pour un bonbon.
     *
     * @return un parfum parmi l'énumération de parfums
     */
    static Parfum choixParfum() {
        afficheParfum();
        Scanner sc = new Scanner(System.in);
        int choix = sc.nextInt();
        boolean parfumValide = false;
        Parfum p = null;
        while (!parfumValide) {
            parfumValide = true;
            switch (choix) {
                case 1:
                    p = Parfum.NOISETTE;
                    break;
                case 2:
                    p = Parfum.CARAMEL;
                    break;
                case 3:
                    p = Parfum.FRAISE;
                    break;
                case 4:
                    p = Parfum.POMME;
                    break;
                case 5:
                    p = Parfum.CHOCOLAT;
                    break;
                case 6:
                    p = Parfum.RIZ;
                    break;
                default:
                    System.out.println("Parfum incconu");
                    parfumValide = false;
                    afficheParfum();
                    choix = sc.nextInt();
            }
        }
        return p;

    }

    /**
     * Ajouter un bonbon à un distributeur.
     *
     * @param d distributeur dans lequel on ajoute un bonbon
     */
    static void ajouterBonbon(Distributeur d) {
        
        int choix = choixBonbon();
        Bonbon b = null;
        boolean choixValide = false;
        while (!choixValide) {
            choixValide = true;
            switch (choix) {
                case 1:
                    b = Bonbon.chypresers();
                    break;
                case 2:
                    b = Bonbon.tigre();
                    break;
                case 3:
                    b = Bonbon.venus();
                    break;
                case 4:
                    b = Bonbon.noisettes();
                    break;
                case 5:
                    Parfum p = choixParfum();
                    b = Bonbon.chewingGum(p);
                    break;
                default:
                    System.out.println("Erreur : ce bonbon n'est pas disponible");
                    choixValide = false;
                    choix = choixBonbon();
            }
        }
        d.ajouterBonbon(b);
         
    }

    /**
     * Retirer un bonbon d'un distributeur.
     *
     * @param d distributeur dont on retire un bonbon
     */
    static void retirerBonbon(Distributeur d) {
        /*
        Bonbon b = d.retirerBonbon();
        System.out.println("Bonbon retiré:");
        if (b != null) {
            b.afficher();
        } else {
            System.out.println("Aucun");
        }
         */
    }

    /**
     * Retirer plusieurs bonbons d'un distributeur.
     *
     * @param d distributeur dont on retire des bonbons
     */
    static void retirerBonbons(Distributeur d) {
        /* 
        System.out.println("Combien de bonbons retirer ?");
        Scanner sc = new Scanner(System.in);
        int choix = sc.nextInt();

        Bonbon[] bonbonsRetires = d.retirerBonbons(choix);
        for (int i = 0; i < choix; ++i) {
            bonbonsRetires[i].afficher();
        }
         */
    }

    /**
     * Afficher le nombre de bonbons d'un distributeur.
     *
     * @param d distributeur dont on affiche le nombre de bonbons
     */
    static void afficherNombreBonbons(Distributeur d) {
        int nbBonbons = d.nombreBonbons();
        System.out.println("Le nombre de bonbons du distributeur est :" + nbBonbons);
    }

    /**
     * Afficher un distributeur.
     *
     * @param d distributeur à afficher
     */
    static void afficherDistributeur(Distributeur d) {
        d.afficher();
    }

    /**
     * Dessiner un distributeur.
     *
     * @param d distributeur à dessiner
     */
    static void dessinerDistributeur(Distributeur d) {
        d.dessiner();
    }

    /**
     * Fonction principale.
     *
     * @param args arguments de la ligne de commande
     */
    public static void main(String[] args) {
        Distributeur d = new Distributeur();
        int choix = menu();
        while (choix != 7) {
            switch (choix) {
                case 1:
                    ajouterBonbon(d);
                    break;
                case 2:
                    retirerBonbon(d);
                    break;
                case 3:
                    retirerBonbons(d);
                    break;
                case 4:
                    afficherNombreBonbons(d);
                    break;
                case 5:
                    afficherDistributeur(d);
                    break;
                case 6:
                    dessinerDistributeur(d);
                    break;
                default:
                    System.out.println("Erreur de choix, veuillez recommencer");
            }
            choix = menu();
        }
    }

}
