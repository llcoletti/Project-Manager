/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entities.User;
import enums.Profile;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import apoio.DBConnection;

public class UserDAO {
    public boolean save(User u) {
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            String sql = "";
            
            if (u.getId() == 0) {
                sql 
                        = "insert into usuario values ("
                        + "default,"
                        + "'" + u.getName() + "',"
                        + "'" + u.getEmail() + "',"
                        + "'" + u.getPassword() + "',"
                        + "'" + u.getProfile().getName()+ "')";
                System.out.println("SQL: " + sql);
            } else {
                sql
                        = "update usuario "
                        + "set nome = '" + u.getName() + "', "
                        + "email = '" + u.getEmail() + "', "
                        + "senha = '" + u.getPassword()+ "', "
                        + "perfil = '" + u.getProfile().getName()+ "' "
                        + "where id = " + u.getId();
                System.out.println("SQL: " + sql);
            }
            
            int result = st.executeUpdate(sql);
            
            return true;
        } catch (Exception e) {
            System.out.println("Erro ao salvar usuário: " + e);
            return false;
        }
    }
    
    public ArrayList<User> findAll() {
        ArrayList<User> uList = new ArrayList();
        
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "select * "
                    + "from usuario "
                    + "order by id";
                    
            System.out.println("SQL: " + sql);

            ResultSet result = st.executeQuery(sql);
            
            while (result.next()) {
                User u = new User();
                u.setId(result.getInt("id"));
                u.setName(result.getString("nome"));
                u.setEmail(result.getString("email"));
                u.setPassword(result.getString("senha"));
                u.setProfile(Profile.get(result.getString("perfil")));                
                uList.add(u);
            }
        } catch (Exception e) {
            System.out.println("Erro ao consultar usuários: " + e);
        }
        
        return uList;
    }
    
    public User findById(int id){
        
        User u = null;
        
        try {            
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "select * "
                    + "from usuario "
                    + "where id = " + id;
                    
            System.out.println("SQL: " + sql);
            
            ResultSet result = st.executeQuery(sql);
            
            while(result.next()){
                u = new User();
                u.setId(result.getInt("id"));
                u.setName(result.getString("nome"));
                u.setEmail(result.getString("email"));
                u.setPassword(result.getString("senha"));
                u.setProfile(Profile.get(result.getString("perfil")));                
            }

            
        } catch(Exception e) {
            System.out.println("Erro ao consultar usuário: " + e);
        }
      
        return u;
    }
    
    public boolean delete(int id) {
                
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "delete from usuario "
                    + "where id = " + id;
                    
            System.out.println("SQL: " + sql);

            int result = st.executeUpdate(sql);
            
            return true;
        
        } catch(Exception e) {
            System.out.println("Erro ao excluir usuário: " + e);
            return false;
        }
        
    }
}
