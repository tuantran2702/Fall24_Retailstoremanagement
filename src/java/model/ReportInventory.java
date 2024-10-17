package com.example.retailstore.model;

import java.time.LocalDateTime;

public class ReportInventory {
    private Integer reportId;
    private LocalDateTime reportDate;
    private Integer productId;
    private Integer warehouseId;
    private Integer totalQuantity;
    private Double totalStockValue;

    // Default constructor
    public ReportInventory() {}

    // Constructor with all fields
    public ReportInventory(Integer reportId, LocalDateTime reportDate, Integer productId, 
                           Integer warehouseId, Integer totalQuantity, Double totalStockValue) {
        this.reportId = reportId;
        this.reportDate = reportDate;
        this.productId = productId;
        this.warehouseId = warehouseId;
        this.totalQuantity = totalQuantity;
        this.totalStockValue = totalStockValue;
    }

    // Getters and Setters
    public Integer getReportId() {
        return reportId;
    }

    public void setReportId(Integer reportId) {
        this.reportId = reportId;
    }

    public LocalDateTime getReportDate() {
        return reportDate;
    }

    public void setReportDate(LocalDateTime reportDate) {
        this.reportDate = reportDate;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }

    public Integer getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(Integer totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public Double getTotalStockValue() {
        return totalStockValue;
    }

    public void setTotalStockValue(Double totalStockValue) {
        this.totalStockValue = totalStockValue;
    }

    @Override
    public String toString() {
        return "ReportInventory{" +
               "reportId=" + reportId +
               ", reportDate=" + reportDate +
               ", productId=" + productId +
               ", warehouseId=" + warehouseId +
               ", totalQuantity=" + totalQuantity +
               ", totalStockValue=" + totalStockValue +
               '}';
    }
}