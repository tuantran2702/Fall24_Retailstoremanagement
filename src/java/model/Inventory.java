package model;

import java.util.Date;
import java.util.logging.Logger;

public class Inventory {
    private int inventoryID;
    private int productID;
    private String productName; // Thêm thuộc tính ProductName
    private int warehouseID;
    private String warehouseName; // Thêm thuộc tính WarehouseName
    private int quantity;
    private Date lastUpdated;
    
    
    public Inventory() {
    }

    // Constructor đầy đủ
    public Inventory(int inventoryID, int productID, int warehouseID, int quantity, Date lastUpdated, String productName, String warehouseName) {
        this.inventoryID = inventoryID;
        this.productID = productID;
        this.warehouseID = warehouseID;
        this.quantity = quantity;
        this.lastUpdated = lastUpdated;
        this.productName = productName;
        this.warehouseName = warehouseName;
    }

    // Constructor không có ProductName và WarehouseName (có thể không cần thiết)
    public Inventory(int inventoryID, int productID, int warehouseID, int quantity, Date lastUpdated) {
        this.inventoryID = inventoryID;
        this.productID = productID;
        this.warehouseID = warehouseID;
        this.quantity = quantity;
        this.lastUpdated = lastUpdated;
    }
    private static final Logger LOG = Logger.getLogger(Inventory.class.getName());

    // Getters và Setters
    public int getInventoryID() {
        return inventoryID;
    }
   
    public Inventory(int inventoryID, int productID, String productName, int warehouseID, String warehouseName, int quantity, Date lastUpdated) {
        this.inventoryID = inventoryID;
        this.productID = productID;
        this.productName = productName;
        this.warehouseID = warehouseID;
        this.warehouseName = warehouseName;
        this.quantity = quantity;
        this.lastUpdated = lastUpdated;
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
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
}
