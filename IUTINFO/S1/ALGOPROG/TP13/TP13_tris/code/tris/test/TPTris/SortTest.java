package TPTris;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Tests unitaires des différents tris.
 */
public class SortTest {

    @Test
    public void testEchanger() {
        int[] tab = {2, 4, 5};
        int i = 0;
        int j = 2;
        Sort.echanger(tab, i, j);
        assertEquals(5, tab[0]);
        assertEquals(2, tab[2]);
    }

   /* @Test
    public void testTriParSelection() {
        int[] tab = {7, 2, 5, 12, -3, 4, 1, 0, 11};
        Sort.triParSelection(tab);
        for (int i = 0; i < tab.length; i++) {
            System.out.println(tab[i]);
        }
    }*/

    /*@Test
    public void testTriABulle() {
        int[] tab = {7, 2, 5, 12, -3, 4, 1, 0, 11};
        Sort.triABulle(tab);
        for (int i = 0; i < tab.length - 1; i++) {
            System.out.println(tab[i]);
        }
    }*/

    @Test
    public void testTriComptage() {
        int[] tab = {7, 2, 5, 12, -3, 4, 1, 0, 11};
        Sort.triComptage(tab);
        for (int i = 0; i < tab.length - 1; i++) {
            System.out.println(tab[i]);
            assertTrue(tab[i] < tab[i + 1]);
        }
    }
}
