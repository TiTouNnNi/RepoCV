package recursivite;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import org.junit.Test;

/**
 * Tests unitaires de la classe VoyellesConsonnes.
 */
public class VoyellesConsonnesTest {
    
    @Test
    public void testEstVoyelle() {
        assertTrue(VoyellesConsonnes.estVoyelle('a'));
        assertTrue(VoyellesConsonnes.estVoyelle('e'));
        assertTrue(VoyellesConsonnes.estVoyelle('i'));
        assertTrue(VoyellesConsonnes.estVoyelle('o'));
        assertTrue(VoyellesConsonnes.estVoyelle('u'));
        assertTrue(VoyellesConsonnes.estVoyelle('y'));
        assertFalse(VoyellesConsonnes.estVoyelle('b'));
        assertFalse(VoyellesConsonnes.estVoyelle('z'));
        assertTrue(VoyellesConsonnes.estVoyelle('A'));
    }
    
    @Test
    public void testNbVoyellesNonRec() {
        assertEquals(0, VoyellesConsonnes.nbVoyellesNonRec(""));
        assertEquals(0, VoyellesConsonnes.nbVoyellesNonRec("r"));
        assertEquals(0, VoyellesConsonnes.nbVoyellesNonRec("fp jb"));
        assertEquals(1, VoyellesConsonnes.nbVoyellesNonRec("A"));
        assertEquals(3, VoyellesConsonnes.nbVoyellesNonRec("AOY"));
        assertEquals(3, VoyellesConsonnes.nbVoyellesNonRec("bonjour"));
        assertEquals(3, VoyellesConsonnes.nbVoyellesNonRec("bon jour"));
    }
    
    @Test
    public void testNbVoyellesRec() {
        assertEquals(0, VoyellesConsonnes.nbVoyellesRec(""));
        assertEquals(0, VoyellesConsonnes.nbVoyellesRec("r"));
        assertEquals(0, VoyellesConsonnes.nbVoyellesRec("fp jb"));
        assertEquals(1, VoyellesConsonnes.nbVoyellesRec("A"));
        assertEquals(3, VoyellesConsonnes.nbVoyellesRec("AOY"));
        assertEquals(3, VoyellesConsonnes.nbVoyellesRec("bonjour"));
        assertEquals(3, VoyellesConsonnes.nbVoyellesRec("bon jour"));
    }
    
    @Test
    public void voyellesPuisConconnes() {
        assertEquals("", VoyellesConsonnes.voyellesPuisConsonnes(""));
        assertEquals("a", VoyellesConsonnes.voyellesPuisConsonnes("a"));
        assertEquals("b", VoyellesConsonnes.voyellesPuisConsonnes("b"));
        assertEquals("Aoiemhtrgl", VoyellesConsonnes.voyellesPuisConsonnes("Algorithme"));
        assertEquals("aAeEDdCcBb", VoyellesConsonnes.voyellesPuisConsonnes("aAbBcCdDeE"));
    }
}
