package model;

import java.util.Date;

public class Voucher {
    private int voucherID;
    private Integer discountID; // Using Integer for nullable values
    private Integer orderID; // Using Integer for nullable values
    private String voucherCode;
    private Date expirationDate;

    // Constructors, getters, and setters
    public Voucher() {}

    public Voucher(int voucherID, Integer discountID, Integer orderID, String voucherCode, Date expirationDate) {
        this.voucherID = voucherID;
        this.discountID = discountID;
        this.orderID = orderID;
        this.voucherCode = voucherCode;
        this.expirationDate = expirationDate;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public Integer getDiscountID() {
        return discountID;
    }

    public void setDiscountID(Integer discountID) {
        this.discountID = discountID;
    }

    public Integer getOrderID() {
        return orderID;
    }

    public void setOrderID(Integer orderID) {
        this.orderID = orderID;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }
}
