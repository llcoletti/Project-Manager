/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entities.Project;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import apoio.DBConnection;


public class ProjectDAO {
    public boolean save(Project p) {
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            String sql = "";
            
            if (p.getId() == 0) {
                sql 
                        = "insert into projeto values ("
                        + "default,"
                        + "'" + p.getName() + "',"
                        + "'" + p.getDescription()+ "')";
                System.out.println("SQL: " + sql);
            } else {
                sql
                        = "update projeto "
                        + "set nome = '" + p.getName() + "', "
                        + "descricao = '" + p.getDescription()+ "' "
                        + "where id = " + p.getId();
                System.out.println("SQL: " + sql);
            }
            
            int result = st.executeUpdate(sql);
            
            return true;
        } catch (Exception e) {
            System.out.println("Erro ao salvar projeto: " + e);
            return false;
        }
    }
    
    public ArrayList<Project> findAll() {
        ArrayList<Project> pList = new ArrayList();
        
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "select * "
                    + "from projeto "
                    + "order by id";
                    
            System.out.println("SQL: " + sql);

            ResultSet result = st.executeQuery(sql);
            
            while (result.next()) {
                Project p = new Project();
                p.setId(result.getInt("id"));
                p.setName(result.getString("nome"));
                p.setDescription(result.getString("descricao"));
                pList.add(p);
            }
        } catch (Exception e) {
            System.out.println("Erro ao consultar projetos: " + e);
        }
        
        return pList;
    }
    
    public Project findById(int id){
        
        Project p = null;
        
        try {            
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "select * "
                    + "from projeto "
                    + "where id = " + id;
                    
            System.out.println("SQL: " + sql);
            
            ResultSet result = st.executeQuery(sql);
            
            while(result.next()){
                p = new Project();
                p.setId(result.getInt("id"));
                p.setName(result.getString("nome"));
                p.setDescription(result.getString("descricao"));
            }

            
        } catch(Exception e) {
            System.out.println("Erro ao consultar projeto: " + e);
        }
      
        return p;
    }
    
    public boolean delete(int id) {
                
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "delete from projeto "
                    + "where id = " + id;
                    
            System.out.println("SQL: " + sql);

            int result = st.executeUpdate(sql);
            
            return true;
        
        } catch(Exception e) {
            System.out.println("Erro ao excluir projeto: " + e);
            return false;
        }
        
    }
}
