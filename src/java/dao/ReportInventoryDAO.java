/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Category;
import model.Product;
import model.ReportInventory;
import model.Supplier;
import model.Unit;
import model.User;
import model.Warehouse;
import org.apache.tomcat.dbcp.dbcp2.PStmtKey;

/**
 *
 * @author admin
 */
public class ReportInventoryDAO extends DBContext {

    public List<ReportInventory> getlistReportInventory() {
        List<ReportInventory> data = new ArrayList<>();
        String sql = " SELECT \n"
                + "  r.*,\n"
                + "  p.ProductName,\n"
                + "  w.WarehouseName\n"
                + "FROM \n"
                + "    [RetailStoreDatabase1].[dbo].[ReportInventory] r\n"
                + "JOIN \n"
                + "    [RetailStoreDatabase1].[dbo].[Product] p ON r.ProductID = p.ProductID\n"
                + "JOIN \n"
                + "    [RetailStoreDatabase1].[dbo].[Warehouse] w ON r.WarehouseID = w.WarehouseID;"; // Thay đổi tên bảng nếu cần
        try ( Statement stmt = connection.createStatement();  ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                // Giả sử bạn có các cột tương ứng trong bảng
                int id = rs.getInt("reportID");
                Date reportDate = rs.getDate("reportDate");
                int productID = rs.getInt("productID");
                int warehouseID = rs.getInt("warehouseID");
                int totalQuantity = rs.getInt("totalQuantity");
                double totalStockValue = rs.getDouble("totalStockValue");
                String productName = rs.getString("productName");
                String warehouseName = rs.getString("warehouseName");

                ReportInventory report = new ReportInventory(productID, reportDate, productID, warehouseID, totalQuantity, totalStockValue, productName, warehouseName);
                data.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    public List<ReportInventory> searchReportInventories(String keyword, Date startDate, Date endDate, Integer productID, Integer warehouseID) {
        List<ReportInventory> filteredReports = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT r.*, p.ProductName, w.WarehouseName FROM [RetailStoreDatabase1].[dbo].[ReportInventory] r "
                + "JOIN [RetailStoreDatabase1].[dbo].[Product] p ON r.ProductID = p.ProductID "
                + "JOIN [RetailStoreDatabase1].[dbo].[Warehouse] w ON r.WarehouseID = w.WarehouseID WHERE 1=1");

        // Kiểm tra nếu keyword không rỗng
        if (keyword != null && !keyword.isEmpty()) {
            query.append(" AND (");
            query.append(" p.ProductName LIKE ? OR");
            query.append(" w.WarehouseName LIKE ?");
            query.append(")");
        }

        // Kiểm tra nếu startDate không rỗng
        if (startDate != null) {
            query.append(" AND r.reportDate >= ?");
        }

        // Kiểm tra nếu endDate không rỗng
        if (endDate != null) {
            query.append(" AND r.reportDate <= ?");
        }

        // Kiểm tra nếu productID không rỗng
        if (productID != null) {
            query.append(" AND r.productID = ?");
        }

        // Kiểm tra nếu warehouseID không rỗng
        if (warehouseID != null) {
            query.append(" AND r.warehouseID = ?");
        }

        try ( PreparedStatement pstmt = connection.prepareStatement(query.toString())) {
            int index = 1;

            // Nếu keyword không rỗng, thêm vào PreparedStatement
            if (keyword != null && !keyword.isEmpty()) {
                String likeKeyword = "%" + keyword + "%";
                pstmt.setString(index++, likeKeyword);
                pstmt.setString(index++, likeKeyword);
            }

            // Nếu startDate không rỗng, thêm vào PreparedStatement
            if (startDate != null) {
                pstmt.setDate(index++, new java.sql.Date(startDate.getTime()));
            }

            // Nếu endDate không rỗng, thêm vào PreparedStatement
            if (endDate != null) {
                pstmt.setDate(index++, new java.sql.Date(endDate.getTime()));
            }

            // Nếu productID không rỗng, thêm vào PreparedStatement
            if (productID != null) {
                pstmt.setInt(index++, productID);
            }

            // Nếu warehouseID không rỗng, thêm vào PreparedStatement
            if (warehouseID != null) {
                pstmt.setInt(index++, warehouseID);
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int reportIDValue = rs.getInt("reportID");
                Date reportDate = rs.getDate("reportDate");
                int productIDValue = rs.getInt("productID");
                int warehouseIDValue = rs.getInt("warehouseID");
                int totalQuantity = rs.getInt("totalQuantity");
                double totalStockValue = rs.getDouble("totalStockValue");
                String productName = rs.getString("ProductName");
                String warehouseName = rs.getString("WarehouseName");

                ReportInventory report = new ReportInventory(reportIDValue, reportDate, productIDValue, warehouseIDValue, totalQuantity, totalStockValue, productName, warehouseName);
                filteredReports.add(report);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return filteredReports;
    }

    public ReportInventory getReportById(int id) {
        ReportInventory report = null;
        String sql = "SELECT * FROM [dbo].[ReportInventory] WHERE ReportID = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try ( ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Giả sử bạn có các cột tương ứng trong bảng
                    Date reportDate = rs.getDate("reportDate");
                    int productID = rs.getInt("productID");
                    int warehouseID = rs.getInt("warehouseID");
                    int totalQuantity = rs.getInt("totalQuantity");
                    double totalStockValue = rs.getDouble("totalStockValue");

                    report = new ReportInventory(id, reportDate, productID, warehouseID, totalQuantity, totalStockValue);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return report;
    }

    public void createReport(ReportInventory report) {
        String sql = "INSERT INTO [dbo].[ReportInventory] (ReportDate, ProductID, WarehouseID, TotalQuantity, TotalStockValue) VALUES (?, ?, ?, ?, ?)";
        try ( PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setDate(1, new java.sql.Date(report.getReportDate().getTime()));
            pstmt.setInt(2, report.getProductID());
            pstmt.setInt(3, report.getWarehouseID());
            pstmt.setInt(4, report.getTotalQuantity());
            pstmt.setDouble(5, report.getTotalStockValue());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateReport(ReportInventory report) {
        String sql = "UPDATE [dbo].[ReportInventory] SET ReportDate = ?, ProductID = ?, WarehouseID = ?, TotalQuantity = ?, TotalStockValue = ? WHERE ReportID = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setDate(1, new java.sql.Date(report.getReportDate().getTime()));
            pstmt.setInt(2, report.getProductID());
            pstmt.setInt(3, report.getWarehouseID());
            pstmt.setInt(4, report.getTotalQuantity());
            pstmt.setDouble(5, report.getTotalStockValue());
            pstmt.setInt(6, report.getReportID());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ReportInventory getlistReportInventoryById(int id) {
                String sql = "select*from ReportInventory where ReportID= ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date reportDate = rs.getDate(2);
                int productID = rs.getInt(3);
                int warehouseID = rs.getInt(4);
                int totalQuantity = rs.getInt(5);
                double totalStockValue = rs.getDouble(6);

                return new ReportInventory(productID, reportDate, productID, warehouseID, totalQuantity, totalStockValue);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteReportInventory(int id) {
        String sql = "DELETE FROM [dbo].[ReportInventory]\n" +
"      WHERE ReportID = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public ArrayList<Product> GetListProduct() {
        ArrayList<Product> products = new ArrayList<>();
        String sql = "select p.*,c.CategoryName from Product p join Category c on p.CategoryID=c.CategoryID";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt(1);
                String productCode = rs.getString(2);
                String productName = rs.getString(3);
                int categoryID = rs.getInt(4);
                double price = rs.getDouble(5);
                int quantity = rs.getInt(6);
                String description = rs.getString(7);
                Date createdDate = rs.getDate(8);
                Date expiredDate = rs.getDate(9);
                Date updateDate = rs.getDate(10);
                String image = rs.getString(11);
                int userID = rs.getInt(12);
                int unitID = rs.getInt(13);
                int supplierID = rs.getInt(14);
                String categoryName = rs.getString(15);

                products.add(new Product(productID, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID, categoryName));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;


    }

    public ArrayList<Warehouse> GetListWarehouse() {
        ArrayList<Warehouse> data = new ArrayList<>();
        String sql = "SELECT * FROM Warehouse";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int warehouseID = rs.getInt("WarehouseID");
                String warehouseName = rs.getString("WarehouseName");
                String location = rs.getString("Location");
                String managerName = rs.getString("ManagerName");
                String contactNumber = rs.getString("ContactNumber");

                data.add(new Warehouse(warehouseID, warehouseName, location, managerName, contactNumber));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;

    }

    public void updateReportInventory(ReportInventory reportInventory) {
        
        String sql = "UPDATE ReportInventory SET"
                + " ReportDate = ?,"
                + " ProductID = ?,"
                + " WarehouseID = ?,"
                + " TotalQuantity = ?,"
                + " TotalStockValue = ? WHERE ReportID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setDate(1, new java.sql.Date(reportInventory.getReportDate().getTime()));
            stmt.setInt(2, reportInventory.getProductID());
            stmt.setInt(3, reportInventory.getWarehouseID());
            stmt.setInt(4, reportInventory.getTotalQuantity());
            stmt.setDouble(5, reportInventory.getTotalStockValue());
            stmt.setInt(6, reportInventory.getReportID());

            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("insertFail:" + e.getMessage());
//            e.printStackTrace();
        }

    }

}
