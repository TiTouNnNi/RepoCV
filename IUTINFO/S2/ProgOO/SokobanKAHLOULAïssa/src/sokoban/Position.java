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
public class Position {

    public int row, col;

    /**
     * Constructeur de la class Position
     *
     * @param ligne la ligne sur laquelle se trouve la case
     * @param colonne la colonne sur laquelle se trouve la case
     */
    public Position(int ligne, int colonne) {
        this.row = ligne;
        this.col = colonne;
    }

    public Position suivante(char direction) {
        Position p = new Position(row, col);
        switch (direction) {
            case 'U':
                p.row--;
                break;
            case 'D':
                p.row++;
                break;
            case 'L':
                p.col--;
                break;
            case 'R':
                p.col++;
                break;
            default:
                break;
        }
        return p;
    }
    

}
