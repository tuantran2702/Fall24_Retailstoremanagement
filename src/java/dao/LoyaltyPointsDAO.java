package dao;

import model.LoyaltyPoints;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class LoyaltyPointsDAO extends DBContext {

    // Get a list of all loyalty points
    public ArrayList<LoyaltyPoints> getListLoyaltyPoints() {
        ArrayList<LoyaltyPoints> data = new ArrayList<>();

        String sql = "SELECT lp.LoyaltyPointID, lp.CustomerID, " +
                     "CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, " +
                     "lp.PointsEarned, lp.PointsRedeemed, lp.TransactionDate, lp.Description " +
                     "FROM LoyaltyPoints lp " +
                     "JOIN Customer c ON lp.CustomerID = c.CustomerID";

        try (Connection conn = connection;
             PreparedStatement st = conn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                int loyaltyPointID = rs.getInt("LoyaltyPointID");
                int customerID = rs.getInt("CustomerID");
                String customerName = rs.getString("CustomerName");  // Lấy CustomerName
                int pointsEarned = rs.getInt("PointsEarned");
                int pointsRedeemed = rs.getInt("PointsRedeemed");
                Date transactionDate = rs.getDate("TransactionDate");
                String description = rs.getString("Description");

                // Khởi tạo đối tượng LoyaltyPoints
                LoyaltyPoints lp = new LoyaltyPoints(loyaltyPointID, customerID, pointsEarned, pointsRedeemed, transactionDate, description);
                lp.setCustomerName(customerName);  // Gán tên khách hàng
                data.add(lp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    // Get a single loyalty point entry by ID
    public LoyaltyPoints getLoyaltyPointsById(int id) {
        String sql = "SELECT * FROM LoyaltyPoints WHERE LoyaltyPointID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int loyaltyPointID = rs.getInt("LoyaltyPointID");
                int customerID = rs.getInt("CustomerID");
                int pointsEarned = rs.getInt("PointsEarned");
                int pointsRedeemed = rs.getInt("PointsRedeemed");
                Date transactionDate = rs.getDate("TransactionDate");
                String description = rs.getString("Description");

                return new LoyaltyPoints(
                    loyaltyPointID, customerID, pointsEarned, 
                    pointsRedeemed, transactionDate, description
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create a new loyalty points entry
    public void createLoyaltyPoints(LoyaltyPoints lp) {
        String sql = "INSERT INTO LoyaltyPoints (CustomerID, PointsEarned, PointsRedeemed, TransactionDate, Description) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lp.getCustomerID());
            st.setInt(2, lp.getPointsEarned());
            st.setInt(3, lp.getPointsRedeemed());
            st.setDate(4, new java.sql.Date(lp.getTransactionDate().getTime()));
            st.setString(5, lp.getDescription());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update an existing loyalty points entry
    public void updateLoyaltyPoints(LoyaltyPoints lp) {
        String sql = "UPDATE LoyaltyPoints SET CustomerID = ?, PointsEarned = ?, PointsRedeemed = ?, TransactionDate = ?, Description = ? WHERE LoyaltyPointID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lp.getCustomerID());
            st.setInt(2, lp.getPointsEarned());
            st.setInt(3, lp.getPointsRedeemed());
            st.setDate(4, new java.sql.Date(lp.getTransactionDate().getTime()));
            st.setString(5, lp.getDescription());
            st.setInt(6, lp.getLoyaltyPointID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a loyalty points entry by ID
    public void deleteLoyaltyPoints(int id) {
        String sql = "DELETE FROM LoyaltyPoints WHERE LoyaltyPointID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
