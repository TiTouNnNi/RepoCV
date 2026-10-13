package TPTris;

import static TPTris.Benchmark.FILENAME;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import org.junit.Test;

/**
 * Lancement des mesures de performance des tris.
 */
public class BenchmarkTest {

    @Test
    public void testBench() throws IOException {
        BufferedWriter bw = new BufferedWriter(new FileWriter(FILENAME));
        bw.write("typeTri taille temps");
        bw.close();
        System.out.println("Tri par sélection...");
        Benchmark.bench(90000, Sort.TRI_SELECTION);
        System.out.println("Tri à bulle...");
        Benchmark.bench(90000, Sort.TRI_BULLE);
        
        System.out.println("Tri par comptage...");
        Benchmark.bench(90000, Sort.TRI_COMPTAGE);
       /* System.out.println("Tri rapide...");
        Benchmark.bench(90000, Sort.TRI_RAPIDE);
        System.out.println("Tri par insertion...");
        Benchmark.bench(90000, Sort.TRI_PAR_INSERTION);
        System.out.println("Tri fusion...");
        Benchmark.bench(90000, Sort.TRI_FUSION);
        */
        System.out.println("Tri Java...");
        Benchmark.bench(90000, Sort.TRI_JAVA);
    }
}
