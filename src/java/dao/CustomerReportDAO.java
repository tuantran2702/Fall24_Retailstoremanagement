package dao;

import model.CustomerReport;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerReportDAO extends DBContext {

    // Get a list of all customer reports
    public ArrayList<CustomerReport> getListCustomerReports() {
    ArrayList<CustomerReport> data = new ArrayList<>();
    String sql = "SELECT cr.*, c.FirstName, c.LastName FROM CustomerReport cr " +
                 "JOIN Customer c ON cr.CustomerID = c.CustomerID"; // JOIN với bảng Customer
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            int reportID = rs.getInt("ReportID");
            int customerID = rs.getInt("CustomerID");
            String firstName = rs.getString("FirstName");
            String lastName = rs.getString("LastName");
            String customerName = firstName + " " + lastName; // Kết hợp FirstName và LastName
            java.time.LocalDateTime reportDate = rs.getTimestamp("ReportDate").toLocalDateTime();
            int totalOrders = rs.getInt("TotalOrders");
            double totalSpent = rs.getDouble("TotalSpent");
            int loyaltyPointsEarned = rs.getInt("LoyaltyPointsEarned");
            int loyaltyPointsRedeemed = rs.getInt("LoyaltyPointsRedeemed");
            String mostPurchasedProduct = rs.getString("MostPurchasedProduct");

            // Tạo đối tượng CustomerReport với customerName
            CustomerReport report = new CustomerReport(reportID, customerID, customerName, reportDate, 
                                                        totalOrders, totalSpent, loyaltyPointsEarned, 
                                                        loyaltyPointsRedeemed, mostPurchasedProduct);
            data.add(report);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return data;
}

    // Create a new customer report
    public void createCustomerReport(CustomerReport report) {
        String sql = "INSERT INTO CustomerReport (CustomerID, ReportDate, TotalOrders, TotalSpent, LoyaltyPointsEarned, LoyaltyPointsRedeemed, MostPurchasedProduct) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, report.getCustomerID());
            st.setTimestamp(2, java.sql.Timestamp.valueOf(report.getReportDate()));
            st.setInt(3, report.getTotalOrders());
            st.setDouble(4, report.getTotalSpent());
            st.setInt(5, report.getLoyaltyPointsEarned());
            st.setInt(6, report.getLoyaltyPointsRedeemed());
            st.setString(7, report.getMostPurchasedProduct());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a report by ID
    public void deleteReport(int id) {
        String sql = "DELETE FROM CustomerReport WHERE ReportID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}