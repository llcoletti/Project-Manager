/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entities.User;
import enums.Profile;
import java.sql.ResultSet;
import java.sql.Statement;
import apoio.DBConnection;


public class AuthenticationDAO {
    public User auth(User user){
        
        User u = null;
        
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "select * from usuario "
                    + "where email='"+user.getEmail()+"' "
                    + "and senha='"+user.getPassword()+"'";
                    
            System.out.println("SQL: " + sql);
            
            ResultSet result = st.executeQuery(sql);
            
            if (result.next()) {
                u = new User();
                u.setId(result.getInt("id"));
                u.setName(result.getString("nome"));
                u.setEmail(result.getString("email"));
                u.setPassword(result.getString("senha"));
                u.setProfile(Profile.get(result.getString("perfil")));
                System.out.println("Login feito com sucesso!");
            }            
        } catch(Exception e) {
            System.out.println("Erro ao buscar usuario: " + e);
        }
        
        return u;        
    }
}
