package dao;

import model.Import;
import model.Product;
import model.Inventory;
import model.Supplier;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImportDAO extends DBContext {

    public ArrayList<Import> getListImport() {
        ArrayList<Import> data = new ArrayList<>();
        String sql = "SELECT * FROM Import";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int importID = rs.getInt("ImportID");
                int productID = rs.getInt("ProductID");
                int inventoryID = rs.getInt("InventoryID");
                Date importDate = rs.getDate("ImportDate");
                double unitCost = rs.getDouble("UnitCost");
                int quantity = rs.getInt("Quantity");
                String supplierName = rs.getString("SupplierName");
                data.add(new Import(importID, productID, inventoryID, importDate, unitCost, quantity, supplierName));
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
                return new Import(
                    rs.getInt("ImportID"),
                    rs.getInt("ProductID"),
                    rs.getInt("InventoryID"),
                    rs.getDate("ImportDate"),
                    rs.getDouble("UnitCost"),
                    rs.getInt("Quantity"),
                    rs.getString("SupplierName")
                );
            }
        } catch (SQLException e) {
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
            e.printStackTrace();
        }
        return products;
    }

public List<Inventory> getAllInventories() {
    List<Inventory> inventories = new ArrayList<>();
    String sql = "SELECT InventoryID, WarehouseName FROM Inventory"; // Thay WarehouseName bằng cột thực tế nếu cần
    try (PreparedStatement st = connection.prepareStatement(sql);
         ResultSet rs = st.executeQuery()) {
        while (rs.next()) {
            Inventory inventory = new Inventory();
            inventory.setInventoryID(rs.getInt("InventoryID")); // Giả sử bạn có setter cho inventoryID
            inventory.setWarehouseName(rs.getString("WarehouseName")); // Nếu có getter và setter cho WarehouseName
            inventories.add(inventory);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return inventories;
}

public List<Supplier> getAllSuppliers() {
    List<Supplier> suppliers = new ArrayList<>();
    String sql = "SELECT SupplierID, SupplierName FROM Supplier"; // Chỉnh sửa nếu có cột khác bạn muốn
    try (PreparedStatement st = connection.prepareStatement(sql);
         ResultSet rs = st.executeQuery()) {
        while (rs.next()) {
            Supplier supplier = new Supplier();
            supplier.setSupplierID(rs.getInt("SupplierID")); // Giả sử bạn có setter cho SupplierID
            supplier.setSupplierName(rs.getString("SupplierName")); // Nếu có getter và setter cho SupplierName
            suppliers.add(supplier);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return suppliers;
}


    
    
    
    
    
    
    
    
}
