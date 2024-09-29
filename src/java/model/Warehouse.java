package model;

public class Warehouse {

    private int warehouseID;
    private String warehouseName;
    private String location;
    private String managerName;
    private String contactNumber;

    public Warehouse() {
    }

    public Warehouse(int warehouseID, String warehouseName, String location, String managerName, String contactNumber) {
        this.warehouseID = warehouseID;
        this.warehouseName = warehouseName;
        this.location = location;
        this.managerName = managerName;
        this.contactNumber = contactNumber;
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }
}
