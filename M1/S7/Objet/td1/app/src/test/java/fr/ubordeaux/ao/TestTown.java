package fr.ubordeaux.ao;

public class TestTown {
    public static void main(String[] args) {
        try {
            // Test 1: Création de villes valides
            System.out.println("=== Test création villes valides ===");
            Town paris = new Town("Paris", 75000);
            Town bordeaux = new Town("Bordeaux", 33000);
            System.out.println("Paris: " + paris);
            System.out.println("Bordeaux: " + bordeaux);
            
            // Test 2: Recherche par nom
            System.out.println("\n=== Test recherche par nom ===");
            System.out.println("Code postal de Paris: " + Town.getZipFromName("Paris"));
            System.out.println("Code postal de Lyon: " + Town.getZipFromName("Lyon"));
            
            // Test 3: Recherche par code postal
            System.out.println("\n=== Test recherche par code postal ===");
            String[] villes75000 = Town.getNameFromZip(75000);
            System.out.println("Villes avec code 75000:");
            for (String ville : villes75000) {
                System.out.println("  - " + ville);
            }
            
            String[] villes33000 = Town.getNameFromZip(33000);
            System.out.println("Villes avec code 33000:");
            for (String ville : villes33000) {
                System.out.println("  - " + ville);
            }
            
            // Test 4: Test avec code postal inconnu
            System.out.println("\n=== Test code postal inconnu ===");
            String[] villesInconnues = Town.getNameFromZip(99999);
            System.out.println("Nombre de villes avec code 99999: " + villesInconnues.length);
            
            // Test 5: Affichage du contenu de la HashMap
            System.out.println("\n=== Contenu de la HashMap ===");
            System.out.println("Nombre de villes chargées: " + Town.towns.size());
            
        } catch (Exception e) {
            System.err.println("Erreur lors des tests: " + e.getMessage());
            e.printStackTrace();
        }
    }
}