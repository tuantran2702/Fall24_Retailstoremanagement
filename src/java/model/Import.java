package model;

import java.util.Date;

public class Import {
    private int importID;
    private int productID;
    private String productName; // Thêm thuộc tính ProductName
    private int inventoryID;
    private Date importDate;
    private double unitCost;
    private int quantity;
    private double totalCost;
    private String supplierName;

    // Constructors, getters, and setters
    public Import() {}

    public Import(int importID, int productID, int inventoryID, Date importDate, double unitCost, int quantity, double totalCost, String supplierName, String productName) {
        this.importID = importID;
        this.productID = productID;
        this.inventoryID = inventoryID;
        this.importDate = importDate;
        this.unitCost = unitCost;
        this.quantity = quantity;
        this.totalCost = totalCost;
        this.supplierName = supplierName;
        this.productName = productName; // Khởi tạo productName
    }

    // Getter và setter cho productName
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    // Các getter và setter còn lại
    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getInventoryID() {
        return inventoryID;
    }

    public void setInventoryID(int inventoryID) {
        this.inventoryID = inventoryID;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public double getUnitCost() {
        return unitCost;
    }

    public void setUnitCost(double unitCost) {
        this.unitCost = unitCost;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}
