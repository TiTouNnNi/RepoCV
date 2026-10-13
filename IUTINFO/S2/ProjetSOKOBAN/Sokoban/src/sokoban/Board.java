/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sokoban;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MOI
 */
public class Board {

    char[][] plateau;
    int ligne, colonne;
    boolean partieGagné;
    Position joueur;
    String nom;

    Board(String name, int rows, int cols) {
        this.nom = name;
        this.ligne = rows;
        this.colonne = cols;
        joueur = null;
        partieGagné = false;
        initPlateau();
    }
    
    Board(String name, char[][] plateau, Position joueur) {
        this.nom = name;
        this.plateau = plateau;
        this.ligne = plateau.length;
        this.colonne = plateau[0].length;
        partieGagné = false;
        this.joueur = joueur;
    }

    public void initPlateau() {
        plateau = new char[ligne][colonne];
        for (int i = 0; i < ligne; i++) {
            for (int j = 0; j < colonne; j++) {
                plateau[i][j] = '.';
            }
        }
    }

    public void ajouterMurHorizontal(int row, int col, int length) {
        for (int i = 0; i < length; i++) {
            plateau[row][col + i] = '#';
        }
    }

    public void ajouterMurVertical(int row, int col, int length) {
        for (int i = 0; i < length; i++) {
            plateau[row + i][col] = '#';
        }
    }

    public void ajouterBoites(int row, int col) {
        Position p = new Position(row, col);
        plateau[row][col] = 'C';
    }

    public void ajouterTrous(int row, int col) {
        Position p = new Position(row, col);
        plateau[row][col] = 'X';
    }

    public void setPosition(int ligne, int colonne) {
        if (joueur != null) {
            plateau[joueur.row][joueur.col] = '.';
            joueur.row = ligne;
            joueur.col = colonne;
        } else {
            joueur = new Position(ligne, colonne);
        }
        plateau[ligne][colonne] = 'P';
    }

    public void testVictoire() {
        int size = 0;
        for (char[] line : plateau) {
            for (char c : line) {
                if (c == 'X')
                    size++;
            }
        }
        if (size == 0) {
            partieGagné = true;
        }
    }

    public boolean getVictoire() {
        return partieGagné;
    }
    
    public char getPos(Position pos) {
        if (pos.row < 0 || pos.row >= ligne || pos.col < 0 || pos.col >= colonne) {
            return ' ';
        }
        return Character.toUpperCase(plateau[pos.row][pos.col]);
    }

    public void déplacerJoueur(char direction) {
        Position nextP = joueur.suivante(direction);
        if (getPos(nextP) == 'C') {
            boolean search = true, allowed = true;
            int nbCase = 0;
            int r = joueur.row, c = joueur.col;
            boolean pWin = false;
            Position pos = joueur.suivante(direction);
            while (search) {
                switch (getPos(pos)) {
                    case 'C' :
                        nbCase++;
                        break;
                    case '#' :
                    case ' ' :
                    case 'P' :
                        allowed = false;
                    case 'X' :
                        pWin = true;
                    case '.' :
                        search = false;
                        break;
                    default :
                        break;
                }
                if(search)
                    pos = pos.suivante(direction);
            }
            
            if (allowed) {
                setPosition(nextP.row, nextP.col);
                if (!pWin) {
                    plateau[pos.row][pos.col] = 'C';
                } else {
                    plateau[pos.row][pos.col] = '.';
                    testVictoire();
                }
            }
        } else if (getPos(nextP) == '.') {
            setPosition(nextP.row, nextP.col);
        }
    }

    public void display() {
        for (int row = 0; row < plateau.length; row++) {
            String line = "";
            for (int col = 0; col < plateau[0].length; col++) {
                line += plateau[row][col];               
            }
            System.out.println(line);
        }

    }
}
