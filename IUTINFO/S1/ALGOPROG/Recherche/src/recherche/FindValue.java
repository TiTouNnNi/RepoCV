package recherche;
/**
 * Recherche d'une valeur dans un tableau.
 */
class FindValue {
    
    static int indice =-1;
    static int début;
    static int fin;
    static int milieu;

    /**
     * Recherche dans un tableau non trié : parcours linéaire.
     *
     * @param tab le tableau d'éléments
     * @param valeur la valeur à rechercher
     * @return l'indice d'un élément égal à la valeur, ou -1 si un tel élément
     * n'existe pas.
     */
    static int rechercheLineaire(int[] tab, int valeur) {
        for(int i=0; i<tab.length-1;i++){
            if (tab[i]==valeur){
                i=indice;
            }
            
        }
        return indice;
    }

    /**
     * Recherche dichotomique dans un tableau trié.
     *
     * @param tab le tableau d'éléments, trié
     * @param valeur la valeur à rechercher
     * @return l'indice d'un élément égal à la valeur, ou -1 si un tel élément
     * n'existe pas.
     */
    static int rechercheDichotomique(int[] tab, int valeur) {
        début=0;
        fin=tab.length -1;
        milieu=(fin+début)/2;
        while (début!=fin && tab[milieu]!=valeur) {
           if (tab[milieu]>valeur){
               fin=milieu-1;
           }       
           else {
               début = milieu+1;
               milieu=(début+fin)/2;
           }
         if (tab[milieu]==valeur){
             indice=milieu;
         }  
        }
        
        return indice;
    }
}
