package model;

import dao.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

public class Product extends DBContext {

    private int productID;
    private String productCode;
    private String productName;
    private int categoryID;
    private String categoryName;
    private double price;
    private int quantity;
    private String description;
    private Date createdDate;
    private Date expiredDate;
    private Date updateDate;
    private String image;
    private int userID;
    private int unitID;
    private int supplierID;

    Connection cnn;//ket noi
    Statement stm;//thuc thi cau lenh sql
    ResultSet rs;//luu tru du lieu va xu li
    PreparedStatement pstm;//thuc thi cau lenh sql

    private void connect() {
        cnn = connection;
        if (cnn != null) {
            System.out.println("Connect success");
        } else {
            System.out.println("Connect Fail");
        }
    }

    public Product() {
    }

    public Product(int productID, String productCode, String productName, int categoryID, double price, int quantity, String description, Date createdDate, Date expiredDate, Date updateDate, String image, int userID, int unitID, int supplierID) {
        this.productID = productID;
        this.productCode = productCode;
        this.productName = productName;
        this.categoryID = categoryID;
        this.price = price;
        this.quantity = quantity;
        this.description = description;
        this.createdDate = createdDate;
        this.expiredDate = expiredDate;
        this.updateDate = updateDate;
        this.image = image;
        this.userID = userID;
        this.unitID = unitID;
        this.supplierID = supplierID;
        connect();
    }

    public Product(int productID, String productCode, String productName, int categoryID, double price, int quantity, String description, Date createdDate, Date expiredDate, Date updateDate, String image, int userID, int unitID, int supplierID, String categoryName) {
        this.productID = productID;
        this.productCode = productCode;
        this.productName = productName;
        this.categoryID = categoryID;
        this.price = price;
        this.quantity = quantity;
        this.description = description;
        this.createdDate = createdDate;
        this.expiredDate = expiredDate;
        this.updateDate = updateDate;
        this.image = image;
        this.userID = userID;
        this.unitID = unitID;
        this.supplierID = supplierID;
        this.categoryName = categoryName;
        connect();
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getUnitID() {
        return unitID;
    }

    public void setUnitID(int unitID) {
        this.unitID = unitID;
    }

    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }
}
