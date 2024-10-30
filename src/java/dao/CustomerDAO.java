package dao;

import model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerDAO extends DBContext {

    // Get a list of all customers with RankName and CurrentPoint
    public ArrayList<Customer> getListCustomers() {
        ArrayList<Customer> data = new ArrayList<>();
        String sql = "SELECT c.*, r.RankName, c.CurrentPoint FROM Customer c JOIN CustomerRank r ON c.RankID = r.RankID";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int customerID = rs.getInt("CustomerID");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String email = rs.getString("Email");
                String phoneNumber = rs.getString("PhoneNumber");
                double totalSpent = rs.getDouble("TotalSpent");
                String address = rs.getString("Address");
                int rankID = rs.getInt("RankID");
                String rankName = rs.getString("RankName"); // Get RankName
                int currentPoint = rs.getInt("CurrentPoint"); // Get CurrentPoint

                Customer customer = new Customer(customerID, firstName, lastName, email, phoneNumber, totalSpent, address, rankID, rankName, currentPoint);
                data.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    // Get a single customer by ID with RankName and CurrentPoint
    public Customer getCustomerById(int id) {
        String sql = "SELECT c.*, r.RankName, c.CurrentPoint FROM Customer c JOIN CustomerRank r ON c.RankID = r.RankID WHERE CustomerID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int customerID = rs.getInt("CustomerID");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String email = rs.getString("Email");
                String phoneNumber = rs.getString("PhoneNumber");
                double totalSpent = rs.getDouble("TotalSpent");
                String address = rs.getString("Address");
                int rankID = rs.getInt("RankID");
                String rankName = rs.getString("RankName"); // Get RankName
                int currentPoint = rs.getInt("CurrentPoint"); // Get CurrentPoint

                return new Customer(customerID, firstName, lastName, email, phoneNumber, totalSpent, address, rankID, rankName, currentPoint);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create a new customer
    public void createCustomer(Customer customer) {
        String sql = "INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber, TotalSpent, Address, RankID, CurrentPoint) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, customer.getFirstName());
            st.setString(2, customer.getLastName());
            st.setString(3, customer.getEmail());
            st.setString(4, customer.getPhoneNumber());
            st.setDouble(5, customer.getTotalSpent());
            st.setString(6, customer.getAddress());
            st.setInt(7, customer.getRankID());
            st.setInt(8, customer.getCurrentPoint()); // Set CurrentPoint
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update an existing customer including CurrentPoint
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE Customer SET FirstName = ?, LastName = ?, Email = ?, PhoneNumber = ?, Address = ?, CurrentPoint = ? WHERE CustomerID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, customer.getFirstName());
            st.setString(2, customer.getLastName());
            st.setString(3, customer.getEmail());
            st.setString(4, customer.getPhoneNumber());
            st.setString(5, customer.getAddress());
            st.setInt(6, customer.getCurrentPoint()); // Update CurrentPoint
            st.setInt(7, customer.getCustomerID());

            int rowsAffected = st.executeUpdate(); // Get the number of affected rows
            return rowsAffected > 0; // Return true if any row is updated
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false on error
        }
    }

    // Delete a customer by ID
    public void deleteCustomer(int id) {
        String sql = "DELETE FROM Customer WHERE CustomerID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
