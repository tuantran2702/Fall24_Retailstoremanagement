package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import model.Import;

public class ImportDAO extends DBContext {

    public ArrayList<Import> getListImport() {
        ArrayList<Import> data = new ArrayList<>();
        String sql = "SELECT i.*, p.ProductName FROM Import i JOIN Product p ON i.ProductID = p.ProductID";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int importID = rs.getInt("ImportID");
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                int inventoryID = rs.getInt("InventoryID");
                Date importDate = rs.getDate("ImportDate");
                double unitCost = rs.getDouble("UnitCost");
                int quantity = rs.getInt("Quantity");
                double totalCost = rs.getDouble("TotalCost");
                String supplierName = rs.getString("SupplierName");

                Import importItem = new Import(importID, productID, inventoryID, importDate, unitCost, quantity, totalCost, supplierName, productName);
                data.add(importItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    public Import getImportById(int id) {
        String sql = "SELECT * FROM Import WHERE ImportID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                int inventoryID = rs.getInt("InventoryID");
                Date importDate = rs.getDate("ImportDate");
                double unitCost = rs.getDouble("UnitCost");
                int quantity = rs.getInt("Quantity");
                double totalCost = rs.getDouble("TotalCost");
                String supplierName = rs.getString("SupplierName");

                return new Import(id, productID, inventoryID, importDate, unitCost, quantity, totalCost, supplierName, productName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createImport(Import importItem) {
        String sql = "INSERT INTO Import (ProductID, InventoryID, ImportDate, UnitCost, Quantity, TotalCost, SupplierName, ProductName) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, importItem.getProductID());
            st.setInt(2, importItem.getInventoryID());
            st.setDate(3, new java.sql.Date(importItem.getImportDate().getTime()));
            st.setDouble(4, importItem.getUnitCost());
            st.setInt(5, importItem.getQuantity());
            st.setDouble(6, importItem.getTotalCost());
            st.setString(7, importItem.getSupplierName());
            st.setString(8, importItem.getProductName());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

   public void updateImport(Import importItem) {
    String sql = "UPDATE Import SET UnitCost = ?, Quantity = ?, TotalCost = ?, SupplierName = ? WHERE ImportID = ?";
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setDouble(1, importItem.getUnitCost());
        st.setInt(2, importItem.getQuantity());
        st.setDouble(3, importItem.getTotalCost());
        st.setString(4, importItem.getSupplierName());
        st.setInt(5, importItem.getImportID());
        st.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    public void deleteImport(int id) {
        String sql = "DELETE FROM Import WHERE ImportID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Import> searchImports(String searchTerm) {
        ArrayList<Import> data = new ArrayList<>();
        String sql = "SELECT * FROM Import WHERE ProductName LIKE ? OR SupplierName LIKE ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            String searchPattern = "%" + searchTerm + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int importID = rs.getInt("ImportID");
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                int inventoryID = rs.getInt("InventoryID");
                Date importDate = rs.getDate("ImportDate");
                double unitCost = rs.getDouble("UnitCost");
                int quantity = rs.getInt("Quantity");
                double totalCost = rs.getDouble("TotalCost");
                String supplierName = rs.getString("SupplierName");

                Import importItem = new Import(importID, productID, inventoryID, importDate, unitCost, quantity, totalCost, supplierName, productName);
                data.add(importItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
}
