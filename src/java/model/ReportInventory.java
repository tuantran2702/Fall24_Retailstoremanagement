package model;

import java.util.Date;

public class ReportInventory {
    private int reportID;
    private int productID;
    private int warehouseID;
    private Date reportDate;
    private int totalQuantity;
    private double totalStockValue;

    // Constructors, getters, and setters
    public ReportInventory() {}

    public ReportInventory(int reportID, int productID, int warehouseID, Date reportDate, int totalQuantity, double totalStockValue) {
        this.reportID = reportID;
        this.productID = productID;
        this.warehouseID = warehouseID;
        this.reportDate = reportDate;
        this.totalQuantity = totalQuantity;
        this.totalStockValue = totalStockValue;
    }

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public double getTotalStockValue() {
        return totalStockValue;
    }

    public void setTotalStockValue(double totalStockValue) {
        this.totalStockValue = totalStockValue;
    }
}
