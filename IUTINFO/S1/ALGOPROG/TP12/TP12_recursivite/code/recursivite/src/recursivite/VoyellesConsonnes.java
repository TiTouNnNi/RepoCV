package recursivite;

/**
 * Exercice sur les voyelles et les consonnes.
 */
class VoyellesConsonnes {

    /**
     * Indique si une lettre est une voyelle. On ne considère ici que les 
     * lettres non accentuées.
     * 
     * @param c la lettre
     * @return vrai ssi la lettre est une voyelle.
     */
    static boolean estVoyelle(char c) {
        return "aeiouyAEIOUY".contains("" + c);
    }

    /**
     * Nombre de voyelles du mot, calculé de manière non récursive
     * 
     * @param mot le mot
     * @return le nombre de voyelles du mot
     */
    static int nbVoyellesNonRec(String mot) {
        return -1; // TODO
    }

    /**
     * Nombre de voyelles d'un mot, à droite d'une position donnée, calculé
     * récursivement.
     * 
     * @param mot le mot à considérer
     * @param pos la position à partir de laquelle on compte les voyelles
     * (incluse)
     * @return le nombre de voyelles du mot à partir de cette position
     */
    static int nbVoyellesAPartirDe(String mot, int pos) {
        return -1; // TODO
    }

    /**
     * Nombre de voyelles d'un mot, calculé récursivement.
     * 
     * @param mot le mot à considérer
     * @return le nombre de ses voyelles
     */
    static int nbVoyellesRec(String mot) {
        return -1; // TODO
    }

    /**
     * À partir d'un mot, construit le mot composé des voyelles du mot initial,
     * puis de ses consonnes dans l'ordre inverse.
     * 
     * @param mot le mot initial
     * @return le mot composé des voyelles du mot initial, puis de ses consonnes
     * dans l'ordre inverse
     */
    static String voyellesPuisConsonnes(String mot) {
        return ""; // TODO
    }
}
