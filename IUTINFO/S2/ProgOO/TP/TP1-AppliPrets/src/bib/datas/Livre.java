package bib.datas;

import bib.datas.Abonne;

public class Livre {

    private final String titre;
    Abonne emprunteur;
    
    public Livre(String titre) {
        this.titre = titre;
        this.emprunteur = null;
    }
    
    public String getTitre(){
        return this.titre;
    }


    
}
