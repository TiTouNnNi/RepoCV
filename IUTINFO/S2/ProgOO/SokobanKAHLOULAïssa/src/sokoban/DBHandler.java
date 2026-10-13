/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sokoban;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MOI
 */
public class DBHandler {

    public static String url = "jdbc:sqlite:F:/";
    public Connection conn = null;

    public void init(String dbName) {
        try {
            conn = DriverManager.getConnection(url + dbName);
            String sql = "CREATE TABLE IF NOT EXISTS boards (\n"
                    + "	board_id text PRIMARY KEY,\n"
                    + "	name text NOT NULL,\n"
                    + "	nb_rows integer NOT NULL,\n"
                    + "	nb_cols integer NOT NULL\n"
                    + ");"
                    + "CREATE TABLE IF NOT EXISTS rows (\n"
                    + "	board_id text PRIMARY KEY,\n"
                    + "	row_num integer NOT NULL,\n"
                    + "	description text NOT NULL\n"
                    + ");";
            execute(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void execute(String sql) {
        try ( Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DBHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void close() {
        try {
            if (conn != null) {
                conn.close();
                conn = null;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void listBoards(Connection c) throws SQLException {
        Statement statement = c.createStatement();
        ResultSet resultats = statement.executeQuery("select * from boards");
        while (resultats.next()) {
            int id = resultats.getInt("board_id");
            String name = resultats.getString("name");
            System.out.format("%d\t%s\n", id, name);
        }
    }

    public void addBoard(Connection c) throws SQLException {
        /* System.out.println("Comment s'appelle le plateau ?");
        Scanner nom = new Scanner(System.in);
        String name = nom.nextLine().trim();
        System.out.println("Quelle est la difficulté du plateau ?");
        Scanner difficulté = new Scanner(System.in);
        String difficulty = difficulté.nextLine().trim(); */

    }

    public void deleteBoard(Connection c) throws SQLException {
        System.out.println("Quelle plateau voulez vous supprimer ? "
                + "Écrivez le nom qui se situe dans la colonne board_id");
        Scanner nom = new Scanner(System.in);
        String toDelete = nom.nextLine().trim();
        execute("DELETE FROM `boards` " + "WHERE board_id = " + toDelete);       
    }
    
    public void showBoard(Connection c) throws SQLException {
        System.out.println("Quelle plateau voulez vous voir en détail ? "
                + "Écrivez le nom qui se situe dans la colonne board_id");
        Scanner nom = new Scanner(System.in);
        String toShow = nom.nextLine().trim();
        execute("SELECT * FROM ROWS "
                + "INNER JOIN BOARDS "
                + "ON Boards.board_id=Rows.board_id "
                + "WHERE board_id=" + toShow );       
    }
}
