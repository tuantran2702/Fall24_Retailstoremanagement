package controllers;

import dao.CustomerReportDAO;
import model.CustomerReport;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "CustomerReportController", urlPatterns = {"/customerReport"})
public class CustomerReportController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerReportDAO reportDAO = new CustomerReportDAO();

        if (action == null) {
            // Hiển thị danh sách báo cáo
            List<CustomerReport> reports = reportDAO.getListCustomerReports();
            request.setAttribute("data", reports);
            request.getRequestDispatcher("/CustomerManager/Report/CustomerReportManager.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            // Xóa báo cáo
            int id = Integer.parseInt(request.getParameter("id"));
            reportDAO.deleteReport(id);
            response.sendRedirect(request.getContextPath() + "/customerReport");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerReportDAO reportDAO = new CustomerReportDAO();

        if (action.equals("create")) {
            // Tạo mới báo cáo khách hàng
            int customerID = Integer.parseInt(request.getParameter("customerID"));
            LocalDateTime reportDate = LocalDateTime.now(); // Lấy thời gian hiện tại
            int totalOrders = Integer.parseInt(request.getParameter("totalOrders"));
            double totalSpent = Double.parseDouble(request.getParameter("totalSpent"));
            int loyaltyPointsEarned = Integer.parseInt(request.getParameter("loyaltyPointsEarned"));
            int loyaltyPointsRedeemed = Integer.parseInt(request.getParameter("loyaltyPointsRedeemed"));
            String mostPurchasedProduct = request.getParameter("mostPurchasedProduct");

            // Tạo đối tượng CustomerReport
            CustomerReport report = new CustomerReport();
            report.setCustomerID(customerID);
            report.setReportDate(reportDate);
            report.setTotalOrders(totalOrders);
            report.setTotalSpent(totalSpent);
            report.setLoyaltyPointsEarned(loyaltyPointsEarned);
            report.setLoyaltyPointsRedeemed(loyaltyPointsRedeemed);
            report.setMostPurchasedProduct(mostPurchasedProduct);

            // Lưu báo cáo vào cơ sở dữ liệu
            reportDAO.createCustomerReport(report);

            // Chuyển hướng về danh sách báo cáo
            response.sendRedirect(request.getContextPath() + "/customerReport");
        }
    }

    @Override
    public String getServletInfo() {
        return "CustomerReportController handles CRUD operations for CustomerReport entities.";
    }
}