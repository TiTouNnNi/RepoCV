/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package morpion;

import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertFalse;
import static junit.framework.Assert.assertTrue;
import org.junit.Test;

/**
 *
 * @author MOI
 */
public class CoordonneesTest {
    @Test
public void testEstDansPlateau() {
    assertTrue(new Coordonnees(0, 0).estDansPlateau(14));
    assertTrue(new Coordonnees(13, 13).estDansPlateau(14));
    assertTrue(new Coordonnees(0, 1).estDansPlateau(14));
    assertFalse(new Coordonnees(-1, 1).estDansPlateau(14));
    assertTrue(new Coordonnees(7, 13).estDansPlateau(14));
    assertFalse(new Coordonnees(7, 14).estDansPlateau(14));
    assertTrue(new Coordonnees(13, 0).estDansPlateau(14));
    assertFalse(new Coordonnees(14, 0).estDansPlateau(14));
    assertTrue(new Coordonnees(7, 0).estDansPlateau(14));
    assertFalse(new Coordonnees(7, -1).estDansPlateau(14));
    assertTrue(new Coordonnees(0, 1).estDansPlateau(2));
    assertFalse(new Coordonnees(0, 1).estDansPlateau(1));
}

@Test
public void testVoisines() {
            {
        // milieu de plateau
        Coordonnees[] voisines = new Coordonnees(3, 2).voisines(8);
        assertEquals(8, voisines.length);
        assertTrue(tableauContient(voisines, new Coordonnees(4, 2)));
        assertTrue(tableauContient(voisines, new Coordonnees(2, 2)));
        assertTrue(tableauContient(voisines, new Coordonnees(3, 1)));
        assertTrue(tableauContient(voisines, new Coordonnees(3, 3)));
        assertTrue(tableauContient(voisines, new Coordonnees(4, 3)));
        assertTrue(tableauContient(voisines, new Coordonnees(4, 1)));
        assertTrue(tableauContient(voisines, new Coordonnees(2, 1)));
        assertTrue(tableauContient(voisines, new Coordonnees(2, 3)));
    }
    {
        // bord droit du plateau
        Coordonnees[] voisines = new Coordonnees(3, 7).voisines(8);
        assertEquals(5, voisines.length);
        assertTrue(tableauContient(voisines, new Coordonnees(3, 6)));
        assertTrue(tableauContient(voisines, new Coordonnees(4, 6)));
        assertTrue(tableauContient(voisines, new Coordonnees(4, 7)));
        assertTrue(tableauContient(voisines, new Coordonnees(2, 6)));
        assertTrue(tableauContient(voisines, new Coordonnees(2, 7)));
    }
    {
        // coins
        Coordonnees[] voisines = new Coordonnees(7, 7).voisines(8);
        assertEquals(3, voisines.length);
        assertTrue(tableauContient(voisines, new Coordonnees(6, 7)));
        assertTrue(tableauContient(voisines, new Coordonnees(6, 6)));
        assertTrue(tableauContient(voisines, new Coordonnees(7, 6)));
        assertEquals(3, new Coordonnees(0, 7).voisines(8).length);
        assertEquals(3, new Coordonnees(7, 0).voisines(8).length);
        assertEquals(3, new Coordonnees(0, 0).voisines(8).length);
    }
}
    @Test
public void testSuivante() {
    assertEquals(new Coordonnees(5, 4),
            new Coordonnees(4, 4).suivante(Direction.SUD));
    assertEquals(new Coordonnees(0, 0),
            new Coordonnees(1, 1).suivante(Direction.NORD_OUEST));
    assertEquals(new Coordonnees(-1, -1),
            new Coordonnees(0, 0).suivante(Direction.NORD_OUEST));
    assertEquals(new Coordonnees(199, 201),
            new Coordonnees(200, 200).suivante(Direction.NORD_EST));
}
 static boolean tableauContient(Coordonnees[] t, Coordonnees c) {
        boolean trouve = false;
        for (Coordonnees coord : t) {
            if (coord != null && coord.equals(c)) {
                trouve = true;
            }
        }
        return trouve;
    }

}
