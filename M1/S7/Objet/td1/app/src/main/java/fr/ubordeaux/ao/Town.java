package fr.ubordeaux.ao;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

public class Town {

    public static final String[][] Oldtowns = {
        { "Paris", "75000" },
        { "Lyon", "69000" },
        { "Marseille", "13000" },
        { "Toulouse", "31000" },
        { "Nice", "06000" },
        { "Nantes", "44000" },
        { "Strasbourg", "67000" },
        { "Montpellier", "34000" },
        { "Bordeaux", "33000" },
        { "Lille", "59000" } };

    private String name;
    private int zipcode;

    public static HashMap<String,Integer> towns;

    public Town(String name, int zipcode) {
        if (!towns.containsKey(name)){
            this.name = name;
        }
        if (!isZipcodeValid(name, zipcode)) {
            throw new IllegalArgumentException("Paramètre invalide");
        }
        this.zipcode = zipcode;
    }

    // Constructeur qui prend un code postal en chaîne de caractères
    public Town(String name, String zipcode) {
        this.name = name;
        this.zipcode = Integer.parseInt(zipcode); // Conversion String -> int
    }

    public String getName() {
        return name;
    }

    public int getZipCode() {
        return zipcode;
    }

    private boolean isZipcodeValid(String ville, int zip){
        return towns.get(ville) == zip;
    }

    public static int getZipFromName(String ville){
        return towns.get(ville);
    }

    public static String[] getNameFromZip(int zip){
        String[] cities = null;
        int i = 0;
        for(Entry<String, Integer> entry : towns.entrySet()){
            if(zip == entry.getValue()){
                cities[i] = entry.getKey();
                i++;
            }
        }

        if( cities == null){
            return new String[0];
        }

        return cities;
    }

    @Override
    public String toString() {
        return name + " - " + zipcode;
    }

    public void fillTowns() throws FileNotFoundException, IOException{
        try(BufferedReader br = new BufferedReader(new FileReader("towns.csv"))){
            String line;
            while ((line = br.readLine()) != null){
                String[] values = line.split(";");
                //System.out.println(values);
                towns.put(values[1], Integer.parseInt(values[0]));
            }
        }
    }

    @Override
    public boolean equals(Object o){
        if (o == null || getClass() != o.getClass()) 
            return false;
        
        
    }

}