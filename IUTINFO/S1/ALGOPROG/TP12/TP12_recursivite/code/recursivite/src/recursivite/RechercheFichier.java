package recursivite;

import java.io.File;
import java.util.Arrays;

/**
 * Recherche et comptage de fichiers
 */
class RechercheFichier {

    /**
     * Calcule le nombre de fichiers dans un répertoire et ses sous-répertoires.
     *
     * @param cheminRep le chemin du répertoire à considérer
     * @return le nombre de ses fichiers, y compris dans ses sous-répertoires.
     */
    static int nbFichiers(String cheminRep) {
        // TODO
        return 0;
    }

    /**
     * Teste si un répertoire contient un fichier, directement ou indirectement
     * (dans un de ses sous-répertoires).
     * 
     * @param cheminRep le chemin du répertoire à parcourir
     * @param nomFichier le nom du fichier à rechercher
     * @return vrai ssi un fichier avec ce nom est trouvé dans le répertoire
     */
    static boolean contientFichier(String cheminRep, String nomFichier) {
        // TODO
        return false;
    }

    /**
     * Cette fonction prend en paramètre le chemin d'un répertoire, et renvoie
     * un tableau avec le nom de tous ses sous-répertoires directs.
     *
     * Vous n'avez pas à comprendre son code.
     *
     * @param cheminRep le chemin du répertoire à analyser
     * @return le tableau des noms de ses sous-répertoires directs
     */
    static String[] sousRepertoires(String cheminRep) {
        File file = new File(cheminRep);
        File[] files = file.listFiles();
        String[] ssReps = new String[files.length];
        int cptSsReps = 0;
        for (File file1 : files) {
            if (file1.isDirectory()) {
                ssReps[cptSsReps] = file1.getName();
                cptSsReps++;
            }
        }
        return Arrays.copyOf(ssReps, cptSsReps);
    }

    /**
     * Renvoie les noms des fichiers présents dans un répertoire.
     *
     * Vous n'avez pas à comprendre son code.
     *
     * @param cheminRep chemin du répertoire à analyser
     * @return tableau des noms de fichiers présents dans le répertoire
     */
    static String[] fichiers(String cheminRep) {
        File file = new File(cheminRep);
        File[] files = file.listFiles();
        if (files == null) {
            throw new IllegalArgumentException(
                    "Le répertoire suivant n'existe pas : " + cheminRep);
        }
        int cptFichiers = 0;
        String[] nomsFichiers = new String[files.length];
        for (File file1 : files) {
            if (!file1.isDirectory()) {
                nomsFichiers[cptFichiers] = file1.getName();
                cptFichiers++;
            }
        }
        return Arrays.copyOf(nomsFichiers, cptFichiers);
    }
}
