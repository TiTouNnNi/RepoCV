package distributeurfriandise;

/**
 * Un distributeur.
 */
class Distributeur {

    /**
     * Nombre maximal de bonbons dans un distributeur.
     */
    static final int CONTENANCE_MAX = 50;
    
    /**
     * Nombre de lignes de bonbons dans le dessin du distributeur.
     */
    static final int HAUTEUR_DESSIN = 7;

    /**
     * Nombre de colonnes de bonbons dans le dessin du distributeur.
     */
    static final int LARGEUR_DESSIN = 7;

    /**
     * Nombre de bonbons dans ce distributeur.
     */
    int nombreBonbons;
    
    /**
     * Le tableau des bonbons contenus dans ce distributeur.
     */
    Bonbon[] contenu;

    /**
     * Constructeur par défaut de distributeur.
     */
    Distributeur() {
        nombreBonbons = 0;
        contenu = new Bonbon[CONTENANCE_MAX];
    }

    /**
     * Méthode permettant d'ajouter un bonbon au distributeur
     *
     * @param b bonbon à ajouter
     * @return true si le bonbon a pu être ajouté, false sinon
     */
    boolean ajouterBonbon(Bonbon b) {
        if (!plein()) {
            contenu[nombreBonbons] = b;
            nombreBonbons++;
            return true;
        }
        return false;
    }

    /**
     * Méthode permettant de retirer un bonbon du distributeur.
     */
    Bonbon retirerBonbon() {
        if (vide()){
            return null;
        }
        Bonbon b = contenu[nombreBonbons-1];
        --nombreBonbons;
        return b;
        
    }

    /**
     * Méthode permettant de retirer un certain nombre de bonbons du
     * distributeur.
     *
     * @param unNombreDeBonbons nombre de bonbons à retirer
     * @return retourne les bonbons retirés
     */
    Bonbon[] retirerBonbons(int unNombreDeBonbons) {
        Bonbon[] bonbons = new Bonbon[unNombreDeBonbons];
            for(int i=0;i< unNombreDeBonbons;i++){
                bonbons[i]=retirerBonbon();
            }
           return bonbons; 
    }

    /**
     * Méthode permettant de retirer tous les bonbons du distributeur.
     *
     * @return retourne les bonbons retirés
     */
    Bonbon[] retirerBonbons() {
        return retirerBonbons(nombreBonbons);
    }

    /**
     * Méthode retournant vrai si le distributeur est plein.
     *
     * @return true si le distributeur est plein, false sinon
     */
    boolean plein() {
       return nombreBonbons==CONTENANCE_MAX;
    }

    /**
     * Méthode retournant vrai si le distributeur est vide.
     *
     * @return true si le distributeur est vide, false sinon
     */
    boolean vide() {
        return nombreBonbons==0;
    }

    /**
     * Méthode retournant le nombre de bonbons du distributeur.
     *
     * @return nombre de bonbons contenus dans le distributeur
     */
    int nombreBonbons() {
        return nombreBonbons;
    }

    /**
     * Méthode permettant de dessiner le contenu du distributeur.
     */
    void dessiner() {
    }

    /**
     * Méthode permettant d'afficher le contenu du distributeur.
     */
    void afficher() {
        System.out.println("Ce distributeur contient" +nombreBonbons+ " bonbons"); 
        for(int i=0; i> nombreBonbons;i++){
            contenu[i].afficher();
        }
    }
}
