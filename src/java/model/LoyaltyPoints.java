package model;

import java.util.Date;

public class LoyaltyPoints {
    private int loyaltyPointID;
    private int customerID;
    private int pointsEarned;
    private int pointsRedeemed;
    private Date transactionDate;
    private String description;
    private String customerName; 
    // Constructors, getters, and setters
    public LoyaltyPoints() {}

    public LoyaltyPoints(int loyaltyPointID, int customerID, int pointsEarned, int pointsRedeemed, Date transactionDate, String description) {
        this.loyaltyPointID = loyaltyPointID;
        this.customerID = customerID;
        this.pointsEarned = pointsEarned;
        this.pointsRedeemed = pointsRedeemed;
        this.transactionDate = transactionDate;
        this.description = description;
    }

    public int getLoyaltyPointID() {
        return loyaltyPointID;
    }

    public void setLoyaltyPointID(int loyaltyPointID) {
        this.loyaltyPointID = loyaltyPointID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getPointsEarned() {
        return pointsEarned;
    }

    public void setPointsEarned(int pointsEarned) {
        this.pointsEarned = pointsEarned;
    }

    public int getPointsRedeemed() {
        return pointsRedeemed;
    }

    public void setPointsRedeemed(int pointsRedeemed) {
        this.pointsRedeemed = pointsRedeemed;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
}