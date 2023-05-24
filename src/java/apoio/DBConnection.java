/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package apoio;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;


public class DBConnection {
    private static DBConnection instance = null;
    private Connection connection = null;
    
    public DBConnection() {
        try {
            Properties prop = new Properties();
            prop.load(getClass().getClassLoader().getResourceAsStream("apoio/db.properties"));
            String dbDriver = prop.getProperty("db.driver");
            String dbUrl = prop.getProperty("db.url");
            String dbUser = prop.getProperty("db.user");
            String dbPassword = prop.getProperty("db.password");
            
            Class.forName(dbDriver);
            
            if (dbUser.length() != 0) {
                connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            } else {
                connection = DriverManager.getConnection(dbUrl);
            }
        } catch (Exception e) {
            System.err.println(e);
        }
    }
    
    public static DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }
    
    public Connection getConnection() {
        if (connection == null) {
            throw new RuntimeException("connection==null");
        }
        return connection;
    }
    
    public void shutDown() {
        try {
            connection.close();
            instance = null;
            connection = null;
        } catch (Exception e) {
            System.err.println(e);
        }
    }
}
