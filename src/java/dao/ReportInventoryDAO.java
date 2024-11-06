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
        StringBuilder query = new StringBuilder("SELECT r.*, p.ProductName, w.WarehouseName FROM [RetailStoreDatabase1].[dbo].[ReportInventory] r " +
                "JOIN [RetailStoreDatabase1].[dbo].[Product] p ON r.ProductID = p.ProductID " +
                "JOIN [RetailStoreDatabase1].[dbo].[Warehouse] w ON r.WarehouseID = w.WarehouseID WHERE 1=1");

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

        try (PreparedStatement pstmt = connection.prepareStatement(query.toString())) {
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

    public void deleteReport(int id) {
        String sql = "DELETE FROM [dbo].[ReportInventory] WHERE ReportID = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public ReportInventory getlistReportInventoryById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void deleteReportInventory(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
