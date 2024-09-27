package controllers;

import dao.InventoryDAO;
import model.Inventory;
import model.Product;
import model.Warehouse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class InventoryController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        InventoryDAO inventoryDAO = new InventoryDAO();

        if (action == null) {
            request.setAttribute("data", inventoryDAO.getListInventory());
            request.getRequestDispatcher("/InventoryController/inventoryList.jsp").forward(request, response);
        } else if ("edit".equals(action) && idStr != null) {
            int id = Integer.parseInt(idStr);
            Inventory inventory = inventoryDAO.getInventoryById(id);
            request.setAttribute("inventory", inventory);
            
            // Fetch products and warehouses for dropdowns
            List<Product> products = inventoryDAO.getAllProducts();
            List<Warehouse> warehouses = inventoryDAO.getAllWarehouses();
            request.setAttribute("products", products);
            request.setAttribute("warehouses", warehouses);
            
            request.getRequestDispatcher("/InventoryController/updateInventory.jsp").forward(request, response);
        } else if ("create".equals(action)) {
            List<Product> products = inventoryDAO.getAllProducts();
            List<Warehouse> warehouses = inventoryDAO.getAllWarehouses();
            request.setAttribute("products", products);
            request.setAttribute("warehouses", warehouses);
            request.getRequestDispatcher("/InventoryController/createInventory.jsp").forward(request, response);
        } else if ("delete".equals(action) && idStr != null) {
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/InventoryController/deleteInventory.jsp").forward(request, response);
        }
    }

 
  @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    InventoryDAO inventoryDAO = new InventoryDAO();

    if ("create".equals(action)) {
        int productID = Integer.parseInt(request.getParameter("productID"));
        int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Inventory inventory = new Inventory();
        inventory.setProductID(productID);
        inventory.setWarehouseID(warehouseID);
        inventory.setQuantity(quantity);
        inventory.setLastUpdated(new Date());
        inventoryDAO.createInventory(inventory);
        response.sendRedirect("inventory");
    } else if ("update".equals(action)) {
        try {
            int id = Integer.parseInt(request.getParameter("inventoryID"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            Inventory inventory = new Inventory();
            inventory.setInventoryID(id);
            inventory.setProductID(productID);
            inventory.setWarehouseID(warehouseID);
            inventory.setQuantity(quantity);
            inventory.setLastUpdated(new Date());
            inventoryDAO.updateInventory(inventory);
            response.sendRedirect("inventory");
        } catch (NumberFormatException e) {
            // Xử lý nếu có lỗi khi chuyển đổi chuỗi thành số
            request.setAttribute("errorMessage", "Invalid input. Please ensure all fields are filled correctly.");
            request.getRequestDispatcher("/InventoryController/updateInventory.jsp").forward(request, response);
        }
    } else if ("delete".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        inventoryDAO.deleteInventory(id);
        response.sendRedirect("inventory");
    }
}


    @Override
    public String getServletInfo() {
        return "Inventory Controller";
    }
}