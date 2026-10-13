/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sokoban;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MOI
 */
public class FileBoardBuilder implements BoardBuilder {
    
    public String name = "";
    public String serialized = "";
    public char[][] plateau;
    public Position joueur;
    
    public FileBoardBuilder(String name) {
        this.name = name;
    }
    
    @Override
    public void read(String src) {
        try {
            Scanner sc = new Scanner(new FileInputStream(src));
            String data = "";
            while(sc.hasNextLine()) {
                data += sc.nextLine().trim()+"\n";
            }
            sc.close();
            this.serialized = data.substring(0, data.length()-1);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(FileBoardBuilder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public void setName(String name) {
        this.name = name;
    }
    
    @Override
    public void parse() {
        String[] tab = this.serialized.split("\n");
        char[][] plateau = new char[tab.length][tab[0].length()];
        for(int i = 0; i < tab.length; i++) {
            for(int j = 0; j < tab[i].length(); j++){
                char c = Character.toUpperCase(tab[i].charAt(j));
                if(c == 'P') {
                    this.joueur = new Position(i,j);
                }
                plateau[i][j] = c;
            }
        }
        this.plateau = plateau;
    }
    
    public Board build() {
        this.parse();
        return this.build(this.name, this.plateau, this.joueur);
    }
}
