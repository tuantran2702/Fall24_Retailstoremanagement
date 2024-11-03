package dao;

import model.CustomerRank;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerRankDAO extends DBContext {

    // Get a list of all customer ranks
    public ArrayList<CustomerRank> getListCustomerRank() {
        ArrayList<CustomerRank> data = new ArrayList<>();
        String sql = "SELECT * FROM CustomerRank";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int rankID = rs.getInt("RankID");
                String rankName = rs.getString("RankName");
                double minimumSpent = rs.getDouble("MinimumSpent");
                String description = rs.getString("Description");
                double discountPercent = rs.getDouble("DiscountPercent");  // Lấy discountPercent

                CustomerRank customerRank = new CustomerRank(rankID, rankName, minimumSpent, description, discountPercent);
                data.add(customerRank);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    // Get a single customer rank by ID
    public CustomerRank getCustomerRankById(int id) {
        String sql = "SELECT * FROM CustomerRank WHERE RankID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int rankID = rs.getInt("RankID");
                String rankName = rs.getString("RankName");
                double minimumSpent = rs.getDouble("MinimumSpent");
                String description = rs.getString("Description");
                double discountPercent = rs.getDouble("DiscountPercent");  // Lấy discountPercent

                return new CustomerRank(rankID, rankName, minimumSpent, description, discountPercent);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create a new customer rank
    public void createCustomerRank(CustomerRank customerRank) {
        String sql = "INSERT INTO CustomerRank (RankName, MinimumSpent, Description, DiscountPercent) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, customerRank.getRankName());
            st.setDouble(2, customerRank.getMinimumSpent());
            st.setString(3, customerRank.getDescription());
            st.setDouble(4, customerRank.getDiscountPercent());  // DiscountPercent
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update an existing customer rank
    public void updateCustomerRank(CustomerRank customerRank) {
        String sql = "UPDATE CustomerRank SET RankName = ?, MinimumSpent = ?, Description = ?, DiscountPercent = ? WHERE RankID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, customerRank.getRankName());
            st.setDouble(2, customerRank.getMinimumSpent());
            st.setString(3, customerRank.getDescription());
            st.setDouble(4, customerRank.getDiscountPercent());  // DiscountPercent
            st.setInt(5, customerRank.getRankID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a customer rank by ID
    public void deleteCustomerRank(int id) {
        String sql = "DELETE FROM CustomerRank WHERE RankID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete all customer ranks
    public void deleteAllCustomerRanks() {
        String sql = "DELETE FROM CustomerRank"; // Câu lệnh SQL để xóa tất cả
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    // Get filtered customer ranks by name

    public ArrayList<CustomerRank> getFilteredCustomerRanks(String rankName) {
        ArrayList<CustomerRank> data = new ArrayList<>();
        String sql = "SELECT * FROM CustomerRank WHERE 1=1"; // Base query

        if (rankName != null && !rankName.isEmpty()) {
            sql += " AND RankName LIKE ?";
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int paramIndex = 1;

            if (rankName != null && !rankName.isEmpty()) {
                st.setString(paramIndex++, "%" + rankName + "%");
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int rankID = rs.getInt("RankID");
                String rName = rs.getString("RankName");
                double minimumSpent = rs.getDouble("MinimumSpent");
                String description = rs.getString("Description");
                double discountPercent = rs.getDouble("DiscountPercent");

                CustomerRank customerRank = new CustomerRank(rankID, rName, minimumSpent, description, discountPercent);
                data.add(customerRank);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }
}
