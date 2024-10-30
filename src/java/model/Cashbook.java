package model;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class Cashbook {
    private int transactionID;
    private Timestamp transactionDate;
    private String description;
    private BigDecimal amount;
    private String transactionType;
    private BigDecimal balance;
    private BigDecimal initialBalance; // Thuộc tính mới
    private Integer orderID;
    private Integer importID;

    public Cashbook() {
    }

    public Cashbook(int transactionID, Timestamp transactionDate, String description, 
                   BigDecimal amount, String transactionType, BigDecimal balance, 
                   BigDecimal initialBalance, Integer orderID, Integer importID) {
        this.transactionID = transactionID;
        this.transactionDate = transactionDate;
        this.description = description;
        this.amount = amount;
        this.transactionType = transactionType;
        this.balance = balance;
        this.initialBalance = initialBalance; // Gán giá trị cho thuộc tính mới
        this.orderID = orderID;
        this.importID = importID;
    }

    public int getTransactionID() {
        return transactionID;
    }

    public void setTransactionID(int transactionID) {
        this.transactionID = transactionID;
    }

    public Timestamp getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Timestamp transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public BigDecimal getInitialBalance() {
        return initialBalance;
    }

    public void setInitialBalance(BigDecimal initialBalance) {
        this.initialBalance = initialBalance;
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
