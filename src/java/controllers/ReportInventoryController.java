/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.PermissionsDAO;
import dao.ReportInventoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import model.ReportInventory;
import model.User;

/**
 *
 * @author admin
 */
public class ReportInventoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReportInventory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReportInventory at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

  String END_POINT = "PRODUCT-MANAGE";
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

// Xử lý tìm kiếm và lọc
        String keyword = request.getParameter("keyword");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String productIDStr = request.getParameter("productID");
        String warehouseIDStr = request.getParameter("warehouseID");

        ReportInventoryDAO reportDAO = new ReportInventoryDAO();

        if (action == null) {
            // Nếu không có hành động, thực hiện tìm kiếm
            List<ReportInventory> reportInventories;
            if (keyword != null || startDateStr != null || endDateStr != null || productIDStr != null || warehouseIDStr != null) {
                Integer productID = (productIDStr != null && !productIDStr.isEmpty()) ? Integer.parseInt(productIDStr) : null;
                Integer warehouseID = (warehouseIDStr != null && !warehouseIDStr.isEmpty()) ? Integer.parseInt(warehouseIDStr) : null;

                // Chuyển đổi startDate và endDate từ String sang Date
                Date startDate = null;
                Date endDate = null;
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Định dạng ngày

                if (startDateStr != null && !startDateStr.isEmpty()) {
                    try {
                        startDate = dateFormat.parse(startDateStr);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }

                if (endDateStr != null && !endDateStr.isEmpty()) {
                    try {
                        endDate = dateFormat.parse(endDateStr);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }

                reportInventories = reportDAO.searchReportInventories(keyword, startDate, endDate, productID, warehouseID);
            } else {
                reportInventories = reportDAO.getlistReportInventory(); // Lấy tất cả báo cáo tồn kho
            }

            // Tính tổng số lượng và tổng giá trị tồn kho
            int totalQuantity = 0;
            double totalStockValue = 0.0;

            for (ReportInventory report : reportInventories) {
                totalQuantity += report.getTotalQuantity();
                totalStockValue += report.getTotalStockValue();
            }

            request.setAttribute("totalQuantity", totalQuantity); // Gửi tổng số lượng đến JSP
            request.setAttribute("totalStockValue", totalStockValue); // Gửi tổng giá trị tồn kho đến JSP
            request.setAttribute("data", reportInventories); // Gửi danh sách báo cáo đến JSP
            request.getRequestDispatcher("/ReportInventoryManager/listReportInventory.jsp").forward(request, response);

        } else if (action.equals("update") && idStr != null) {
            int id = Integer.parseInt(idStr);
            request.setAttribute("listProduct", reportDAO.GetListProduct());
            request.setAttribute("listWarehouse", reportDAO.GetListWarehouse());
            ReportInventory reportInventory = reportDAO.getlistReportInventoryById(id);
            request.setAttribute("reportInventory", reportInventory);
            request.getRequestDispatcher("/ReportInventoryManager/updateReportInventory.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            reportDAO.deleteReportInventory(id);
            response.sendRedirect("reportInventory");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
            int totalQuantity = Integer.parseInt(request.getParameter("totalQuantity"));
            double totalStockValue = Double.parseDouble(request.getParameter("totalStockValue"));

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date reportDate = new Date();

//            out.print(totalQuantity);
//            out.print(totalStockValue);
            try {
                reportDate = dateFormat.parse(request.getParameter("reportDate"));
            } catch (ParseException e) {
                e.printStackTrace();
            }

            ReportInventory reportInventory = new ReportInventory(id, reportDate, productID, warehouseID, totalQuantity, totalStockValue);
            ReportInventoryDAO rp = new ReportInventoryDAO();

            rp.updateReportInventory(reportInventory);
            response.sendRedirect("reportInventory");

        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
