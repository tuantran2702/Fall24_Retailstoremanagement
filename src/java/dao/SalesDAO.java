package dao;

import model.Sales;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SalesDAO extends DBContext {

     // Lấy danh sách tất cả các Sales, kèm theo FullName từ bảng Customer
    public ArrayList<Sales> getAllSalesWithCustomerName() {
        ArrayList<Sales> salesList = new ArrayList<>();
        // SQL JOIN để kết hợp bảng Sales và Customer, lấy cả FullName
        String sql = "SELECT s.saleID, s.saleDate, s.totalAmount, s.customerID, " +
                     "CONCAT(c.FirstName, ' ', c.LastName) AS FullName " +
                     "FROM Sales s " +
                     "JOIN Customer c ON s.customerID = c.CustomerID";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int saleID = rs.getInt("saleID");
                java.util.Date saleDate = rs.getDate("saleDate");
                double totalAmount = rs.getDouble("totalAmount");
                Integer customerID = rs.getInt("customerID");
                String fullName = rs.getString("FullName");

                Sales sale = new Sales(saleID, saleDate, totalAmount, customerID);
                sale.setCustomerFullName(fullName); // Gán tên đầy đủ cho Sale
                salesList.add(sale);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesList;
    }
    
    
    
    // Lấy danh sách tất cả các Sales
    public ArrayList<Sales> getAllSales() {
        ArrayList<Sales> salesList = new ArrayList<>();
        String sql = "SELECT * FROM Sales";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int saleID = rs.getInt("saleID");
                java.util.Date saleDate = rs.getDate("saleDate");
                double totalAmount = rs.getDouble("totalAmount");
                Integer customerID = rs.getInt("customerID");
                
                Sales sale = new Sales(saleID, saleDate, totalAmount, customerID);
                salesList.add(sale);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesList;
    }
    
    // Phương thức lấy danh sách Sales theo điều kiện lọc (customerID và saleDate)
    public ArrayList<Sales> getFilteredSales(String customerName, String saleDate) {
        ArrayList<Sales> salesList = new ArrayList<>();

        // Tạo SQL cơ bản với điều kiện tìm kiếm
        StringBuilder sql = new StringBuilder("SELECT s.saleID, s.saleDate, s.totalAmount, s.customerID, ");
        sql.append("CONCAT(c.FirstName, ' ', c.LastName) AS FullName ");
        sql.append("FROM Sales s ");
        sql.append("JOIN Customer c ON s.customerID = c.CustomerID ");
        sql.append("WHERE 1=1 "); // Điều kiện luôn đúng để thêm các điều kiện khác

        // Bổ sung điều kiện lọc theo customerName
        if (customerName != null && !customerName.isEmpty()) {
            sql.append("AND CONCAT(c.FirstName, ' ', c.LastName) LIKE ? ");
        }
        // Bổ sung điều kiện lọc theo saleDate
        if (saleDate != null && !saleDate.isEmpty()) {
            sql.append("AND s.saleDate = ? ");
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            // Set customerName nếu có
            if (customerName != null && !customerName.isEmpty()) {
                st.setString(paramIndex++, "%" + customerName + "%"); // Sử dụng LIKE để tìm kiếm theo tên khách hàng
            }

            // Set saleDate nếu có
            if (saleDate != null && !saleDate.isEmpty()) {
                st.setDate(paramIndex++, Date.valueOf(saleDate)); // Chuyển đổi chuỗi ngày thành kiểu java.sql.Date
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int saleID = rs.getInt("saleID");
                java.util.Date saleDateResult = rs.getDate("saleDate");
                double totalAmount = rs.getDouble("totalAmount");
                Integer customerIDResult = rs.getInt("customerID");
                String fullName = rs.getString("FullName");

                // Tạo đối tượng Sale và thêm vào danh sách
                Sales sale = new Sales(saleID, saleDateResult, totalAmount, customerIDResult);
                sale.setCustomerFullName(fullName); // Gán tên khách hàng vào đối tượng Sale
                salesList.add(sale);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesList;
    }

    // Thêm mới một Sale
    public void addSale(Sales sale) {
        String sql = "INSERT INTO Sales (saleDate, totalAmount, customerID) VALUES (?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDate(1, new java.sql.Date(sale.getSaleDate().getTime()));
            st.setDouble(2, sale.getTotalAmount());
            st.setInt(3, sale.getCustomerID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy một Sale theo ID
    public Sales getSaleById(int saleID) {
        String sql = "SELECT * FROM Sales WHERE saleID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, saleID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                java.util.Date saleDate = rs.getDate("saleDate");
                double totalAmount = rs.getDouble("totalAmount");
                Integer customerID = rs.getInt("customerID");

                return new Sales(saleID, saleDate, totalAmount, customerID);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật một Sale
    public void updateSale(Sales sale) {
        String sql = "UPDATE Sales SET saleDate = ?, totalAmount = ?, customerID = ? WHERE saleID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDate(1, new java.sql.Date(sale.getSaleDate().getTime()));
            st.setDouble(2, sale.getTotalAmount());
            st.setInt(3, sale.getCustomerID());
            st.setInt(4, sale.getSaleID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa một Sale
    public void deleteSale(int saleID) {
        String sql = "DELETE FROM Sales WHERE saleID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, saleID);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
