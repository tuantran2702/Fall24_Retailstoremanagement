package model;

import java.util.Date;

public class Sales {
    private int saleID;
    private Date saleDate;
    private double totalAmount;
    private Integer customerID;
    private String customerFullName;

    // Constructors, getters, and setters
    public Sales() {}

    public Sales(int saleID, Date saleDate, double totalAmount, Integer customerID) {
        this.saleID = saleID;
        this.saleDate = saleDate;
        this.totalAmount = totalAmount;
        this.customerID = customerID;
    }

    public int getSaleID() {
        return saleID;
    }

    public void setSaleID(int saleID) {
        this.saleID = saleID;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Integer getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Integer customerID) {
        this.customerID = customerID;
    }
    // Getter và setter cho customerFullName
    public String getCustomerFullName() {
        return customerFullName;
    }

    public void setCustomerFullName(String customerFullName) {
        this.customerFullName = customerFullName;
    }
}
