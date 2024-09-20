/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */



package controllers;
import java.io.PrintWriter;
import dao.WarehouseDAO;
import model.Warehouse;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class WarehouseController extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Existing code to output a sample page
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet WarehouseController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WarehouseController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // Handles the HTTP GET method.
 protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if (action == null) {
            // Display list of warehouses
            WarehouseDAO warehouseDAO = new WarehouseDAO();
            request.setAttribute("data", warehouseDAO.getListWarehouse());
            request.getRequestDispatcher("/warehouseController/warehouseList.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            // Edit warehouse
            int id = Integer.parseInt(idStr);
            WarehouseDAO warehouseDAO = new WarehouseDAO();
            Warehouse warehouse = warehouseDAO.getWarehouseById(id);
            request.setAttribute("warehouse", warehouse);
            request.getRequestDispatcher("/warehouseController/updateWarehouse.jsp").forward(request, response);
        } else if (action.equals("create")) {
            // Create new warehouse
            request.getRequestDispatcher("/warehouseController/createWarehouse.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Delete warehouse
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/warehouseController/deleteWarehouse.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("create")) {
            // Create new warehouse
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String manager = request.getParameter("manager");
            String contact = request.getParameter("contact");

            Warehouse warehouse = new Warehouse();
            warehouse.setWarehouseName(name);
            warehouse.setLocation(location);
            warehouse.setManagerName(manager);
            warehouse.setContactNumber(contact);

            WarehouseDAO warehouseDAO = new WarehouseDAO();
            warehouseDAO.createWarehouse(warehouse);
            response.sendRedirect(request.getContextPath() + "/warehouse");
        }
        else if (action.equals("update")) {
            // Update existing warehouse
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String manager = request.getParameter("manager");
            String contact = request.getParameter("contact");

            Warehouse warehouse = new Warehouse();
            warehouse.setWarehouseID(id);
            warehouse.setWarehouseName(name);
            warehouse.setLocation(location);
            warehouse.setManagerName(manager);
            warehouse.setContactNumber(contact);

            WarehouseDAO warehouseDAO = new WarehouseDAO();
            warehouseDAO.updateWarehouse(warehouse);
            response.sendRedirect(request.getContextPath() + "/warehouse");
        } 
        else if (action.equals("delete")) {
            // Delete warehouse
            int id = Integer.parseInt(request.getParameter("id"));
            WarehouseDAO warehouseDAO = new WarehouseDAO();
            warehouseDAO.deleteWarehouse(id);
            response.sendRedirect(request.getContextPath() + "/warehouse");
        }
    }

    @Override
    public String getServletInfo() {
        return "WarehouseController handles CRUD operations for warehouse entities.";
    }
}

