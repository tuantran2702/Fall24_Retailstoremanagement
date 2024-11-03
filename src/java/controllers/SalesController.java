package controllers;

import dao.SalesDAO;
import dao.CustomerDAO;
import model.Sales;
import model.Customer;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

@WebServlet(name = "SalesController", urlPatterns = {"/sales"})
public class SalesController extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    String idStr = request.getParameter("id");
    String customerName = request.getParameter("customerName"); // Tham số tìm kiếm theo tên khách hàng
    String saleDate = request.getParameter("saleDate"); // Tham số tìm kiếm theo ngày

    SalesDAO salesDAO = new SalesDAO();
    CustomerDAO customerDAO = new CustomerDAO();

    if (action == null) {
        // Hiển thị danh sách Sale với bộ lọc
        ArrayList<Sales> salesList = salesDAO.getFilteredSales(customerName, saleDate);
        request.setAttribute("salesList", salesList);
        request.getRequestDispatcher("/CustomerManager/Sales/SaleManager.jsp").forward(request, response);
    } else if (action.equals("edit") && idStr != null) {
        // Chỉnh sửa Sale
        int id = Integer.parseInt(idStr);
        Sales sale = salesDAO.getSaleById(id);
        request.setAttribute("sale", sale);
        request.setAttribute("customers", customerDAO.getListCustomers()); // Để chọn customer khi cập nhật
        request.getRequestDispatcher("/sales/editSale.jsp").forward(request, response);
    } else if (action.equals("create")) {
        // Tạo mới Sale
        request.setAttribute("customers", customerDAO.getListCustomers());
        request.getRequestDispatcher("/sales/createSale.jsp").forward(request, response);
    } else if (action.equals("delete") && idStr != null) {
        // Xóa Sale
        int id = Integer.parseInt(idStr);
        salesDAO.deleteSale(id);
        response.sendRedirect(request.getContextPath() + "/sales");
    }
}



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        SalesDAO salesDAO = new SalesDAO();

        if (action.equals("create")) {
            // Tạo mới Sale
            Date saleDate = new Date(); // Lấy thời gian hiện tại
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            int customerID = Integer.parseInt(request.getParameter("customerID"));

            Sales sale = new Sales();
            sale.setSaleDate(saleDate);
            sale.setTotalAmount(totalAmount);
            sale.setCustomerID(customerID);

            salesDAO.addSale(sale);
            response.sendRedirect(request.getContextPath() + "/sales");
        } else if (action.equals("update")) {
            // Cập nhật Sale
            int id = Integer.parseInt(request.getParameter("id"));
            Date saleDate = new Date(); // Cập nhật với thời gian hiện tại
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            int customerID = Integer.parseInt(request.getParameter("customerID"));

            Sales sale = new Sales();
            sale.setSaleID(id);
            sale.setSaleDate(saleDate);
            sale.setTotalAmount(totalAmount);
            sale.setCustomerID(customerID);

            salesDAO.updateSale(sale);
            response.sendRedirect(request.getContextPath() + "/sales");
        }
    }
}