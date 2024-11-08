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
public class UserDAO extends DBContext {

    public User checkLogin(String email, String password) {
        MaHoa mh = new MaHoa();
        User user = null;
        String sql = "SELECT * FROM [User] WHERE Email = ? AND Password = ?";
        try {
            // Chuẩn bị truy vấn
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);      // Gán giá trị email vào câu lệnh SQL
            st.setString(2, mh.md5Hash(password));   // Gán giá trị password vào câu lệnh SQL

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

    public boolean updatePassword(User user, String newpass) {
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [Password] = ?\n"
                + " WHERE [UserID] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            // Set các giá trị từ đối tượng User vào PreparedStatement
            ps.setString(1, newpass);
            ps.setInt(2, user.getUserID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [FirstName] = ?\n"
                + "      ,[LastName] = ?\n"
                + "      ,[Email] = ?\n"
                + "      ,[PhoneNumber] = ?\n"
                + "      ,[Address] = ?\n"
                + "      ,[RoleID] = ?\n"
                + "      ,[Img] = ?\n"
                + " WHERE [UserID] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            // Set các giá trị từ đối tượng User vào PreparedStatement
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhoneNumber());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getRoleID());
            ps.setString(7, user.getImg());
            ps.setInt(8, user.getUserID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void addUser(User u) {
        MaHoa mh = new MaHoa();
        String sql = "INSERT INTO [dbo].[User] ([FirstName], [LastName], [Email], [Password], [PhoneNumber], [Address], [RoleID], [Img]) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement st = null;

        try {
            // Kiểm tra kết nối cơ sở dữ liệu
            if (connection != null && !connection.isClosed()) {
                st = connection.prepareStatement(sql);
                st.setString(1, u.getFirstName());
                st.setString(2, u.getLastName());
                st.setString(3, u.getEmail());

                // Kiểm tra và mã hóa mật khẩu
                String hashedPassword = mh.md5Hash(u.getPassword());
                st.setString(4, hashedPassword);
                st.setString(5, u.getPhoneNumber());
                st.setString(6, u.getAddress());
                st.setInt(7, u.getRoleID());
                st.setString(8, u.getImg());

                st.executeUpdate();
            } else {
                System.out.println("Connection is closed or null");
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ hợp lý hơn
            System.err.println("Error inserting user: " + e.getMessage());
            throw new RuntimeException("Error adding user to the database", e);
        } finally {
            // Đóng PreparedStatement sau khi sử dụng
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public boolean deleteUser(int userID) {
        // Các câu lệnh SQL xóa
        final String DELETE_REPORT_INVENTORY_SQL = "DELETE FROM [dbo].[ReportInventory] WHERE ProductID IN (SELECT ProductID FROM [dbo].[Product] WHERE UserID = ?)";
        final String DELETE_ORDER_DETAILS_SQL = "DELETE FROM [dbo].[OrderDetail] WHERE ProductID IN (SELECT ProductID FROM [dbo].[Product] WHERE UserID = ?)";
        final String DELETE_CASHBOOK_SQL = "DELETE FROM [dbo].[Cashbook] WHERE ImportID IN (SELECT ImportID FROM [dbo].[Import] WHERE ProductID IN (SELECT ProductID FROM [dbo].[Product] WHERE UserID = ?))";
        final String DELETE_VOUCHERS_SQL = "DELETE FROM [dbo].[Voucher] WHERE DiscountID IN (SELECT DiscountID FROM [dbo].[Discount] WHERE ProductID IN (SELECT ProductID FROM [dbo].[Product] WHERE UserID = ?))";
        final String DELETE_IMPORTS_SQL = "DELETE FROM [dbo].[Import] WHERE ProductID IN (SELECT ProductID FROM [dbo].[Product] WHERE UserID = ?)";
        final String DELETE_DISCOUNTS_SQL = "DELETE FROM [dbo].[Discount] WHERE ProductID IN (SELECT ProductID FROM [dbo].[Product] WHERE UserID = ?)";
        final String DELETE_INVENTORY_SQL = "DELETE FROM [dbo].[Inventory] WHERE ProductID IN (SELECT ProductID FROM [dbo].[Product] WHERE UserID = ?)";
        final String DELETE_PRODUCTS_SQL = "DELETE FROM [dbo].[Product] WHERE UserID = ?";
        final String DELETE_USER_SQL = "DELETE FROM [dbo].[User] WHERE UserID = ?";

        // Danh sách các câu lệnh và log thông báo
        String[] deleteQueries = {
            DELETE_REPORT_INVENTORY_SQL, DELETE_ORDER_DETAILS_SQL, DELETE_CASHBOOK_SQL,
            DELETE_VOUCHERS_SQL, DELETE_IMPORTS_SQL, DELETE_DISCOUNTS_SQL,
            DELETE_INVENTORY_SQL, DELETE_PRODUCTS_SQL, DELETE_USER_SQL
        };
        String[] logMessages = {
            "Report inventory đã xóa: ", "Order details đã xóa: ", "Cashbook đã xóa: ",
            "Voucher đã xóa: ", "Import đã xóa: ", "Discount đã xóa: ",
            "Inventory đã xóa: ", "Sản phẩm đã xóa: ", "Người dùng đã xóa: "
        };

        try {
            // Bắt đầu giao dịch
            connection.setAutoCommit(false);

            // Thực thi từng câu lệnh xóa theo thứ tự
            for (int i = 0; i < deleteQueries.length; i++) {
                try (PreparedStatement ps = connection.prepareStatement(deleteQueries[i])) {
                    ps.setInt(1, userID);
                    int deletedCount = ps.executeUpdate();
                    System.out.println(logMessages[i] + deletedCount);
                }
            }

            // Cam kết giao dịch
            connection.commit();
            System.out.println("Xóa người dùng và các dữ liệu liên quan thành công!");
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Xóa người dùng thất bại!");

            // Hoàn tác giao dịch khi có lỗi
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        }
        return false;
    }

    public List<User> getAllUsers() {
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

    public User getUserByEmail(String email) {
        User user = null;  // Khởi tạo user là null, sau này nếu tìm thấy sẽ tạo đối tượng mới
        String sql = "SELECT * FROM [User] WHERE Email = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);  // Gán giá trị email vào câu truy vấn

            ResultSet rs = st.executeQuery();

            if (rs.next()) {  // Nếu có bản ghi được tìm thấy
                user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setEmail(rs.getString("Email"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddress(rs.getString("Address"));
                user.setRoleID(rs.getInt("RoleID"));
                user.setImg(rs.getString("Img"));
                // Thêm các thuộc tính khác nếu cần thiết
            }
        } catch (Exception e) {
            e.printStackTrace();  // In lỗi nếu có
        }
        return user;  // Trả về đối tượng user, nếu không tìm thấy sẽ trả về null
    }

    public static void main(String[] args) {
        UserDAO ud = new UserDAO();

        ud.deleteUser(9);
    }

    public User getUserById(int id) {
        UserDAO ud = new UserDAO();
        List<User> lst = ud.getAllUsers();
        for (User user : lst) {
            if (user.getUserID() == id) {
                return user;
            }
        }
        return null;
    }
}