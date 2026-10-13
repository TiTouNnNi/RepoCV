package distributeurfriandise;

/**
 * Tests unitaires de la classe Bonbon.
 */
class BonbonTest {
    
    static void testChewingGum() {
        Bonbon b = Bonbon.chewingGum(Parfum.CHOCOLAT);
        assert Parfum.CHOCOLAT.equals(b.parfum);
        assert "ChewingGum".equals(b.denomination);
        assert (10-b.poids) <0.01;
        assert (52 - b.calories) < 0.01;
    }

    static void testChypresers() {
    }

    static void testTigre() {
    }

    static void testNoisettes() {
    }

    static void testVenus() {
    }

    public static void main(String[] args) {
        testChewingGum();
        testChypresers();
        testTigre();
        testNoisettes();
        testVenus();
    }
}
