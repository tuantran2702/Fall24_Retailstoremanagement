package model;

import java.util.Date;

public class Payment {
    private int paymentID;
    private int orderID;
    private Date paymentDate;
    private double amount;
    private int paymentMethodID;

    // Constructors, getters, and setters
    public Payment() {}

    public Payment(int paymentID, int orderID, Date paymentDate, double amount, int paymentMethodID) {
        this.paymentID = paymentID;
        this.orderID = orderID;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.paymentMethodID = paymentMethodID;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public int getPaymentMethodID() {
        return paymentMethodID;
    }

    public void setPaymentMethodID(int paymentMethodID) {
        this.paymentMethodID = paymentMethodID;
    }
}
