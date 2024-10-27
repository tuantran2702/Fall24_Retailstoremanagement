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
import model.User;

/**
 *
 * @author ptrung
 */
public class PermissionsDAO extends DBContext {
/// Cập nhật quyền trong database

    public boolean updatePermission(Permissions permission) {
        
        String sql = "UPDATE Permissions SET PermissionName = ? WHERE PermissionID = ?";
        // Sử dụng try-with-resources để tự động đóng kết nối
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, permission.getPermissionName());
            st.setInt(2, permission.getId());
            st.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deletePermission(int id){
        String sql = "DELETE FROM [dbo].[Permissions] WHERE PermissionID = ?";
        // Sử dụng try-with-resources để tự động đóng kết nối
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Permissions getPermissionById(int id) {
        Permissions permission = new Permissions();
        String sql = "SELECT * FROM Permissions Where PermissionID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                permission.setId(rs.getInt(1));
                permission.setPermissionName(rs.getString(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return permission;
    }

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
    
    public boolean isAccess(User u, String s){
        List<String> lst = getAssignedPermissionsForRole(u.getRoleID());
        if(lst.contains(s)){
            return true;
        }
        return false;
    }

    public static void main(String[] args) {
        PermissionsDAO pd = new PermissionsDAO();
        Permissions p = pd.getPermissionById(6);
        System.out.println(p);

    }
}
