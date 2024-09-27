package model;

import java.util.Date;

public class Inventory {
    private int inventoryID;
    private int productID;
    private int warehouseID;
    private int quantity;
    private Date lastUpdated;
    private String productName;
    private String warehouseName;

    // Constructor
    public Inventory(int inventoryID, int productID, int warehouseID, int quantity, Date lastUpdated, String productName, String warehouseName) {
        this.inventoryID = inventoryID;
        this.productID = productID;
        this.warehouseID = warehouseID;
        this.quantity = quantity;
        this.lastUpdated = lastUpdated;
        this.productName = productName;
        this.warehouseName = warehouseName;
    }

    public Inventory() {
        // Default constructor
    }

    // Getters and Setters
    public int getInventoryID() {
        return inventoryID;
    }

    public void setInventoryID(int inventoryID) {
        this.inventoryID = inventoryID;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
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
