/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sokoban;

/**
 *
 * @author MOI
 */
public class TextBoardBuilder implements BoardBuilder {
    
    public String name = "";
    public String serialized = "";
    public char[][] plateau;
    public Position joueur;
    
    public TextBoardBuilder(String name) {
        this.name = name;
    }

    @Override
    public void read(String src) {
        this.serialized += src+"\n";
    }

    @Override
    public void parse() {
        this.serialized = this.serialized.substring(0,serialized.length()-1);
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
    
    @Override
    public void setName(String name) {
        this.name = name;
    }

    public Board build() {
        return this.build(this.name, this.plateau, this.joueur);
    }
    
}
