package controllers;

import dao.CustomerRankDAO;
import model.CustomerRank;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@WebServlet(name = "CustomerRankController", urlPatterns = {"/customerRank"})
public class CustomerRankController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerRankController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerRankController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    String idStr = request.getParameter("id");
    String rankName = request.getParameter("rankName"); // Search parameter for rank name

    CustomerRankDAO customerRankDAO = new CustomerRankDAO();

    if (action == null) {
        // Display list of customer ranks with filtering
        request.setAttribute("data", customerRankDAO.getFilteredCustomerRanks(rankName));
        request.getRequestDispatcher("/CustomerManager/CustomerRank/CustomerRankManager.jsp").forward(request, response);
    } else if (action.equals("edit") && idStr != null) {
        // Edit customer rank
        int id = Integer.parseInt(idStr);
        CustomerRank customerRank = customerRankDAO.getCustomerRankById(id);
        request.setAttribute("customerRank", customerRank);
        request.getRequestDispatcher("/CustomerManager/CustomerRank/updateCustomerRank.jsp").forward(request, response);
    } else if (action.equals("create")) {
        // Create new customer rank
        request.getRequestDispatcher("/CustomerManager/CustomerRank/createCustomerRank.jsp").forward(request, response);
    } else if (action.equals("delete") && idStr != null) {
        // Delete customer rank confirmation
        int id = Integer.parseInt(idStr);
        request.setAttribute("id", id);
        request.getRequestDispatcher("/CustomerManager/CustomerRank/deleteCustomerRank.jsp").forward(request, response);
    } else if (action.equals("deleteAll")) {
        // Delete all customer ranks
        request.getRequestDispatcher("/CustomerManager/CustomerRank/deleteAllCustomerRanks.jsp").forward(request, response);
    } else if (action.equals("exportExcel")) {
        // Export to Excel
        exportExcel(response, customerRankDAO.getListCustomerRank());
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        CustomerRankDAO customerRankDAO = new CustomerRankDAO();

        if (action.equals("create")) {
            // Create new customer rank
            String name = request.getParameter("name");
            double minimumSpent = Double.parseDouble(request.getParameter("minimumSpent"));
            String description = request.getParameter("description");
            double discountPercent = Double.parseDouble(request.getParameter("discountPercent")); // Lấy discountPercent

            CustomerRank customerRank = new CustomerRank();
            customerRank.setRankName(name);
            customerRank.setMinimumSpent(minimumSpent);
            customerRank.setDescription(description);
            customerRank.setDiscountPercent(discountPercent); // Thiết lập discountPercent

            customerRankDAO.createCustomerRank(customerRank);
            response.sendRedirect(request.getContextPath() + "/customerRank");
        } else if (action.equals("update")) {
            // Update existing customer rank
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double minimumSpent = Double.parseDouble(request.getParameter("minimumSpent"));
            String description = request.getParameter("description");
            double discountPercent = Double.parseDouble(request.getParameter("discountPercent")); // Lấy discountPercent

            CustomerRank customerRank = new CustomerRank();
            customerRank.setRankID(id);
            customerRank.setRankName(name);
            customerRank.setMinimumSpent(minimumSpent);
            customerRank.setDescription(description);
            customerRank.setDiscountPercent(discountPercent); // Thiết lập discountPercent

            customerRankDAO.updateCustomerRank(customerRank);
            response.sendRedirect(request.getContextPath() + "/customerRank");
        } else if (action.equals("delete")) {
            // Delete customer rank
            int id = Integer.parseInt(request.getParameter("id"));
            customerRankDAO.deleteCustomerRank(id);
            response.sendRedirect(request.getContextPath() + "/customerRank");
        } else if (action.equals("deleteAll")) {
            // Xóa tất cả customer ranks
            customerRankDAO.deleteAllCustomerRanks();
            response.sendRedirect(request.getContextPath() + "/customerRank");
        }
    }

    private void exportExcel(HttpServletResponse response, List<CustomerRank> customerRanks) throws IOException {
        // Thiết lập thông tin cho file Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=customerRanks.xlsx");

        // Tạo workbook và sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Customer Ranks");

        // Tạo hàng tiêu đề
        Row headerRow = sheet.createRow(0);
        String[] columnHeaders = {"Rank ID", "Rank Name", "Minimum Spent", "Description", "Discount Percent"}; // Thêm Discount Percent
        for (int i = 0; i < columnHeaders.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columnHeaders[i]);
        }

        // Thêm dữ liệu vào sheet
        int rowNum = 1;
        for (CustomerRank customerRank : customerRanks) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(customerRank.getRankID());
            row.createCell(1).setCellValue(customerRank.getRankName());
            row.createCell(2).setCellValue(customerRank.getMinimumSpent());
            row.createCell(3).setCellValue(customerRank.getDescription());
            row.createCell(4).setCellValue(customerRank.getDiscountPercent()); // Thêm Discount Percent
        }

        // Ghi workbook vào OutputStream
        try (OutputStream out = response.getOutputStream()) {
            workbook.write(out);
        } finally {
            workbook.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "CustomerRankController handles CRUD operations for Customer Rank entities.";
    }
}