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

    public boolean addRole(String roleName, String description) {
        String sql = "INSERT INTO [dbo].[Role] ([RoleName], [Description]) VALUES (?, ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            // Gán giá trị cho các tham số trong câu lệnh SQL
            st.setString(1, roleName);
            st.setString(2, description);

            // Thực thi câu lệnh thêm và kiểm tra số dòng bị ảnh hưởng
            int rowsInserted = st.executeUpdate();

            // Nếu có ít nhất 1 dòng bị thêm thì trả về true, nghĩa là thêm thành công
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;  // Trả về false nếu xảy ra lỗi
        }
    }

    public boolean updateRole(Role r) {
        String sql = "UPDATE [Role] SET RoleName = ?, Description = ? WHERE RoleID = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            // Gán giá trị cho các tham số trong câu lệnh SQL
            st.setString(1, r.getRoleName());
            st.setString(2, r.getDescription());
            st.setInt(3, r.getRoleID());

            // Thực thi câu lệnh cập nhật và kiểm tra số dòng bị ảnh hưởng
            int rowsUpdated = st.executeUpdate();

            // Nếu có ít nhất 1 dòng bị ảnh hưởng thì trả về true, nghĩa là cập nhật thành công
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;  // Trả về false nếu xảy ra lỗi
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
            String sql = "SELECT * FROM Role WHERE roleID = ?";
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
        List<Role> rr = rd.getAllRole();
        for (Role r : rr) {
            System.out.println(r);
        }
    }
}
