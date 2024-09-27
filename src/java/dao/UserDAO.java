/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
                String img = rs.getString("Img");

                // Tạo đối tượng User
                user = new User(userId, firstName, lastName, email, password, phoneNumber, address, roleId, img);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;  // Trả về đối tượng User nếu đăng nhập đúng, ngược lại trả về null
    }
    
    public void addUser(User u){
        MaHoa mh = new MaHoa();
        String sql = "INSERT INTO [dbo].[User] ([FirstName], [LastName], [Email], [Password], [PhoneNumber], [Address], [RoleID]) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, u.getFirstName());
            st.setString(2, u.getLastName());
            st.setString(3, u.getEmail());
            st.setString(4, mh.md5Hash(u.getPassword()));
            st.setString(5, u.getPhoneNumber());
            st.setString(6, u.getAddress());
            st.setInt(7, u.getRoleID());
            st.setString(8, u.getImg());
            st.execute();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }
    
    public List<User> getAllUsers(){
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password")); // Có thể không cần thiết cho việc hiển thị
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddress(rs.getString("Address"));
                user.setRoleID(rs.getInt("RoleID"));
                user.setImg(rs.getString("Img"));
                // Thêm các thuộc tính khác nếu cần thiết
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public static void main(String[] args) {
        UserDAO ud = new UserDAO();
        
        
        List<User> lst = ud.getAllUsers();
        for (User user : lst) {
            System.out.println(user); // In thông tin người dùng ra console
        }
        
    }
}
