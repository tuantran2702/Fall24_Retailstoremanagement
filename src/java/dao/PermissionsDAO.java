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
    
    public boolean updatePermission(Permissions permission) {
        String query = "UPDATE [dbo].[Permissions] SET PermissionName = ? WHERE PermissionID = ?";
        boolean rowUpdated = false;

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            // Thiết lập giá trị cho câu lệnh PreparedStatement
            statement.setString(1, permission.getPermissionName());
            statement.setInt(2, permission.getId());

            // Thực thi câu lệnh cập nhật và kiểm tra số hàng bị ảnh hưởng
            rowUpdated = statement.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
    
    public boolean deletePermission(int permissionID) {
        String query = "DELETE FROM Permission WHERE PermissionID = ?";
        boolean rowDeleted = false;

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            // Thiết lập giá trị cho câu lệnh PreparedStatement
            statement.setInt(1, permissionID);

            // Thực thi câu lệnh xóa và kiểm tra số hàng bị ảnh hưởng
            rowDeleted = statement.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowDeleted;
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
    
    public Permissions getPermissionById(int permissionID) {
        Permissions permission = null;
        String query = "SELECT * FROM [dbo].[Permissions] WHERE PermissionID = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, permissionID);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String permissionName = resultSet.getString("permissionName");

                permission = new Permissions(id, permissionName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return permission;
    }

    public static void main(String[] args) {
        PermissionsDAO pd = new PermissionsDAO();
        
        System.out.println(pd.getPermissionById(3));
        

    }
}