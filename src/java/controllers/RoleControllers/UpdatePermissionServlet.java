/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.RoleControllers;

import com.google.gson.Gson;
import dao.PermissionsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;
import model.Permissions;

/**
 *
 * @author ptrung
 */
public class UpdatePermissionServlet extends HttpServlet {

    private PermissionsDAO permissionDAO = new PermissionsDAO();

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
        
        String permissionID = request.getParameter("id");

        if ( permissionID != null) {
            Permissions permission = permissionDAO.getPermissionById(Integer.parseInt(permissionID));
            if (permission != null) {
                String json = new Gson().toJson(permission);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Permission not found\"}");
            }
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
        String action = request.getParameter("action");

        if ("updatePermission".equals(action)) {
            updatePermission(request, response);
        } else if ("deletePermission".equals(action)) {
            deletePermission(request, response);
        }
    }

    private void updatePermission(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int permissionID = Integer.parseInt(request.getParameter("permissionID"));
        String permissionName = request.getParameter("permissionName");

        Permissions permission = new Permissions(permissionID, permissionName);
        boolean isUpdated = permissionDAO.updatePermission(permission);

        Map<String, String> jsonResponse = new HashMap<>();
        if (isUpdated) {
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Quyền đã được cập nhật thành công.");
        } else {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Không thể cập nhật quyền.");
        }
        writeJsonResponse(response, jsonResponse);
    }

    private void deletePermission(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int permissionID = Integer.parseInt(request.getParameter("id"));
        boolean isDeleted = permissionDAO.deletePermission(permissionID);

        Map<String, String> jsonResponse = new HashMap<>();
        if (isDeleted) {
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Quyền đã được xóa thành công.");
        } else {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Không thể xóa quyền.");
        }
        writeJsonResponse(response, jsonResponse);
    }

    private void writeJsonResponse(HttpServletResponse response, Map<String, String> jsonResponse) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write(new Gson().toJson(jsonResponse));
        out.flush();
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