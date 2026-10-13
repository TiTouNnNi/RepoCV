package distributeurfriandise;

/**
 * Tests unitaires de la classe Distributeur.
 */
class DistributeurTest {
    
    static void testAjouterBonbon() {
    }

    static void testRetirerBonbon() {
        Distributeur d = new Distributeur();
        d.ajouterBonbon(Bonbon.venus());
        assert !d.vide();
        d.retirerBonbon();
        assert d.vide();
    }

    static void testRetirerBonbons_int() {
        Distributeur d = new Distributeur();
        for (int i=0;i< Distributeur.CONTENANCE_MAX;i++){
            d.ajouterBonbon(Bonbon.venus());
        }
        d.retirerBonbon();
        assert d.vide();
    }

    static void testRetirerBonbons_0args() {
        Distributeur d = new Distributeur();
        for (int i=0;i< Distributeur.CONTENANCE_MAX;i++){
            d.ajouterBonbon(Bonbon.venus());
        }
        Bonbon[] bonbonsupprimes = d.retirerBonbons(3);
        assert d.nombreBonbons == Distributeur.CONTENANCE_MAX-3;
        assert bonbonsupprimes.length == 3;
        
    }

    static void testPlein() {
        Distributeur d = new Distributeur();
        assert !d.plein();
        for(int i =0; i< Distributeur.CONTENANCE_MAX; i++){
            d.ajouterBonbon(Bonbon.venus());
        }
        assert d.plein();
    }

    static void testVide() {
        Distributeur d = new Distributeur();
        assert d.vide();
        boolean ajout = d.ajouterBonbon(Bonbon.tigre());
        assert ajout;
        assert !d.vide();
    }

    static void testNombreBonbons() {
    }

    public static void main(String[] args) {
        testAjouterBonbon();
        testRetirerBonbon();
        testRetirerBonbons_int();
        testRetirerBonbons_0args();
        testPlein();
        testVide();
        testNombreBonbons();
    }
}
