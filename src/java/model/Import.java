package model;

import java.util.Date;

public class Import {
    private int importID;
    private int productID;
    private int inventoryID;
    private Date importDate;
    private double unitCost;
    private int quantity;
    private double totalCost;
    private String supplierName;
 private String productName; // Thêm trường này
    public Import() {
    }

   public Import(int importID, int productID, String productName, int inventoryID, Date importDate, double unitCost, int quantity, double totalCost, String supplierName) {
        this.importID = importID;
        this.importID = importID;
          this.productName = productName;
        this.productID = productID;
        this.inventoryID = inventoryID;
        this.importDate = importDate;
        this.unitCost = unitCost;
        this.quantity = quantity;
        this.totalCost = totalCost;
        this.supplierName = supplierName;
    }
   public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    // Getters
    public int getImportID() {
        return importID;
    }

    public int getProductID() {
        return productID;
    }

    public int getInventoryID() {
        return inventoryID;
    }

    public Date getImportDate() {
        return importDate;
    }

    public double getUnitCost() {
        return unitCost;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public String getSupplierName() {
        return supplierName;
    }

    // Setters
    public void setImportID(int importID) {
        this.importID = importID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public void setInventoryID(int inventoryID) {
        this.inventoryID = inventoryID;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public void setUnitCost(double unitCost) {
        this.unitCost = unitCost;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}