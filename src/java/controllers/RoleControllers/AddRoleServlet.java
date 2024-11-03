/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.RoleControllers;

import dao.PermissionsDAO;
import dao.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Permissions;

/**
 *
 * @author ptrung
 */
public class AddRoleServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddRoleServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddRoleServlet at " + request.getContextPath() + "</h1>");
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
        // Sử dụng DAO để lấy danh sách quyền
        PermissionsDAO permissionsDAO = new PermissionsDAO();
        List<Permissions> permissions = permissionsDAO.getAllPermissions();

        // Gửi danh sách quyền đến trang JSP
        request.setAttribute("permissions", permissions);

        request.getRequestDispatcher("Role/AddRole.jsp").forward(request, response);
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

        // Lấy dữ liệu từ form
        String roleName = request.getParameter("roleName");
        String description = request.getParameter("description");
        String[] permissions = request.getParameterValues("permissions"); // Lấy danh sách quyền hạn được chọn

        // Kiểm tra nếu các giá trị không rỗng
        if (roleName == null || roleName.isEmpty() || description == null || description.isEmpty()) {
            // Nếu có lỗi, đặt thông báo lỗi và quay lại trang form
            request.setAttribute("errorMessage", "Các trường Role Name và Description không được để trống.");

            // Gửi danh sách quyền đến trang JSP
            request.setAttribute("permissions", permissions);
            request.getRequestDispatcher("Role/AddRole.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng RoleDAO để tương tác với DB
        RoleDAO rd = new RoleDAO();

        // Thêm vai trò vào cơ sở dữ liệu
        boolean addSuccess = rd.addRole(roleName, description, permissions);

        // Nếu thêm vai trò thành công, chuyển hướng đến trang danh sách vai trò
        if (addSuccess) {
            response.sendRedirect("roles");
        } else {
            // Nếu thêm vai trò thất bại, quay lại trang form với thông báo lỗi
            // Gửi danh sách quyền đến trang JSP
            // Sử dụng DAO để lấy danh sách quyền
            PermissionsDAO permissionsDAO = new PermissionsDAO();
            List<Permissions> psm = permissionsDAO.getAllPermissions();
            request.setAttribute("permissions", psm);
            request.setAttribute("errorMessage", "Thêm vai trò thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("Role/AddRole.jsp").forward(request, response);
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