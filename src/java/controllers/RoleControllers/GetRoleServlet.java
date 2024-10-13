/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.RoleControllers;

import com.google.gson.Gson;
import dao.RoleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

        // Chuyển đổi đối tượng Role thành JSON và trả về cho client
        Gson gson = new Gson();
        String json = gson.toJson(role);
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
        // Thu thập dữ liệu từ form
        int roleID = Integer.parseInt(request.getParameter("roleID"));
        String roleName = request.getParameter("roleName");
        String description = request.getParameter("description");

        // Tạo đối tượng Role mới và gán giá trị
        Role role = new Role();
        role.setRoleID(roleID);
        role.setRoleName(roleName);
        role.setDescription(description);

        // Cập nhật vai trò trong cơ sở dữ liệu
        RoleDAO roleDAO = new RoleDAO();
        boolean success = roleDAO.updateRole(role);

        // Kiểm tra xem cập nhật có thành công không
        if (success) {
            response.setStatus(HttpServletResponse.SC_OK); // Trả về mã thành công
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Trả về mã lỗi
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
