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
        String roleName = request.getParameter("roleName").trim();
        String description = request.getParameter("description").trim();
        String[] permissions = request.getParameterValues("permissions"); // Lấy danh sách quyền hạn được chọn

        // Khởi tạo đối tượng DAO
        RoleDAO roleDAO = new RoleDAO();
        PermissionsDAO permissionsDAO = new PermissionsDAO();

        // Kiểm tra nếu các giá trị không rỗng
        if (roleName.isEmpty() || description.isEmpty()) {
            request.setAttribute("errorMessage", "Các trường Role Name và Description không được để trống.");
            request.setAttribute("permissions", permissionsDAO.getAllPermissions());
            request.getRequestDispatcher("Role/AddRole.jsp").forward(request, response);
            return;
        }
        
        if (permissions == null) {
            request.setAttribute("errorMessage", "Permission = null.");
            request.setAttribute("permissions", permissionsDAO.getAllPermissions());
            request.getRequestDispatcher("Role/AddRole.jsp").forward(request, response);
            return;
        }

        try {
            // Thêm vai trò vào cơ sở dữ liệu
            boolean addSuccess = roleDAO.addRole(roleName, description, permissions);

            if (addSuccess) {
                // Nếu thêm vai trò thành công, chuyển hướng đến trang danh sách vai trò
                response.sendRedirect("roles");
            } else {
                // Nếu thêm vai trò thất bại, gửi thông báo lỗi và danh sách quyền đến trang form
                request.setAttribute("errorMessage", "Thêm vai trò thất bại. Vui lòng thử lại.");
                request.setAttribute("permissions", permissionsDAO.getAllPermissions());
                request.getRequestDispatcher("Role/AddRole.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Xử lý lỗi và thông báo đến người dùng
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình thêm vai trò. Vui lòng thử lại sau.");
            request.setAttribute("permissions", permissionsDAO.getAllPermissions());
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