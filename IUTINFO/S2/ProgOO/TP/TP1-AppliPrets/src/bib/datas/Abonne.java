package bib.datas;

import java.util.HashSet;

public class Abonne {

    final int numero;
    final String nom;
    HashSet<Livre> livreEmpruntes;

    public Abonne(int numero, String nom) {
        this.numero = numero;
        this.nom = nom;
        this.livreEmpruntes = new HashSet<>();
    }

    public String getNumero() {
        
        return String.valueOf(numero);
    }

    public String getNom() {
        return this.nom;
    }
    
    void ajouteEmprunt(Livre l){
        this.livreEmpruntes.add(l);
    }
}
