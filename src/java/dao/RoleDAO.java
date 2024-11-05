/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Permissions;
import model.Role;

/**
 *
 * @author ptrung
 */
public class RoleDAO extends DBContext {

    public List<Role> getAllRole() {
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

    public boolean addRole(String roleName, String description, String[] permissions) {
        String sqlRole = "INSERT INTO [dbo].[Role] ([RoleName], [Description]) VALUES (?, ?)";
        String sqlPermission = "INSERT INTO [dbo].[RolePermissions] (Role_id, Permission_id) VALUES (?, ?)";

        try (PreparedStatement stRole = connection.prepareStatement(sqlRole, Statement.RETURN_GENERATED_KEYS)) {
            // Bắt đầu một transaction
            connection.setAutoCommit(false);

            // Thực thi câu lệnh thêm vai trò
            stRole.setString(1, roleName);
            stRole.setString(2, description);
            int rowsInserted = stRole.executeUpdate();

            // Nếu thêm vai trò thành công
            if (rowsInserted > 0) {
                // Lấy ID của vai trò vừa thêm
                try (ResultSet generatedKeys = stRole.getGeneratedKeys()) {
                    int roleId = 0;
                    if (generatedKeys.next()) {
                        roleId = generatedKeys.getInt(1);
                    } else {
                        throw new Exception("Failed to retrieve role ID.");
                    }

                    // Thêm quyền vào bảng RolePermissions nếu có quyền hạn được chọn
                    if (permissions != null && permissions.length > 0) {
                        try (PreparedStatement stPermission = connection.prepareStatement(sqlPermission)) {
                            for (String permissionId : permissions) {
                                stPermission.setInt(1, roleId);
                                stPermission.setInt(2, Integer.parseInt(permissionId));
                                stPermission.addBatch();  // Thêm vào batch
                            }
                            stPermission.executeBatch(); // Thực thi batch
                        }
                    }

                    // Commit transaction nếu tất cả thao tác thành công
                    connection.commit();
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                // Rollback transaction nếu có lỗi
                connection.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                // Khôi phục lại trạng thái của AutoCommit
                connection.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return false; // Trả về false nếu thêm thất bại
    }

    public boolean updateRole(Role r, String[] permissions) {
        String updateRoleSQL = "UPDATE [Role] SET RoleName = ?, Description = ? WHERE RoleID = ?";
        String deletePermissionsSQL = "DELETE FROM [RolePermissions] WHERE Role_id = ?";
        String insertPermissionSQL = "INSERT INTO [RolePermissions] (Role_id, Permission_id) VALUES (?, ?)";

        PreparedStatement stUpdateRole = null;
        PreparedStatement stDeletePermissions = null;
        PreparedStatement stInsertPermission = null;

        try {

            // 1. Cập nhật vai trò trong bảng Role
            stUpdateRole = connection.prepareStatement(updateRoleSQL);
            stUpdateRole.setString(1, r.getRoleName());
            stUpdateRole.setString(2, r.getDescription());
            stUpdateRole.setInt(3, r.getRoleID());

            int rowsUpdated = stUpdateRole.executeUpdate();

            if (rowsUpdated == 0) {
                // Nếu không có dòng nào bị cập nhật, rollback và trả về false
                connection.rollback();
                return false;
            }

            // 2. Xóa tất cả quyền hiện tại của vai trò
            stDeletePermissions = connection.prepareStatement(deletePermissionsSQL);
            stDeletePermissions.setInt(1, r.getRoleID());
            stDeletePermissions.executeUpdate();

            // 3. Thêm lại các quyền hạn mới
            if (permissions != null) {
                stInsertPermission = connection.prepareStatement(insertPermissionSQL);
                for (String permissionID : permissions) {
                    stInsertPermission.setInt(1, r.getRoleID());
                    stInsertPermission.setInt(2, Integer.parseInt(permissionID));
                    stInsertPermission.addBatch(); // Tạo batch để thêm nhiều quyền cùng lúc
                }
                stInsertPermission.executeBatch(); // Thực hiện batch insert
            }

            // Nếu mọi thứ thành công, commit transaction
            connection.commit();
            return true;

        } catch (Exception e) {
            // Nếu xảy ra lỗi, rollback transaction
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            // Đảm bảo đóng các tài nguyên sau khi sử dụng
            try {
                if (stUpdateRole != null) {
                    stUpdateRole.close();
                }
                if (stDeletePermissions != null) {
                    stDeletePermissions.close();
                }
                if (stInsertPermission != null) {
                    stInsertPermission.close();
                }
                if (connection != null) {
                    connection.setAutoCommit(true); // Khôi phục auto-commit
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public boolean deleteRole(int id) {
        String sql = "DELETE FROM [Role] WHERE RoleID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            // Gán giá trị cho tham số trong câu lệnh SQL
            st.setInt(1, id);

            // Thực thi câu lệnh xóa và kiểm tra số dòng bị ảnh hưởng
            int rowsDeleted = st.executeUpdate();

            // Nếu có ít nhất 1 dòng bị xóa thì trả về true, nghĩa là xóa thành công
            return rowsDeleted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;  // Trả về false nếu xảy ra lỗi
        }
    }

    public Role getRoleByID(int roleID) {
        Role role = null;
        try {
            String sql = "SELECT * FROM Role WHERE RoleID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, roleID);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                role = new Role();
                role.setRoleID(rs.getInt(1));
                role.setRoleName(rs.getString(2));
                role.setDescription(rs.getString(3));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return role;
    }

    public static void main(String[] args) {
        RoleDAO rd = new RoleDAO();
        rd.addRole("ad", "adtest", new String[]{"1", "2"});
    }
}
