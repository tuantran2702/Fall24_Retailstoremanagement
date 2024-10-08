/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Role;

/**
 *
 * @author ptrung
 */
public class RoleDAO extends DBContext{
    public List<Role> getAllRole(){
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT * FROM [Role]";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {                
                Role r = new Role();
                r.setRoleID(rs.getInt("RoleID"));
                r.setRoleName(rs.getString("RoleName"));
                r.setDescription(rs.getString("Description"));
                
                roles.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roles;
    }
    
    public String getRoleByID(String id){
        List<Role> lst = new ArrayList<>();
        lst = getAllRole();
        for(Role r : lst){
            if(r.getRoleID() == Integer.parseInt(id)){
                return r.getRoleName();
            }
        }
        return "Don't have RoleID: " + id;
    }
    
    public static void main(String[] args) {
        RoleDAO rd = new RoleDAO();
        List<Role> rr = rd.getAllRole();
        for (Role r : rr){
            System.out.println(r);
        }
    }
}
