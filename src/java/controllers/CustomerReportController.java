package controllers;

import dao.CustomerDAO;
import dao.CustomerReportDAO;
import model.CustomerReport;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "CustomerReportController", urlPatterns = {"/customerReport"})
public class CustomerReportController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerReportDAO reportDAO = new CustomerReportDAO();
        String idStr = request.getParameter("id");
        String customerName = request.getParameter("customerName"); // Tham số tìm kiếm theo tên khách hàng
        String reportDate = request.getParameter("reportDate"); // Tham số tìm kiếm theo ngày

        CustomerDAO customerDAO = new CustomerDAO();

        if (action == null) {
            // Hiển thị danh sách báo cáo
//        List<CustomerReport> reports = reportDAO.getListCustomerReports();
//        request.setAttribute("data", reports);
            // Hiển thị danh sách Sale với bộ lọc
            ArrayList<CustomerReport> reports = reportDAO.getFilteredCustomerReports(customerName, reportDate);
            request.setAttribute("data", reports);
            //request.getRequestDispatcher("/CustomerManager/Report/CustomerReportManager.jsp").forward(request, response);
            // Tính toán số lượng khách hàng hiện có và tổng số đơn hàng
            int totalCustomers = reports.size();
            int totalOrders = reports.stream().mapToInt(CustomerReport::getTotalOrders).sum();
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalOrders", totalOrders);
            request.getRequestDispatcher("/CustomerManager/Report/CustomerReportManager.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            // Xóa báo cáo
            int id = Integer.parseInt(request.getParameter("id"));
            reportDAO.deleteReport(id);
            response.sendRedirect(request.getContextPath() + "/customerReport");
        } else if (action.equals("export")) {
            // Xuất báo cáo ra file Excel
            exportToExcel(response, reportDAO.getListCustomerReports());
        }
//    else if (action.equals("search")) {
//        // Tìm kiếm báo cáo
//        String customerName = request.getParameter("customerID");
//        String reportDate = request.getParameter("reportDate");
//
//        List<CustomerReport> reports = reportDAO.getFilteredCustomerReports(customerName, reportDate);
//        request.setAttribute("data", reports);
//        // Tính toán số lượng khách hàng hiện có và tổng số đơn hàng
//        int totalCustomers = reports.size();
//        int totalOrders = reports.stream().mapToInt(CustomerReport::getTotalOrders).sum();
//        request.setAttribute("totalCustomers", totalCustomers);
//        request.setAttribute("totalOrders", totalOrders);
//        request.getRequestDispatcher("/CustomerManager/Report/CustomerReportManager.jsp").forward(request, response);
//    }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerReportDAO reportDAO = new CustomerReportDAO();

//        if (action.equals("create")) {
//            // Tạo mới báo cáo khách hàng
//            int customerID = Integer.parseInt(request.getParameter("customerID"));
//            Date reportDate = Date.now(); // Lấy thời gian hiện tại
//            int totalOrders = Integer.parseInt(request.getParameter("totalOrders"));
//            double totalSpent = Double.parseDouble(request.getParameter("totalSpent"));
//            int loyaltyPointsEarned = Integer.parseInt(request.getParameter("loyaltyPointsEarned"));
//            int loyaltyPointsRedeemed = Integer.parseInt(request.getParameter("loyaltyPointsRedeemed"));
//            String mostPurchasedProduct = request.getParameter("mostPurchasedProduct");
//
//            // Tạo đối tượng CustomerReport
//            CustomerReport report = new CustomerReport();
//            report.setCustomerID(customerID);
//            report.setReportDate(reportDate);
//            report.setTotalOrders(totalOrders);
//            report.setTotalSpent(totalSpent);
//            report.setLoyaltyPointsEarned(loyaltyPointsEarned);
//            report.setLoyaltyPointsRedeemed(loyaltyPointsRedeemed);
//            report.setMostPurchasedProduct(mostPurchasedProduct);
//
//            // Lưu báo cáo vào cơ sở dữ liệu
//            reportDAO.createCustomerReport(report);
//
//            // Chuyển hướng về danh sách báo cáo
//            response.sendRedirect(request.getContextPath() + "/customerReport");
//        }
    }

    private void exportToExcel(HttpServletResponse response, List<CustomerReport> reports) throws IOException {
        // Thiết lập thông tin cho file Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=customer_reports.xlsx");

        // Tạo workbook và sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Customer Reports");

        // Tạo hàng tiêu đề
        Row headerRow = sheet.createRow(0);
        String[] columnHeaders = {
            "Customer ID",
            "Report Date",
            "Total Orders",
            "Total Spent",
            "Loyalty Points Earned",
            "Loyalty Points Redeemed",
            "Most Purchased Product"
        };

        for (int i = 0; i < columnHeaders.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columnHeaders[i]);
        }

        // Thêm dữ liệu vào sheet
        int rowNum = 1;
        for (CustomerReport report : reports) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(report.getCustomerID());
            row.createCell(1).setCellValue(report.getReportDate().toString()); // Chuyển đổi LocalDateTime thành String
            row.createCell(2).setCellValue(report.getTotalOrders());
            row.createCell(3).setCellValue(report.getTotalSpent());
            row.createCell(4).setCellValue(report.getLoyaltyPointsEarned());
            row.createCell(5).setCellValue(report.getLoyaltyPointsRedeemed());
            row.createCell(6).setCellValue(report.getMostPurchasedProduct());
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
        return "CustomerReportController handles CRUD operations for CustomerReport entities.";
    }

}
