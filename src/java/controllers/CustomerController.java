package controllers;

import dao.CustomerDAO;
import dao.CustomerRankDAO;
import dao.PermissionsDAO;
import model.Customer;
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
import model.User;

@WebServlet(name = "CustomerController", urlPatterns = {"/customer"})
public class CustomerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
           //Xử lí Phân Quyền
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
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String rankIDStr = request.getParameter("rankID");
        int rankID = (rankIDStr != null && !rankIDStr.isEmpty()) ? Integer.parseInt(rankIDStr) : 0;

        CustomerDAO customerDAO = new CustomerDAO();
        CustomerRankDAO customerRankDAO = new CustomerRankDAO();

        if (action == null) {
            // Tìm kiếm khách hàng
            List<Customer> customers = customerDAO.getFilteredCustomers(firstName, lastName, rankID);
            request.setAttribute("data", customers);
            request.setAttribute("ranks", customerRankDAO.getListCustomerRank()); // Để hiển thị danh sách rank
            request.getRequestDispatcher("/CustomerManager/Customer/CustomerManager.jsp").forward(request, response);

        } else if (action.equals("edit") && idStr != null) {
            // Edit customer
            int id = Integer.parseInt(idStr);
            Customer customer = customerDAO.getCustomerById(id);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.setAttribute("ranks", customerRankDAO.getListCustomerRank());
                request.getRequestDispatcher("/CustomerManager/Customer/updateCustomer.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/customer");
            }
        } else if (action.equals("create")) {
            // Create new customer
            request.setAttribute("ranks", customerRankDAO.getListCustomerRank());
            request.getRequestDispatcher("/CustomerManager/Customer/createCustomer.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Delete customer confirmation
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/CustomerManager/Customer/deleteCustomer.jsp").forward(request, response);
        } else if (action.equals("exportExcel")) {
            // Xuất Excel
            exportExcel(response, customerDAO.getListCustomers());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        CustomerDAO customerDAO = new CustomerDAO();

        if (action.equals("create")) {
            // Tạo mới khách hàng
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

            Customer customer = new Customer();
            customer.setFirstName(firstName);
            customer.setLastName(lastName);
            customer.setEmail(email);
            customer.setPhoneNumber(phoneNumber);
            customer.setAddress(address);
            customer.setRankID(1); // Thiết lập RankID mặc định là 1
            customer.setTotalSpent(0.0); // Thiết lập TotalSpent mặc định là 0

            customerDAO.createCustomer(customer);
            response.sendRedirect(request.getContextPath() + "/customer");
        } else if (action.equals("update")) {
            // Update existing customer
            int id = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

            Customer customer = new Customer();
            customer.setCustomerID(id);
            customer.setFirstName(firstName);
            customer.setLastName(lastName);
            customer.setEmail(email);
            customer.setPhoneNumber(phoneNumber);
            customer.setAddress(address);

            customerDAO.updateCustomer(customer);
            response.sendRedirect(request.getContextPath() + "/customer");
        } else if (action.equals("delete")) {
            // Delete customer
            int id = Integer.parseInt(request.getParameter("id"));
            customerDAO.deleteCustomer(id);
            response.sendRedirect(request.getContextPath() + "/customer");
        }
    }

    private void exportExcel(HttpServletResponse response, List<Customer> customers) throws IOException {
        // Thiết lập thông tin cho file Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=customers.xlsx");

        // Tạo workbook và sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Customers");

        // Tạo hàng tiêu đề
        Row headerRow = sheet.createRow(0);
        String[] columnHeaders = {"Customer ID", "First Name", "Last Name", "Email", "Phone Number", "Total Spent", "Address", "Rank"};
        for (int i = 0; i < columnHeaders.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columnHeaders[i]);
        }

        // Thêm dữ liệu vào sheet
        int rowNum = 1;
        for (Customer customer : customers) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(customer.getCustomerID());
            row.createCell(1).setCellValue(customer.getFirstName());
            row.createCell(2).setCellValue(customer.getLastName());
            row.createCell(3).setCellValue(customer.getEmail());
            row.createCell(4).setCellValue(customer.getPhoneNumber());
            row.createCell(5).setCellValue(customer.getTotalSpent());
            row.createCell(6).setCellValue(customer.getAddress());
            row.createCell(7).setCellValue(customer.getRankName());
        }

        // Ghi workbook vào OutputStream
        try ( OutputStream out = response.getOutputStream()) {
            workbook.write(out);
        } finally {
            workbook.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "CustomerController handles CRUD operations for Customer entities.";
    }
}