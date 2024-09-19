package model;

import java.util.Date;

public class ReportOrder {
    private int reportID;
    private int orderID;
    private Date reportDate;
    private int totalOrders;
    private double totalSales;
    private int totalProductsSold;
    private Date startDate;
    private Date endDate;

    // Constructors, getters, and setters
    public ReportOrder() {}

    public ReportOrder(int reportID, int orderID, Date reportDate, int totalOrders, double totalSales, int totalProductsSold, Date startDate, Date endDate) {
        this.reportID = reportID;
        this.orderID = orderID;
        this.reportDate = reportDate;
        this.totalOrders = totalOrders;
        this.totalSales = totalSales;
        this.totalProductsSold = totalProductsSold;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public double getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(double totalSales) {
        this.totalSales = totalSales;
    }

    public int getTotalProductsSold() {
        return totalProductsSold;
    }

    public void setTotalProductsSold(int totalProductsSold) {
        this.totalProductsSold = totalProductsSold;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
