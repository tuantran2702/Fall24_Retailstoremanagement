package model;

import java.util.Date;

public class Cashbook {
    private int transactionID;
    private Date transactionDate;
    private String description;
    private double amount;
    private String transactionType; // "Thu" or "Chi"
    private double balance;
    private Integer orderID;
    private Integer importID;

    // Constructors, getters, and setters
    public Cashbook() {}

    public Cashbook(int transactionID, Date transactionDate, String description, double amount, String transactionType, double balance, Integer orderID, Integer importID) {
        this.transactionID = transactionID;
        this.transactionDate = transactionDate;
        this.description = description;
        this.amount = amount;
        this.transactionType = transactionType;
        this.balance = balance;
        this.orderID = orderID;
        this.importID = importID;
    }

    public int getTransactionID() {
        return transactionID;
    }

    public void setTransactionID(int transactionID) {
        this.transactionID = transactionID;
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

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public Integer getOrderID() {
        return orderID;
    }

    public void setOrderID(Integer orderID) {
        this.orderID = orderID;
    }

    public Integer getImportID() {
        return importID;
    }

    public void setImportID(Integer importID) {
        this.importID = importID;
    }
}
