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
            int affectedRows = st.executeUpdate();
            if (affectedRows > 0) {
                System.out.println("Successfully deleted inventory with ID: " + id);
            } else {
                System.out.println("Inventory with ID: " + id + " not found");
            }
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
        String sql = "SELECT i.InventoryID, i.ProductID, p.ProductName, i.WarehouseID, w.WarehouseName, i.Quantity " +
                     "FROM Inventory i " +
                     "JOIN Product p ON i.ProductID = p.ProductID " +
                     "JOIN Warehouse w ON i.WarehouseID = w.WarehouseID " +
                     "WHERE w.WarehouseName LIKE ? OR p.ProductName LIKE ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                data.add(createInventoryFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
    
    
    
}
