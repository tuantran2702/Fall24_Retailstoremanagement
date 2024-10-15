/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Permissions;
import model.Role;

/**
 *
 * @author ptrung
 */
public class PermissionsDAO extends DBContext{
    public List<String> getPermissions() {
        
        List<String> permissions = new ArrayList<>();
        
        String sql = "SELECT permission_name FROM [Permissions]";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                permissions.add(rs.getString(2));
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return permissions;
    }
    
    // Lấy tất cả các quyền hạn
    public List<Permissions> getAllPermissions() {
        List<Permissions> permissions = new ArrayList<>();
        String sql = "SELECT id, permission_name FROM Permissions";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
             
            while (rs.next()) {
                Permissions permission = new Permissions();
                permission.setId(rs.getInt(1));
                permission.setPermissionName(rs.getString(2));
                permissions.add(permission);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return permissions;
    }

    // Lấy các quyền hạn đã gán cho vai trò
    public List<String> getAssignedPermissionsForRole(int roleID) {
        List<String> assignedPermissions = new ArrayList<>();
        String sql = "SELECT permission_id FROM RolePermissions WHERE role_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roleID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                assignedPermissions.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return assignedPermissions;
    }
    
    public void clearPermissionsForRole(int roleID) {
        String sql = "DELETE FROM [dbo].[RolePermissions] WHERE role_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, roleID);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void assignPermissionToRole(int roleID, int permissionID) {
        String sql = "INSERT INTO [dbo].[RolePermissions] (role_id, permission_id) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, roleID);
            st.setInt(2, permissionID);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        PermissionsDAO pd = new PermissionsDAO();
        List<Permissions> lst = pd.getAllPermissions();
        List<String> lstlst = pd.getAssignedPermissionsForRole(1);
        for (String p : lstlst){
            System.out.println(p);
        }
    }
}
