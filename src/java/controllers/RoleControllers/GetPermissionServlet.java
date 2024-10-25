/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.RoleControllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import dao.PermissionsDAO;
import dao.RoleDAO;
import java.util.*;
import model.Permissions;
import model.Role;

/**
 *
 * @author ptrung
 */
public class GetPermissionServlet extends HttpServlet {

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
            out.println("<title>Servlet GetPermissionServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetPermissionServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int permissionID = Integer.parseInt(request.getParameter("id"));
        
        // Gọi service hoặc DAO để lấy thông tin quyền dựa trên permissionID
        PermissionsDAO pd = new PermissionsDAO();
        Permissions permission = pd.getPermissionById(permissionID);
        
        if (permission != null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(permission)); // Chuyển đối tượng permission thành JSON
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Permission not found\"}");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int permissionID = Integer.parseInt(request.getParameter("permissionID"));
        String permissionName = request.getParameter("permissionName");
        
        // Tạo đối tượng Permission và cập nhật thông tin
        Permissions permission = new Permissions(permissionID, permissionName);
        
        // Gọi service hoặc DAO để cập nhật quyền
        PermissionsDAO pd = new PermissionsDAO();
        boolean success = pd.updatePermission(permission);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (success) {
            response.getWriter().write("{\"status\":\"success\", \"message\":\"Permission updated successfully\"}");
        } else {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Failed to update permission\"}");
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
