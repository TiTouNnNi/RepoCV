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
public class Player {

    public static boolean ff15 = false;
    public static void play(Board p) {
        while (!ff15) {
            p.display();
            menu();      
            char action = choixJoueur();
            ff15 = actionPlayer(p, action);

            if (ff15) {
                System.out.println("Le joueur n'a pas de mental et abandonne la partie au bout de 15 minutes");
            } else if (p.getVictoire()) {
                p.display();
                System.out.println("Le joueur a gagné la partie, bien joué");
                break;
            }
        }
    }

    public static void menu() {       
        System.out.println("Choissisez une action ; U,D,L,R,Q");
    }

    public static char choixJoueur() {
        Scanner choix = new Scanner(System.in);
        return choix.next().trim().charAt(0);
    }

    public static boolean actionPlayer(Board p, char action) {
        boolean stop = false;
        switch (action) {
            case 'Q':
                stop = true;
                break;
            case 'U': 
            case 'L':
            case 'R':
            case 'D':
                p.déplacerJoueur(action);
                break;
            default:
                break;
        }
        return stop;
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        /*Board b = new Board("Hard-Coded Example", 5, 6);
        b.ajouterMurHorizontal(0, 0, 6);
        b.ajouterMurHorizontal(4, 0, 6);
        b.ajouterMurVertical(0, 0, 5);
        b.ajouterMurVertical(0, 5, 5);
        b.ajouterBoites(2, 1);
        b.ajouterBoites(2, 3);
        b.ajouterTrous(3, 1);
        b.ajouterTrous(3, 2);
        b.setPosition(3, 4);
        play(b);*/
        
        FileBoardBuilder builder = new FileBoardBuilder("Super");
        builder.read("F:/IUT INFO/S2/ProjetSOKOBAN/Tesmorts.txt");
        Board board = builder.build();
        play(board);
    }

}
