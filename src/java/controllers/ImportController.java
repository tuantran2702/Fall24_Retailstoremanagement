package controllers;

import dao.ImportDAO;
import model.Import;
import model.Inventory;
import model.Product;
import model.Supplier;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ImportController extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        ImportDAO importDAO = new ImportDAO();

        if (action == null) {
            request.setAttribute("data", importDAO.getListImport());
            request.getRequestDispatcher("/ImportController/importList.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            int id = Integer.parseInt(idStr);
            Import imp = importDAO.getImportById(id);
            request.setAttribute("importt", imp);
            
            List<Product> products = importDAO.getAllProducts();
            List<Inventory> inventories = importDAO.getAllInventories();
            List<Supplier> suppliers = importDAO.getAllSuppliers();
            
            request.setAttribute("products", products);
            request.setAttribute("inventories", inventories);
            request.setAttribute("suppliers", suppliers);
            
            request.getRequestDispatcher("/ImportController/updateImport.jsp").forward(request, response);
        } else if (action.equals("create")) {
            List<Product> products = importDAO.getAllProducts();
            List<Inventory> inventories = importDAO.getAllInventories();
            List<Supplier> suppliers = importDAO.getAllSuppliers();
            
            request.setAttribute("products", products);
            request.setAttribute("inventories", inventories);
            request.setAttribute("suppliers", suppliers);
            
            request.getRequestDispatcher("/ImportController/createImport.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/ImportController/deleteImport.jsp").forward(request, response);
        }
    }


@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ImportDAO importDAO = new ImportDAO();

        if (action.equals("create")) {
            int productID = Integer.parseInt(request.getParameter("productID"));
            int inventoryID = Integer.parseInt(request.getParameter("inventoryID"));
            
            if (!importDAO.isInventoryExist(inventoryID)) {
                request.setAttribute("error", "Inventory ID does not exist");
                doGet(request, response);
                return;
            }
            
            if (!importDAO.isProductInInventory(productID, inventoryID)) {
                request.setAttribute("error", "Product does not exist in this inventory");
                doGet(request, response);
                return;
            }
            
            String productName = importDAO.getProductNameById(productID);
            
            Date importDate = Date.valueOf(request.getParameter("importDate"));
            double unitCost = Double.parseDouble(request.getParameter("unitCost"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String supplierName = request.getParameter("supplierName");
            
            // Calculate totalCost
            double totalCost = unitCost * quantity;

Import imp = new Import(0, productID, productName, inventoryID, importDate, unitCost, quantity, totalCost, supplierName);
            importDAO.createImport(imp);
            
            request.setAttribute("success", "Import created successfully for product: " + productName);
            doGet(request, response);
        
        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            int productID = Integer.parseInt(request.getParameter("productID"));
             String productName = request.getParameter("productName");
            int inventoryID = Integer.parseInt(request.getParameter("inventoryID"));
            Date importDate = Date.valueOf(request.getParameter("importDate"));
            double unitCost = Double.parseDouble(request.getParameter("unitCost"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String supplierName = request.getParameter("supplierName");

            // Calculate totalCost
            double totalCost = unitCost * quantity;

Import imp = new Import(id, productID, productName, inventoryID, importDate, unitCost, quantity, totalCost, supplierName);
            importDAO.updateImport(imp);
            response.sendRedirect(request.getContextPath() + "/import");
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            importDAO.deleteImport(id);
            response.sendRedirect(request.getContextPath() + "/import");
        }
    }
}