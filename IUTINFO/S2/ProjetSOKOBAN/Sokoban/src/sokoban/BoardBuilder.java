/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sokoban;

import java.util.Scanner;

/**
 *
 * @author MOI
 */
public interface BoardBuilder {
    void read(String src);
    
    void parse();
    
    void setName(String name);
    
    default Board build(String name, char[][] plateau, Position joueur) {
        return new Board(name, plateau, joueur);
    }
}
