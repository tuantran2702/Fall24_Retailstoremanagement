/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.RoleControllers;

import dao.PermissionsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Permissions;
import model.User;

/**
 *
 * @author ptrung
 */
public class PermissionsServlet extends HttpServlet {

    PermissionsDAO permissionsDAO = new PermissionsDAO();

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
            out.println("<title>Servlet PermissionsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PermissionsServlet at " + request.getContextPath() + "</h1>");
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
        String END_POINT = "PERMISSION-MANAGE";
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
        

        // Sử dụng DAO để lấy danh sách quyền hạn từ cơ sở dữ liệu
        List<Permissions> permissionList = permissionsDAO.getAllPermissions();

        // Gửi danh sách quyền đến trang JSP
        request.setAttribute("permissionList", permissionList);

        // Chuyển hướng đến trang JSP hiển thị bảng quyền hạn
        request.getRequestDispatcher("Role/Permissions.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String permissionName = request.getParameter("permissionName");

        // Kiểm tra và xử lý thêm quyền mới vào cơ sở dữ liệu
        // Giả sử bạn có một phương thức addPermission để thêm quyền vào DB
        if (permissionName != null) {
            boolean addSuccess = permissionsDAO.addPermission(permissionName);
            if (addSuccess) {
                response.sendRedirect("permissions"); // Điều hướng đến trang quyền
            }
        }else{
            
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