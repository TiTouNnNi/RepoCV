package TPTris;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;

/**
 * Mesure de performance des différents algorithmes de tri.
 */
class Benchmark {

    final static String FILENAME = "benchmark.txt";

    /**
     * Lancement des mesures.
     *
     * @param tailleMax taille maximale du tabelau testé.
     * @param typeTri type de tri testé
     */
    static void bench(int tailleMax, Sort typeTri) {
        final int pas = 10000; // pas entre chaque taille testee

        // fichier ou sont stockees les mesures
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(FILENAME, true));

            bw.newLine();
            int taille;
            Random m_random = new Random();
            for (taille = pas; taille <= tailleMax; taille += pas) {
                System.out.println(" tri d'un tableau de taille " + taille);
                // initialisation du tableau
                int tab[] = new int[taille];
                int i;
                for (i = 0; i < taille; i++) {
                    tab[i] = m_random.nextInt(Integer.MAX_VALUE);
                }
                long tempsDebut = System.currentTimeMillis();
                Sort.tri(tab, typeTri);
                long tempsFin = System.currentTimeMillis();
                long totalTime = tempsFin - tempsDebut;
                System.out.println("  temps = " + totalTime + " ms");
                String toWrite = typeTri.ordinal() + " " + taille + " " + totalTime;
                bw.write(toWrite);
                if (taille != tailleMax) {
                    bw.newLine();
                }
            }
            bw.close();

        } catch (IOException e) {
            System.out.println("File read error");
        }
    }
}
