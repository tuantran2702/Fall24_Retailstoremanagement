package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Category;

public class CategoryDAO extends DBContext {

    // Lấy danh sách tất cả các Category
    public ArrayList<Category> getListCategory() {
        ArrayList<Category> data = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int categoryID = rs.getInt("CategoryID");
                String categoryName = rs.getString("CategoryName");
                String description = rs.getString("Description");

                data.add(new Category(categoryID, categoryName, description));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    // Lấy thông tin chi tiết của một Category theo ID
    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM Category WHERE CategoryID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String categoryName = rs.getString("CategoryName");
                String description = rs.getString("Description");

                return new Category(id, categoryName, description);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tạo mới một Category
    public void createCategory(Category category) {
        String sql = "INSERT INTO Category (CategoryName, Description) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, category.getCategoryName());
            st.setString(2, category.getDescription());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật thông tin Category
    public void updateCategory(Category category) {
        String sql = "UPDATE Category SET CategoryName = ?, Description = ? WHERE CategoryID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, category.getCategoryName());
            st.setString(2, category.getDescription());
            st.setInt(3, category.getCategoryID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa Category theo ID
    public void deleteCategory(int id) {
        // Cập nhật bảng Product, đặt SupplierID về NULL cho các sản phẩm có SupplierID là nhà cung cấp đang bị xóa
        String updateProductSql = "UPDATE [dbo].[Product] SET CategoryID = NULL WHERE CategoryID = ?";

        String deleteCategorySql = "DELETE FROM Category WHERE CategoryID = ?";
        try {
            // Bắt đầu cập nhật bảng Product
            PreparedStatement updateProductSt = connection.prepareStatement(updateProductSql);
            updateProductSt.setInt(1, id);
            updateProductSt.executeUpdate();

            // Sau đó xóa nhà cung cấp
            PreparedStatement deleteCategorySt = connection.prepareStatement(deleteCategorySql);
            deleteCategorySt.setInt(1, id);
            deleteCategorySt.executeUpdate();

        } catch (Exception e) {
            System.out.println("DeleteFail:" + e.getMessage());
        }
    }

    public void addCategoryName(Category category) {
        String sql = "INSERT INTO Category (CategoryName) VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, category.getCategoryName());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}