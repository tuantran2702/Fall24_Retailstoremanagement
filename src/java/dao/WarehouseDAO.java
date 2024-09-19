package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Warehouse;

public class WarehouseDAO extends DBContext {

    public ArrayList<Warehouse> getListWarehouse() {
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

    public Warehouse getWarehouseById(int id) {
        String sql = "SELECT * FROM Warehouse WHERE WarehouseID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String warehouseName = rs.getString("WarehouseName");
                String location = rs.getString("Location");
                String managerName = rs.getString("ManagerName");
                String contactNumber = rs.getString("ContactNumber");

                return new Warehouse(id, warehouseName, location, managerName, contactNumber);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createWarehouse(Warehouse warehouse) {
        String sql = "INSERT INTO Warehouse (WarehouseName, Location, ManagerName, ContactNumber) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, warehouse.getWarehouseName());
            st.setString(2, warehouse.getLocation());
            st.setString(3, warehouse.getManagerName());
            st.setString(4, warehouse.getContactNumber());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateWarehouse(Warehouse warehouse) {
        String sql = "UPDATE Warehouse SET WarehouseName = ?, Location = ?, ManagerName = ?, ContactNumber = ? WHERE WarehouseID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, warehouse.getWarehouseName());
            st.setString(2, warehouse.getLocation());
            st.setString(3, warehouse.getManagerName());
            st.setString(4, warehouse.getContactNumber());
            st.setInt(5, warehouse.getWarehouseID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

 public void deleteWarehouse(int id) {
    String sql = "DELETE FROM Warehouse WHERE WarehouseID = ?";
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        int affectedRows = st.executeUpdate(); // Số lượng dòng bị ảnh hưởng
        if (affectedRows > 0) {
            System.out.println("Xóa thành công kho hàng với ID: " + id);
        } else {
            System.out.println("Không tìm thấy kho hàng với ID: " + id);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

}
