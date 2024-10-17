package dao;

import model.Import;
import model.Product;
import model.Inventory;
import model.Supplier;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;


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
            data.add(new Import(importID, productID, productName, inventoryID, importDate, unitCost, quantity, totalCost, supplierName));
        }
    } catch (SQLException e) {
        System.out.println("Error retrieving imports: " + e.getMessage());
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
                return new Import(
                    rs.getInt("ImportID"),
                    rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                    rs.getInt("InventoryID"),
                    rs.getDate("ImportDate"),
                    rs.getDouble("UnitCost"),
                    rs.getInt("Quantity"),
                    rs.getDouble("TotalCost"),
                    rs.getString("SupplierName")    
                );
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving import by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public void createImport(Import imp) {
        String sql = "INSERT INTO Import (ProductID, InventoryID, ImportDate, UnitCost, Quantity, SupplierName) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, imp.getProductID());
            st.setInt(2, imp.getInventoryID());
            st.setDate(3, new java.sql.Date(imp.getImportDate().getTime()));
            st.setDouble(4, imp.getUnitCost());
            st.setInt(5, imp.getQuantity());
            st.setString(6, imp.getSupplierName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error creating import: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void updateImport(Import imp) {
        String sql = "UPDATE Import SET ProductID = ?, InventoryID = ?, ImportDate = ?, UnitCost = ?, Quantity = ?, SupplierName = ? WHERE ImportID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, imp.getProductID());
            st.setInt(2, imp.getInventoryID());
            st.setDate(3, new java.sql.Date(imp.getImportDate().getTime()));
            st.setDouble(4, imp.getUnitCost());
            st.setInt(5, imp.getQuantity());
            st.setString(6, imp.getSupplierName());
            st.setInt(7, imp.getImportID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating import: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deleteImport(int id) {
        String sql = "DELETE FROM Import WHERE ImportID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting import: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT ProductID, ProductName FROM Product";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                products.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving products: " + e.getMessage());
            e.printStackTrace();
        }
        return products;
    }

    public List<Inventory> getAllInventories() {
        List<Inventory> inventories = new ArrayList<>();
        String sql = "SELECT i.InventoryID, i.ProductID, i.WarehouseID, w.WarehouseName FROM Inventory i JOIN Warehouse w ON i.WarehouseID = w.WarehouseID";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Inventory inventory = new Inventory();
                inventory.setInventoryID(rs.getInt("InventoryID"));
                inventory.setProductID(rs.getInt("ProductID"));
                inventory.setWarehouseID(rs.getInt("WarehouseID"));
                inventory.setWarehouseName(rs.getString("WarehouseName"));
                inventories.add(inventory);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving inventories: " + e.getMessage());
            e.printStackTrace();
        }
        return inventories;
    }

    public List<Supplier> getAllSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT SupplierID, SupplierName FROM Supplier";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierID(rs.getInt("SupplierID"));
                supplier.setSupplierName(rs.getString("SupplierName"));
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving suppliers: " + e.getMessage());
            e.printStackTrace();
        }
        return suppliers;
    }

    public boolean isInventoryExist(int inventoryID) {
        String sql = "SELECT COUNT(*) FROM Inventory WHERE InventoryID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, inventoryID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error checking inventory existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public String getProductNameById(int productID) {
        String sql = "SELECT ProductName FROM Product WHERE ProductID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, productID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("ProductName");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving product name: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean isProductInInventory(int productID, int inventoryID) {
        String sql = "SELECT COUNT(*) FROM Inventory WHERE ProductID = ? AND InventoryID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, productID);
            st.setInt(2, inventoryID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error checking product in inventory: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}