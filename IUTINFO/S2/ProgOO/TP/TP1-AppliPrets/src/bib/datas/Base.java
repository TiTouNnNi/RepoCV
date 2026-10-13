package bib.datas;

import bib.datas.Abonne;
import java.util.ArrayList;
import java.util.HashSet;

public class Base {

    int dernierNumeroAbonne; // numérotation automatique des abonnés.
    private HashSet<Abonne> abonnes;
    private HashSet<Livre> livres;

    public Base() {
        this.dernierNumeroAbonne = 20210000;
        this.abonnes = new HashSet<>();
        this.livres= new HashSet<>();
    }

    public void ajouterAbonne(String nom) {
        dernierNumeroAbonne += 1;
        Abonne nouveau = new Abonne(dernierNumeroAbonne, nom);
        abonnes.add(nouveau);
    }

    public void ajouterLivre(String nom) {
        Livre nouveau = new Livre(nom);
        livres.add(nouveau);
    }

    public ArrayList<Abonne> abonnesParPartieDuNom(String chaine) {
        ArrayList<Abonne> l= new ArrayList <>();
        for ( Abonne abonne : abonnes){
            if(abonne.getNom().contains(chaine)){
                l.add(abonne);
            }
        }
        return l;
    }
    
    public ArrayList<Livre> LivreParPartieDeDesc(String chaine) {
        ArrayList<Livre> l= new ArrayList <>();
        for ( Livre livre : livres){
            if(livre.getTitre().contains(chaine)){
                l.add(livre);
            }
        }
        return l;
    }
    
      public void modifEmprunteur(Abonne a,Livre l){
        l.emprunteur=a;
        a.ajouteEmprunt(l);
    }
      
    public HashSet<Abonne> getAbonne(){
        return new HashSet<Abonne>(this.abonnes);
    }
    
    public  HashSet<Livre> getLivre(){
        return new HashSet<Livre>(this.livres);
    }
}
