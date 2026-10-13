package carremagique;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

/**
 * Récupération des valeurs d'un carré magique depuis un serveur. Vous n'avez
 * pas à comprendre / modifier ce code.
 *
 * @author nicholasjournet
 */
public class requeteCarre {

    public static int getVal(int version, int val, int l, int c) {
        String ur = "http://147.210.240.40/java/magique.php?version=" + String.valueOf(version) + "&val=" + String.valueOf(val) + "&l=" + String.valueOf(l) + "&c=" + String.valueOf(c);//ton URL
        String post = "";//
        String reponse = null;
        try {
            URL url = new URL(ur);
            URLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setDoOutput(true);
            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
            writer.write(post);
            writer.flush();
            //recuperation du code html
            String ligne = null;
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            while ((ligne = reader.readLine()) != null) {
                //reponse+= ligne.trim()+"\n";
                reponse = ligne.trim();
            }
        } catch (IOException e) {
            System.out.println("system serveur erreur");
            System.exit(1);
        }
        return Integer.parseInt(reponse);
    }
}
