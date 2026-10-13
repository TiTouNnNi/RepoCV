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
public class Administrator {

    public static boolean keep = true;
    public static DBHandler db = new DBHandler();
    
    public static void main(String[] args) {
        Runtime.getRuntime().addShutdownHook(new Thread(){
            public void run() {
                Administrator.db.close();
            }
        });
        while (keep) {
            menu();      
            char action = choix();
            
            switch (action) {
                case '1' :
                    db.init(input("A quelle DB se connecter ?"));
                    break;
                case '2' :
                    String sql = "";
                    db.execute(sql);
                    break;
                case '3':
                    String sql = "";
                    db.execute(sql);
                    break;
                case '4':
                    break;
                case '5':
                    break;
                case '6':
                    keep = false;
                    break;
                default:
                    break;
            }
        }
    }

    public static String input(String msg) {
        System.out.println(msg);
        Scanner choix = new Scanner(System.in);
        return choix.nextLine().trim();
    }

    public static char choix() {
        Scanner choix = new Scanner(System.in);
        return choix.next().trim().charAt(0);
    }

    public static void menu() {
        System.out.println("ADMINISTRATION INTERFACE - USE WITH CAUTION\n"
                + "1. Create new database\n"
                + "2. List boards\n"
                + "3. Show board\n"
                + "4. Add board from file\n"
                + "5. Remove board from database [DANGEROUS]\n"
                + "6. Quit.");
    }
}
