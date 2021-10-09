/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Touti;

import java.sql.*;



public class ConnexionDBM {
    Connection con = null;
    public static Connection connexion(String user, String pass) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/toutiop",user,pass);
                        if (con != null)
        System.out.println("connexion établie");
                        else 
        System.out.println("problème de connexion àla base");
                        
        return con;
        } catch (Exception e) {
            //TODO: handle exception
            System.out.println("Impossible de se connecter !");
            return null;
        }
    
    }
}
