/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package morpion;

import static junit.framework.Assert.assertEquals;
import org.junit.Test;

/**
 *
 * @author MOI
 */
public class GrilleTest {
    @Test
public void testNbVoisinsAppartenantAuJoueur() {
    int[][] contenu = {{2, 1, 1}, {2, 0, 0}, {2, 0, 0}};
    Grille grille = new Grille(3);
    grille.changerContenuGrille(contenu);
    assertEquals(2, grille.nbVoisinsAppartenantAuJoueur(1, new Coordonnees(1, 1)));
    assertEquals(3, grille.nbVoisinsAppartenantAuJoueur(2, new Coordonnees(1, 1)));
    assertEquals(0, grille.nbVoisinsAppartenantAuJoueur(1, new Coordonnees(2, 2)));
    assertEquals(1, grille.nbVoisinsAppartenantAuJoueur(2, new Coordonnees(0, 0)));
}
    
}
