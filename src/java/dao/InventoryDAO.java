package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Inventory;
import model.Product;
import model.Warehouse;
public class InventoryDAO extends DBContext {

    public ArrayList<Inventory> getListInventory() {
        ArrayList<Inventory> data = new ArrayList<>();
        String sql = "SELECT i.InventoryID, i.ProductID, p.ProductName, i.WarehouseID, w.WarehouseName, i.Quantity, i.LastUpdated " +
                     "FROM Inventory i " +
                     "JOIN Product p ON i.ProductID = p.ProductID " +
                     "JOIN Warehouse w ON i.WarehouseID = w.WarehouseID";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                int inventoryID = rs.getInt("InventoryID");
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                int warehouseID = rs.getInt("WarehouseID");
                String warehouseName = rs.getString("WarehouseName");
                int quantity = rs.getInt("Quantity");
                Date lastUpdated = rs.getTimestamp("LastUpdated");

                data.add(new Inventory(inventoryID, productID, warehouseID, quantity, lastUpdated, productName, warehouseName));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
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

    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        String sql = "SELECT WarehouseID, WarehouseName FROM Warehouse";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Warehouse warehouse = new Warehouse();
                warehouse.setWarehouseID(rs.getInt("WarehouseID"));
                warehouse.setWarehouseName(rs.getString("WarehouseName"));
                warehouses.add(warehouse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return warehouses;
    }

    public Inventory getInventoryById(int id) {
        String sql = "SELECT i.InventoryID, i.ProductID, p.ProductName, i.WarehouseID, w.WarehouseName, i.Quantity, i.LastUpdated " +
                     "FROM Inventory i " +
                     "JOIN Product p ON i.ProductID = p.ProductID " +
                     "JOIN Warehouse w ON i.WarehouseID = w.WarehouseID " +
                     "WHERE i.InventoryID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return createInventoryFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createInventory(Inventory inventory) {
        String sql = "INSERT INTO Inventory (ProductID, WarehouseID, Quantity, LastUpdated) VALUES (?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, inventory.getProductID());
            st.setInt(2, inventory.getWarehouseID());
            st.setInt(3, inventory.getQuantity());
            st.setTimestamp(4, new java.sql.Timestamp(inventory.getLastUpdated().getTime()));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateInventory(Inventory inventory) {
        String sql = "UPDATE Inventory SET Quantity = ?, LastUpdated = ? WHERE InventoryID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, inventory.getQuantity());
            st.setTimestamp(2, new java.sql.Timestamp(inventory.getLastUpdated().getTime()));
            st.setInt(3, inventory.getInventoryID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    
    
   public void deleteInventory(int id) {
    String sql = "DELETE FROM Inventory WHERE InventoryID = ?";
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setInt(1, id);
        // Xóa mà không cần kiểm tra ảnh hưởng hay thông báo
        st.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    private Inventory createInventoryFromResultSet(ResultSet rs) throws SQLException {
        int inventoryID = rs.getInt("InventoryID");
        int productID = rs.getInt("ProductID");
        String productName = rs.getString("ProductName");
        int warehouseID = rs.getInt("WarehouseID");
        String warehouseName = rs.getString("WarehouseName");
        int quantity = rs.getInt("Quantity");
        Date lastUpdated = rs.getTimestamp("LastUpdated");
        return new Inventory(inventoryID, productID, warehouseID, quantity, lastUpdated, productName, warehouseName);
    }

   public ArrayList<Inventory> searchInventories(String searchTerm) {
    ArrayList<Inventory> data = new ArrayList<>();
    String sql = "SELECT i.InventoryID, i.ProductID, p.ProductName, i.WarehouseID, w.WarehouseName, i.Quantity, i.LastUpdated " +
                 "FROM Inventory i " +
                 "JOIN Product p ON i.ProductID = p.ProductID " +
                 "JOIN Warehouse w ON i.WarehouseID = w.WarehouseID " +
                 "WHERE LOWER(w.WarehouseName) LIKE LOWER(?) OR LOWER(p.ProductName) LIKE LOWER(?)";
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        String searchPattern = "%" + searchTerm + "%";
        st.setString(1, searchPattern);
        st.setString(2, searchPattern);
        try (ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                data.add(createInventoryFromResultSet(rs));
            }
        }
    } catch (SQLException e) {
        System.out.println("Error in searchInventories: " + e.getMessage());
        e.printStackTrace();
    }
    return data;

    }
   public void deleteAllInventories() {
    String sql = "DELETE FROM Inventory";
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        // Thực hiện câu lệnh xóa
        st.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    
  public boolean isProductAndWarehouseExist(int productID, int warehouseID) {
    String sql = "SELECT COUNT(*) FROM Inventory WHERE ProductID = ? AND WarehouseID = ?";
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setInt(1, productID);
        st.setInt(2, warehouseID);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            return count > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}  
    
}