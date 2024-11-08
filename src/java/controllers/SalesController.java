package controllers;

import dao.SalesDAO;
import dao.CustomerDAO;
import dao.PermissionsDAO;
import model.Sales;
import model.Customer;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.User;

@WebServlet(name = "SalesController", urlPatterns = {"/sales"})
public class SalesController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
          String END_POINT = "CUSTOMER-MANAGE";
        if (request.getSession().getAttribute("User") != null) {
            PermissionsDAO pd = new PermissionsDAO();
            User u = (User) request.getSession().getAttribute("User");
            if (!pd.isAccess(u, END_POINT)) {
                response.sendRedirect("404.jsp");
                return;
            }
        } else {
            response.sendRedirect("404.jsp");
            return;
        }
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
        } else if (action.equals("exportExcel")) {
            // Xuất danh sách Sales ra Excel
            List<Sales> salesList = salesDAO.getFilteredSales(customerName, saleDate);
            exportExcel(response, salesList);
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

    private void exportExcel(HttpServletResponse response, List<Sales> salesList) throws IOException {
        // Set the content type and header for the response
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=sales.xlsx");

        // Create a workbook and a sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Sales");

        // Create the header row
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Sale ID");
        headerRow.createCell(1).setCellValue("Sale Date");
        headerRow.createCell(2).setCellValue("Total Amount");
        headerRow.createCell(3).setCellValue("Customer ID");

        // Create the data rows
        int rowIndex = 1;
        for (Sales sale : salesList) {
            Row dataRow = sheet.createRow(rowIndex);
            dataRow.createCell(0).setCellValue(sale.getSaleID());
            dataRow.createCell(1).setCellValue(sale.getSaleDate());
            dataRow.createCell(2).setCellValue(sale.getTotalAmount());
            dataRow.createCell(3).setCellValue(sale.getCustomerID());
            rowIndex++;
        }

        // Write the workbook to the response
        OutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        outputStream.flush();
        outputStream.close();
    }
}