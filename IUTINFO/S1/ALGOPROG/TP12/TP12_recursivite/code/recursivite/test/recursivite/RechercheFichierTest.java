package recursivite;

import java.io.File;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import org.junit.Test;

/**
 * Tests unitaires sur la classe RechercheFichier.
 */
public class RechercheFichierTest {

    /**
     * Chemin vers l'arborescence de test. A adapter...
     */
    static final String RACINE
            = "/votre/chemin/vers/rep_pour_tests"
            + File.separatorChar;

    @Test
    public void testNbFichiers() {
        // TODO
    }

    @Test
    public void testContientFichier() {
        // TODO
    }

    /**
     * Test de la fonction sousRepertoires.
     */
    @Test
    public void testSousRepertoires() {
        String sousReps[] = RechercheFichier.sousRepertoires(RACINE);
        // 2 sous-repertoires
        assertEquals(2, sousReps.length);
        // on vérifie que ce sont bien rep1 et rep2
        boolean rep1present = false;
        boolean rep2present = false;
        for (int i = 0; i < sousReps.length; i++) {
            rep1present |= "rep1".equals(sousReps[i]);
            rep2present |= "rep2".equals(sousReps[i]);
        }
        assertTrue(rep1present);
        assertTrue(rep2present);
    }

    /**
     * Tests de la fonction fichiers.
     */
    @Test
    public void testFichiers() {
        String[] fichiers = RechercheFichier.fichiers(RACINE);
        // 2 fichiers à la racine
        assertEquals(2, fichiers.length);
        boolean fichier1present = false;
        boolean fichier2present = false;
        for (int i = 0; i < fichiers.length; i++) {
            fichier1present |= ("fichier1".equals(fichiers[i]));
            fichier2present |= ("fichier2".equals(fichiers[i]));
        }
        assertTrue(fichier1present);
        assertTrue(fichier2present);
        
        fichiers = RechercheFichier.fichiers(RACINE + "rep1");
        // 1 fichier sous rep1
        assertEquals(1, fichiers.length);
    }
}
