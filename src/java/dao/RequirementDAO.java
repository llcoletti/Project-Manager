/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entities.Requirement;
import enums.Classification;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import apoio.DBConnection;

public class RequirementDAO {
    public boolean save(Requirement r) {
        System.out.println("Entrou save");
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            String sql = "";
            
            if (r.getId() == 0) {
                
                System.out.println("proejctId: " +r.getProjectId());
                System.out.println("name " + r.getName());
                System.out.println("desc " + r.getDescription());
                System.out.println("vers" +r.getVersion());
                sql 
                        = "insert into requisito values ("
                        + "default,"
                        + "'" + r.getProjectId()+ "',"
                        + "'" + r.getName() + "',"
                        + "'" + r.getDescription() + "',"
                        + "'" + r.getVersion()+ "')";
                System.out.println("SQL: " + sql);
            } else {
                sql
                        = "update requisito "
                        + "set id_projeto = '" + r.getProjectId()+ "', "
                        + "nome = '" + r.getName() + "', "
                        + "descricao = '" + r.getDescription()+ "', "
                        + "versao = '" + r.getVersion()+ "', "
                        + "where id = " + r.getId();
                System.out.println("SQL: " + sql);
            }
            
            System.out.println("pré query");
            int result = st.executeUpdate(sql);
            System.out.println("pós query");
            
            return true;
        } catch (Exception e) {
            System.out.println("Erro ao salvar requisito: " + e);
            return false;
        }
    }
    
    public ArrayList<Requirement> findAll() {
        ArrayList<Requirement> rList = new ArrayList();
        
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "select * "
                    + "from requisito "
                    + "order by id";
                    
            System.out.println("SQL: " + sql);

            ResultSet result = st.executeQuery(sql);
            
            while (result.next()) {
                Requirement r = new Requirement();
                r.setId(result.getInt("id"));
                r.setProjectId(result.getInt("id_projeto"));
                r.setName(result.getString("nome"));
                r.setDescription(result.getString("descricao"));
                r.setVersion(result.getString("versao"));
                rList.add(r);
            }
        } catch (Exception e) {
            System.out.println("Erro ao consultar requisitos: " + e);
        }
        
        return rList;
    }
    
    public Requirement findById(int id){
        
        Requirement r = null;
        
        try {            
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "select * "
                    + "from requisito "
                    + "where id = " + id;
                    
            System.out.println("SQL: " + sql);
            
            ResultSet result = st.executeQuery(sql);
            
            while(result.next()){
                r = new Requirement();
                r.setId(result.getInt("id"));
                r.setProjectId(result.getInt("id_projeto"));
                r.setName(result.getString("nome"));
                r.setDescription(result.getString("descricao"));
                r.setVersion(result.getString("versao"));
            }

            
        } catch(Exception e) {
            System.out.println("Erro ao consultar requisito: " + e);
        }
      
        return r;
    }
    
    public boolean delete(int id) {
                
        try {
            Statement st = DBConnection.getInstance().getConnection().createStatement();
            
            String sql 
                    = "delete from requisito "
                    + "where id = " + id;
                    
            System.out.println("SQL: " + sql);

            int result = st.executeUpdate(sql);
            
            return true;
        
        } catch(Exception e) {
            System.out.println("Erro ao excluir requisito: " + e);
            return false;
        }
        
    }
}
