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
public class PermissionsDAO extends DBContext {
//    public List<String> getPermissionsName() {
//        
//        List<String> permissions = new ArrayList<>();
//        
//        String sql = "SELECT PermissionName FROM [Permissions]";
//
//        try {
//            PreparedStatement st = connection.prepareStatement(sql);
//            ResultSet rs = st.executeQuery();
//
//            while (rs.next()) {
//                permissions.add(rs.getString(2));
//            }
//            
//            
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return permissions;
//    }

    // Lấy tất cả các quyền hạn
    public List<Permissions> getAllPermissions() {
        List<Permissions> permissions = new ArrayList<>();
        String sql = "SELECT * FROM Permissions";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

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

    public boolean addPermission(String permissionName) {
        String sql = "INSERT INTO [dbo].[Permissions] ([PermissionName]) VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, permissionName);
            st.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy các quyền hạn đã gán cho vai trò
    public List<String> getAssignedPermissionsForRole(int roleID) {
        List<String> assignedPermissions = new ArrayList<>();
        //String sql = "SELECT Permission_id FROM RolePermissions WHERE Role_id = ?";
        String sql = "SELECT p.PermissionName\n"
                + "FROM RolePermissions rp\n"
                + "JOIN Permissions p ON rp.Permission_id = p.PermissionID\n"
                + "WHERE rp.Role_id = ?;";
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
        String sql = "DELETE FROM [dbo].[RolePermissions] WHERE Role_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, roleID);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void assignPermissionToRole(int roleID, int permissionID) {
        String sql = "INSERT INTO [dbo].[RolePermissions] (Role_id, Permission_id) VALUES (?, ?)";
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
        for (Permissions p : lst){
            System.out.println(p);
        }
        

    }
}