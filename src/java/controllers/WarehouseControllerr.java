package controllers;

import java.io.PrintWriter;
import dao.WarehouseDAO;
import model.Warehouse;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class WarehouseControllerr extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String search = request.getParameter("search");

        WarehouseDAO warehouseDAO = new WarehouseDAO();
        ArrayList<Warehouse> warehouses;

        if (search != null && !search.isEmpty()) {
            warehouses = warehouseDAO.searchWarehouses(search);
        } else {
            warehouses = warehouseDAO.getListWarehouse();
        }

        if (action == null) {
            request.setAttribute("data", warehouses);
            request.getRequestDispatcher("/warehouseController/warehouseList.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            int id = Integer.parseInt(idStr);
            Warehouse warehouse = warehouseDAO.getWarehouseById(id);
            request.setAttribute("warehouse", warehouse);
            request.getRequestDispatcher("/warehouseController/updateWarehouse.jsp").forward(request, response);
        } else if (action.equals("create")) {
            request.getRequestDispatcher("/warehouseController/createWarehouse.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
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
        } else if (action.equals("update")) {
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
        } else if (action.equals("delete")) {
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