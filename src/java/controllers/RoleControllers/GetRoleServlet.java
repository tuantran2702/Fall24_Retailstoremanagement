/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.RoleControllers;

import com.google.gson.Gson;
import dao.PermissionsDAO;
import dao.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;
import model.Permissions;
import model.Role;

/**
 *
 * @author ptrung
 */
public class GetRoleServlet extends HttpServlet {

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
            out.println("<title>Servlet GetRoleServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetRoleServlet at " + request.getContextPath() + "</h1>");
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
        // Lấy roleID từ request
        String roleID = request.getParameter("id");

        // Lấy thông tin vai trò từ cơ sở dữ liệu
        RoleDAO roleDAO = new RoleDAO();
        Role role = roleDAO.getRoleByID(Integer.parseInt(roleID));

        // Lấy tất cả các quyền hạn
        PermissionsDAO pd = new PermissionsDAO();
        List<Permissions> allPermissions = pd.getAllPermissions();

        // Lấy các quyền hạn đã được gán cho vai trò này
        List<String> assignedPermissions = pd.getAssignedPermissionsForRole(Integer.parseInt(roleID));

        // Tạo đối tượng JSON trả về cho phía client
        Map<String, Object> roleData = new HashMap<>();
        roleData.put("roleID", role.getRoleID());
        roleData.put("roleName", role.getRoleName());
        roleData.put("description", role.getDescription());
        roleData.put("allPermissions", allPermissions); // Tất cả các quyền hạn
        roleData.put("assignedPermissions", assignedPermissions); // Quyền hạn đã gán

        // Chuyển đổi đối tượng roleData thành JSON và trả về cho client
        Gson gson = new Gson();
        String json = gson.toJson(roleData);
        response.setContentType("application/json");
        response.getWriter().write(json);
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
        String roleID = request.getParameter("roleID");
        String roleName = request.getParameter("roleName");
        String description = request.getParameter("description");
        String[] permissions = request.getParameterValues("permissions"); // Lấy danh sách quyền hạn

        // Kiểm tra nếu các giá trị không rỗng
        if (roleName == null || roleName.isEmpty() || description == null || description.isEmpty()) {
            // Nếu có lỗi, đặt thông báo lỗi và quay lại trang form
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Role Name và Description không được để trống\"}");
            return;
        }

        // Tạo đối tượng RoleDAO để tương tác với DB
        RoleDAO roleDAO = new RoleDAO();
        PermissionsDAO permissionsDAO = new PermissionsDAO();

        // Cập nhật vai trò
        Role r = roleDAO.getRoleByID(Integer.parseInt(roleID));
        if (r == null) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Không tìm thấy vai trò\"}");
            return;
        }
        r.setRoleName(roleName);
        r.setDescription(description);
        boolean updateSuccess = roleDAO.updateRole(r, permissions);

        // Kiểm tra xem việc cập nhật có thành công không
        if (updateSuccess) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Cập nhật thành công!\"}");
        } else {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Không thể cập nhật vai trò\"}");
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