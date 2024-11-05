package model;

import java.time.LocalDateTime;

public class CustomerReport {
    private int reportID;
    private int customerID;
    private String customerName; // Thay đổi này sẽ được cập nhật
    private LocalDateTime reportDate;
    private int totalOrders;
    private double totalSpent;
    private int loyaltyPointsEarned;
    private int loyaltyPointsRedeemed;
    private String mostPurchasedProduct;

    // Constructor, getters and setters
    public CustomerReport() {}

    public CustomerReport(int reportID, int customerID, String customerName, LocalDateTime reportDate,
                          int totalOrders, double totalSpent, int loyaltyPointsEarned,
                          int loyaltyPointsRedeemed, String mostPurchasedProduct) {
        this.reportID = reportID;
        this.customerID = customerID;
        this.customerName = customerName; // Vẫn giữ trường này để hiển thị tên khách hàng
        this.reportDate = reportDate;
        this.totalOrders = totalOrders;
        this.totalSpent = totalSpent;
        this.loyaltyPointsEarned = loyaltyPointsEarned;
        this.loyaltyPointsRedeemed = loyaltyPointsRedeemed;
        this.mostPurchasedProduct = mostPurchasedProduct;
    }

    // Getters and Setters
    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public LocalDateTime getReportDate() {
        return reportDate;
    }

    public void setReportDate(LocalDateTime reportDate) {
        this.reportDate = reportDate;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public double getTotalSpent() {
        return totalSpent;
    }

    public void setTotalSpent(double totalSpent) {
        this.totalSpent = totalSpent;
    }

    public int getLoyaltyPointsEarned() {
        return loyaltyPointsEarned;
    }

    public void setLoyaltyPointsEarned(int loyaltyPointsEarned) {
        this.loyaltyPointsEarned = loyaltyPointsEarned;
    }

    public int getLoyaltyPointsRedeemed() {
        return loyaltyPointsRedeemed;
    }

    public void setLoyaltyPointsRedeemed(int loyaltyPointsRedeemed) {
        this.loyaltyPointsRedeemed = loyaltyPointsRedeemed;
    }

    public String getMostPurchasedProduct() {
        return mostPurchasedProduct;
    }

    public void setMostPurchasedProduct(String mostPurchasedProduct) {
        this.mostPurchasedProduct = mostPurchasedProduct;
    }
}