package model;

import java.util.Date;

public class ReportInventory {
    private int reportID;
    private Date reportDate;
    private int productID;
    private int warehouseID;
    private int totalQuantity;
    private double totalStockValue;
    private String productName;
    private String warehouseName;

    // Constructors
    public ReportInventory() {}

    public ReportInventory(int reportID, Date reportDate, int productID, int warehouseID, int totalQuantity, double totalStockValue, String productName, String warehouseName) {
        this.reportID = reportID;
        this.reportDate = reportDate;
        this.productID = productID;
        this.warehouseID = warehouseID;
        this.totalQuantity = totalQuantity;
        this.totalStockValue = totalStockValue;
        this.productName = productName;
        this.warehouseName = warehouseName;
    }

    // Getters and Setters
    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }
}