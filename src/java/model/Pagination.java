/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Pagination {

    private int totalPage;
    private int pageLimit;
    private int currentPage;
    private int total;
    private int startItem;
    private int lastItem;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getStartItem() {
        return startItem;
    }

    public void setStartItem(int startItem) {
        this.startItem = startItem;
    }

    public int getLastItem() {
        return lastItem;
    }

    public void setLastItem(int lastItem) {
        this.lastItem = lastItem;
    }

    public Pagination() {
    }

    public Pagination(int total, int pageLimit, int currentPage) {
        this.total = total;
        this.pageLimit = pageLimit;
        this.currentPage = currentPage;
        totalPage = total % pageLimit == 0 ? (total / pageLimit) : (total / pageLimit + 1);
        startItem = (currentPage - 1) * pageLimit;
        lastItem = currentPage * pageLimit - 1;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getPageLimit() {
        return pageLimit;
    }

    public void setPageLimit(int pageLimit) {
        this.pageLimit = pageLimit;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
}
