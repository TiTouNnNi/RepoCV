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

    @Test
    public void testTriParSelection() {
        // TODO
    }

    @Test
    public void testTriABulle() {
        // TODO
    }

    @Test
    public void testTriComptage() {
        // TODO
    }
}
