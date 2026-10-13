/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sokoban;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
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
            conn = DriverManager.getConnection(url+dbName);
            String sql = "CREATE TABLE IF NOT EXISTS boards (\n"
                + "	board_id text PRIMARY KEY,\n"
                + "	name text NOT NULL,\n"
                + "	nb_rows integer NOT NULL\n"
                + "	nb_cols integer NOT NULL\n"
                + ");"
                    + "CREATE TABLE IF NOT EXISTS boards (\n"
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
        try (Statement stmt = conn.createStatement()) {
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
}
