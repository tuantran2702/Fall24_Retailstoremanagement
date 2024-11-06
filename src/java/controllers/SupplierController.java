/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.PermissionsDAO;
import dao.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Supplier;
import model.User;

/**
 *
 * @author admin
 */
public class SupplierController extends HttpServlet {

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
            out.println("<title>Servlet SupplierController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SupplierController at " + request.getContextPath() + "</h1>");
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

        //Xử lí Phân Quyền
        String END_POINT = "INVENTORY-MANAGE";
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
        String supplierID = request.getParameter("supplierID");

        SupplierDAO supplierDAO = new SupplierDAO();

        if (action == null) {
            // Nếu không có hành động, thực hiện tìm kiếm
            List<Supplier> suppliers;
            if (keyword != null || supplierID != null) {
                suppliers = supplierDAO.searchSuppliers(keyword, supplierID); // Tìm kiếm dựa trên từ khóa và ID
            } else {
                suppliers = supplierDAO.getListsupplier(); // Lấy tất cả nhà cung cấp
            }
            request.setAttribute("data", suppliers); // Gửi danh sách nhà cung cấp đến JSP
            request.getRequestDispatcher("/SupplierManager/listSupplier.jsp").forward(request, response);

        } else if (action.equals("create")) {
            request.getRequestDispatcher("/SupplierManager/createSupplier.jsp").forward(request, response);
        } else if (action.equals("update") && idStr != null) {
            int id = Integer.parseInt(idStr);
            Supplier s = supplierDAO.getSupplierById(id);
            request.setAttribute("supplier", s);
            request.getRequestDispatcher("/SupplierManager/updateSupplier.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            int id = Integer.parseInt(idStr);
            supplierDAO.deletesupplier(id);
            response.sendRedirect("supplier");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("create")) {
            String supplierName = request.getParameter("supplierName");
            String contactName = request.getParameter("contactName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            SupplierDAO supplierDAO = new SupplierDAO();

// Kiểm tra xem tên nhà cung cấp và tên liên hệ đã tồn tại chưa
        if (supplierDAO.isSupplierExists(supplierName, contactName)) {
            request.setAttribute("errorMessage", "Tên nhà cung cấp và tên liên hệ đã tồn tại. Vui lòng chọn tên khác.");
            request.getRequestDispatcher("/SupplierManager/createSupplier.jsp").forward(request, response);
            return;
        }

            Supplier supplier = new Supplier(0, supplierName, contactName, phoneNumber, email, address);
            SupplierDAO s = new SupplierDAO();
            s.createSupplier(supplier);
            response.sendRedirect("supplier");

        } else if (action.equals("update")) {

            int id = Integer.parseInt(request.getParameter("id"));
            String supplierName = request.getParameter("supplierName");
            String contactName = request.getParameter("contactName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            Supplier supplier = new Supplier(id, supplierName, contactName, phoneNumber, email, address);
            SupplierDAO s = new SupplierDAO();

            s.updateSupplier(supplier);
            response.sendRedirect("supplier");

        } else if ("createSupplierName".equals(action)) {
            // Lấy giá trị của categoryName từ form
            String supplierName = request.getParameter("supplierName");

            // Thực hiện thêm Category vào database (giả sử có một service hoặc DAO xử lý)
            SupplierDAO supplierDAO = new SupplierDAO();
            supplierDAO.addSupplierName(new Supplier(supplierName));

            // Chuyển hướng sau khi thêm thành công
            response.sendRedirect("product?action=create");
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
