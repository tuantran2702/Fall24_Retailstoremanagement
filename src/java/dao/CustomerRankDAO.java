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

                CustomerRank customerRank = new CustomerRank(rankID, rankName, minimumSpent, description);
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

                return new CustomerRank(rankID, rankName, minimumSpent, description);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create a new customer rank
    public void createCustomerRank(CustomerRank customerRank) {
        String sql = "INSERT INTO CustomerRank (RankName, MinimumSpent, Description) VALUES (?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, customerRank.getRankName());
            st.setDouble(2, customerRank.getMinimumSpent());
            st.setString(3, customerRank.getDescription());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update an existing customer rank
    public void updateCustomerRank(CustomerRank customerRank) {
        String sql = "UPDATE CustomerRank SET RankName = ?, MinimumSpent = ?, Description = ? WHERE RankID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, customerRank.getRankName());
            st.setDouble(2, customerRank.getMinimumSpent());
            st.setString(3, customerRank.getDescription());
            st.setInt(4, customerRank.getRankID());
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
}
