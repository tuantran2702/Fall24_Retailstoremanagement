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

    public Import() {
    }

    public Import(int importID, int productID, int inventoryID, Date importDate, double unitCost, int quantity, String supplierName) {
        this.importID = importID;
        this.productID = productID;
        this.inventoryID = inventoryID;
        this.importDate = importDate;
        this.unitCost = unitCost;
        this.quantity = quantity;
        this.totalCost = quantity * unitCost;
        this.supplierName = supplierName;
    }

    // Getters and Setters
    public int getImportID() { return importID; }
    public void setImportID(int importID) { this.importID = importID; }

    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }

    public int getInventoryID() { return inventoryID; }
    public void setInventoryID(int inventoryID) { this.inventoryID = inventoryID; }

    public Date getImportDate() { return importDate; }
    public void setImportDate(Date importDate) { this.importDate = importDate; }

    public double getUnitCost() { return unitCost; }
    public void setUnitCost(double unitCost) {
        this.unitCost = unitCost;
        this.totalCost = this.quantity * unitCost;
    }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.totalCost = this.quantity * this.unitCost;
    }

    public double getTotalCost() { return totalCost; }

    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
}
