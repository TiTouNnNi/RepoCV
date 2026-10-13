package bib;

import bib.datas.Livre;
import bib.datas.Base;
import bib.datas.Abonne;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Scanner;

public class Appli {

    static Scanner in = new Scanner(System.in);
    static PrintStream out = System.out;
    static Base base;

    public static void main(String[] args) {
        out.println("* Hello.");
        base = new Base();
        chargerDonneesFictives();
        menuPrincipal();
    }

    static void menuPrincipal() {
        boolean boucler = true;
        while (boucler) {
            out.println("* Menu");
            out.println("aa) ajouter abonné");
            out.println("al) ajouter livre");
            out.println("ae) listes des livres avec un emprunteur");
            out.println("ra) recherche des abonnés");
            out.println("p) prêter un livre");
            out.println("r) retourner un livre");
            out.println("q) quitter");
            out.print("? ");
            String commande = lireLigne();
            switch (commande) {
                case "q":
                    out.println("-> Bye.");
                    boucler = false;
                    break;
                case "aa":
                    ajoutAbonne();
                    break;
                case "al":
                    ajoutLivre();
                    break;
                case "ra":
                    rechercheAbonnes();
                    break;
                case "p":
                    pretLivre();
                    break;
                case "ae":
                    afficherLivresEmprunte();
                    break;
                case "r":
                    retournerLivre();
                    break;
                default:
                    out.println("-> commande inconnue '" + commande + "'");
                    break;
            }
        }
    }

    /**
     * Fonction qui rajoute une abonné dans la liste
     *
     * @author Aïssa KAHLOUL ( groupe A prime )
     */
    static void ajoutAbonne() {
        out.println("* Menu / Ajout abonné");
        out.print("Nom ? ");
        String nom = lireLigne();
        if (nom.isEmpty()) {
            out.println("-> pas de nom, retour au menu");
        } else {
            base.ajouterAbonne(nom);
        }
    }

    /**
     * Fonction qui rajoute un livre dans la liste
     *
     * @author Aïssa KAHLOUL ( groupe A prime )
     */
    static void ajoutLivre() {
        out.println("* Menu / Ajout livre");
        out.print("Titre du Livre ? ");
        String nom = lireLigne();
        if (nom.isEmpty()) {
            out.println("-> pas de titre, retour au menu");
        } else {
            base.ajouterLivre(nom);
        }
    }

    /**
     * Fonction qui recherche un abonné
     *
     * @author Aïssa KAHLOUL ( groupe A prime )
     */
    static void rechercheAbonnes() {
        out.println("* Menu / recherche d'abonnes");
        out.print("donnez une partie du nom : ");
        String chaine = lireLigne();
        ArrayList<Abonne> liste = base.abonnesParPartieDuNom(chaine);
        for (Abonne a : liste) {
            out.println("-> " + a.getNumero() + "\t" + a.getNom());
        }

    }

    /**
     * Fonction qui afficher les livres ayant un emprunteur
     *
     * @author Aïssa KAHLOUL ( groupe A prime )
     */
    static void afficherLivresEmprunte() {
        HashSet<Livre> liste = base.getLivre();
        for (Livre l : liste) {
            if (l.emprunteur != null) {
                String titreLivre = l.getTitre();
                out.println("Le livre," + titreLivre + "est emprunté par" + l.emprunteur);
            }
        }
    }

    /**
     * Fonction qui recherche un livre par rapport à une chaine de caractères
     *
     * @author Aïssa KAHLOUL ( groupe A prime )
     */
    static void rechercheLivres() {
        out.println("* Menu / recherche livre");
        out.print("donnez une partie de la description du livre : ");
        String chaine = lireLigne();
        ArrayList<Livre> liste = base.LivreParPartieDeDesc(chaine);
        for (Livre l : liste) {
            out.println("-> " + l.getTitre());
        }

    }

    static void pretLivre() {
        out.println("* Ecrivez le titre du livre que vous voulez rendre");
        out.print("donnez une partie de la description du livre : ");


        /*1. demander une partie du nom */
 /*2. chercher dans la base les abonnés correspondants*/
 /* 3. les afficher sous forme de liste numérotée*/
        out.println("* Menu / prêt livre");
        out.print("donnez une partie du nom : ");
        String chaine = lireLigne();
        ArrayList<Abonne> liste = base.abonnesParPartieDuNom(chaine);
        int num = 0;
        for (Abonne a : liste) {
            out.println("-> " + num + "\t" + a.getNom());
            num++;
        }
        /*4. demander de choisir un numéro*/
        out.println("*Choisir numéro de l'abonné");
        String numAbo = lireLigne();
        int index = Integer.parseInt(numAbo);
        Abonne choisi = liste.get(index);
        /* 5. noter l'abonné qui imprunte*/

 /*  5. pareil pour une partie de la description du livre à prêter*/
 /*6. noter l'ouvrage qui va être emprunté*/
        out.print("donnez une partie du titre du livre : ");
        String desc = lireLigne();
        ArrayList<Livre> listeLivres = base.LivreParPartieDeDesc(desc);
        int numL = 0;
        for (Livre l : listeLivres) {
            out.println("-> " + numL + "\t" + l.getTitre());
            numL++;
        }
        out.println("*Choisir numéro du livre");
        String numLivre = lireLigne();
        int indexL = Integer.parseInt(numLivre);
        Livre livreChoisi = listeLivres.get(indexL);
        /* 7. demander confirmation*/
        out.println("Etes vous sur de vouloir emprunter ce livre,tapez oui si vous etes sur et non si vous n'etes pas sur");
        String reponse = lireLigne();
        /*  8. si oui //  base.enregistrerPret(abonne,livre) */
        switch (reponse) {
            case "oui":
                base.modifEmprunteur(choisi, livreChoisi);
                break;
            case "non":
                out.println("Retour au Menu");
                break;
            default:
                break;
        }

    }

    static void retournerLivre() {
        out.print("donnez une partie du titre du livre : ");
        String desc = lireLigne();
        ArrayList<Livre> listeLivres = base.LivreParPartieDeDesc(desc);
        int numL = 0;
        for (Livre l : listeLivres) {
            out.println("-> " + numL + "\t" + l.getTitre());
            numL++;
        }
        out.println("*Choisir numéro du livre");
        String numLivre = lireLigne();
        int indexL = Integer.parseInt(numLivre);
        Livre livreChoisi = listeLivres.get(indexL);
        /* 7. demander confirmation*/
        out.println("Tapez votre nom");
        String nomProprio = lireLigne();
        if (nomProprio.equals(livreChoisi.getEmprunteur())) {
            out.println("Etes vous sur de vouloir rendre ce livre,tapez oui si vous etes sur et non si vous n'etes pas sur");
            String reponse = lireLigne();
            /*  8. si oui //  base.enregistrerPret(abonne,livre) */
            switch (reponse) {
                case "oui":
                    base.modifEmprunteur(null, livreChoisi);
                    break;
                case "non":
                    out.println("Retour au Menu");
                    break;
                default:
                    break;
            }
        }
    }

    private static String lireLigne() {
        return in.nextLine().trim();
    }

    static void chargerDonneesFictives() {
        base.ajouterAbonne("Antoine Martin");
        base.ajouterAbonne("Juliette Dupont");
        base.ajouterAbonne("Julien Durand");
        base.ajouterAbonne("Brice Marmelade");

        base.ajouterLivre("C pour les nuls");
        base.ajouterLivre("Programmation objets en Cobol 2014");
        base.ajouterLivre("FORTRAN pour les nuls");
    }

}
