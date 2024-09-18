/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import model.User;

/**
 *
 * @author ptrung
 */
public class UserDAO extends DBContext{
    
    public User checkLogin(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM [User] WHERE Email = ? AND Password = ?";
        try {
            // Chuẩn bị truy vấn
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);      // Gán giá trị email vào câu lệnh SQL
            st.setString(2, password);   // Gán giá trị password vào câu lệnh SQL
            
            // Thực thi truy vấn
            ResultSet rs = st.executeQuery();

            // Nếu có dữ liệu, tạo đối tượng User
            if (rs.next()) {
                int userId = rs.getInt("UserID");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String phoneNumber = rs.getString("PhoneNumber");
                String address = rs.getString("Address");
                int roleId = rs.getInt("RoleID");

                // Tạo đối tượng User
                user = new User(userId, firstName, lastName, email, password, phoneNumber, address, roleId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;  // Trả về đối tượng User nếu đăng nhập đúng, ngược lại trả về null
    }
}
