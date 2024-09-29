package controllers;

import dao.InventoryDAO;
import model.Inventory;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

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
        String search = request.getParameter("search");
        InventoryDAO inventoryDAO = new InventoryDAO();

        if (action == null) {
            request.setAttribute("data", inventoryDAO.getListInventory());
            request.getRequestDispatcher("/InventoryController/inventoryList.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            int id = Integer.parseInt(idStr);
            Inventory inventory = inventoryDAO.getInventoryById(id);
            request.setAttribute("inventory", inventory);
            request.getRequestDispatcher("/InventoryController/updateInventory.jsp").forward(request, response);
        } else if (action.equals("create")) {
            request.getRequestDispatcher("/InventoryController/updateInventory.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
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

        if (action.equals("create")) {
            String productName = request.getParameter("ProductName");
            String warehouseName = request.getParameter("WarehouseName");
            int quantity = Integer.parseInt(request.getParameter("Quantity"));
            Date lastUpdated = new Date();

            int productID = getProductID(productName); // Implement this method to get productID
            int warehouseID = getWarehouseID(warehouseName); // Implement this method to get warehouseID

            Inventory inventory = new Inventory();
            inventory.setProductID(productID);
            inventory.setWarehouseID(warehouseID);
            inventory.setQuantity(quantity);
            inventory.setLastUpdated(lastUpdated);

            inventoryDAO.createInventory(inventory);
            response.sendRedirect(request.getContextPath() + "/inventory");
        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("Quantity"));
            Date lastUpdated = new Date();

            Inventory inventory = new Inventory();
            inventory.setInventoryID(id);
            inventory.setQuantity(quantity);
            inventory.setLastUpdated(lastUpdated);

            inventoryDAO.updateInventory(inventory);
            response.sendRedirect(request.getContextPath() + "/inventory");
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            inventoryDAO.deleteInventory(id);
            response.sendRedirect(request.getContextPath() + "/inventory");
        }
    }

    private int getProductID(String productName) {
        // Implement this method to retrieve productID from productName
        return 0;
    }

    private int getWarehouseID(String warehouseName) {
        // Implement this method to retrieve warehouseID from warehouseName
        return 0;
    }
}
