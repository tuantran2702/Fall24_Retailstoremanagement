package controllers;

import dao.InventoryDAO;
import model.Inventory;
import model.Product;
import model.Warehouse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class InventoryController extends HttpServlet {
    private final InventoryDAO inventoryDAO = new InventoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String searchTerm = request.getParameter("search");
        HttpSession session = request.getSession();

        try {
            switch (action == null ? "list" : action) {
                case "list":
                    handleList(request, response, searchTerm);
                    break;
                case "create":
                    handleShowCreate(request, response);
                    break;
                case "edit":
                    handleShowEdit(request, response, idStr);
                    break;
                case "delete":
                    handleShowDelete(request, response, idStr);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/inventory");
                    break;
            }
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/inventory");
        }
    }

  @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    HttpSession session = request.getSession();

    try {
        switch (action) {
            case "create":
                handleCreate(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            case "deleteAll": // Thêm trường hợp xóa tất cả
                handleDeleteAll(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/inventory");
                break;
        }
    } catch (Exception e) {
        session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        response.sendRedirect(request.getContextPath() + "/inventory");
    }
}


private void handleDeleteAll(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    inventoryDAO.deleteAllInventories(); // Gọi phương thức xóa tất cả
    HttpSession session = request.getSession();
    session.setAttribute("successMessage", "Đã xóa tất cả các mục trong kho!");
    response.sendRedirect(request.getContextPath() + "/inventory");
}
    private void handleList(HttpServletRequest request, HttpServletResponse response, String searchTerm) 
            throws ServletException, IOException {
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            request.setAttribute("data", inventoryDAO.searchInventories(searchTerm.trim()));
            request.setAttribute("searchTerm", searchTerm);
        } else {
            request.setAttribute("data", inventoryDAO.getListInventory());
        }
        request.getRequestDispatcher("/InventoryManager/inventoryList.jsp").forward(request, response);
    }

    private void handleShowCreate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Product> products = inventoryDAO.getAllProducts();
        List<Warehouse> warehouses = inventoryDAO.getAllWarehouses();
        request.setAttribute("products", products);
        request.setAttribute("warehouses", warehouses);
        request.getRequestDispatcher("/InventoryManager/createInventory.jsp").forward(request, response);
    }

    private void handleShowEdit(HttpServletRequest request, HttpServletResponse response, String idStr) 
            throws ServletException, IOException {
        if (idStr != null && !idStr.trim().isEmpty()) {
            int id = Integer.parseInt(idStr);
            Inventory inventory = inventoryDAO.getInventoryById(id);
            if (inventory != null) {
                List<Product> products = inventoryDAO.getAllProducts();
                List<Warehouse> warehouses = inventoryDAO.getAllWarehouses();
                request.setAttribute("inventory", inventory);
                request.setAttribute("products", products);
                request.setAttribute("warehouses", warehouses);
                request.getRequestDispatcher("/InventoryManager/updateInventory.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/inventory");
    }

    private void handleShowDelete(HttpServletRequest request, HttpServletResponse response, String idStr) 
            throws ServletException, IOException {
        if (idStr != null && !idStr.trim().isEmpty()) {
            int id = Integer.parseInt(idStr);
            Inventory inventory = inventoryDAO.getInventoryById(id);
            if (inventory != null) {
                request.setAttribute("inventory", inventory);
                request.getRequestDispatcher("/InventoryManager/deleteInventory.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/inventory");
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int productID = Integer.parseInt(request.getParameter("productID"));
        int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));

        // Kiểm tra trùng lặp
        if (inventoryDAO.isProductAndWarehouseExist(productID, warehouseID)) {
            session.setAttribute("errorMessage", "Sản phẩm đã tồn tại trong kho này!");
            response.sendRedirect(request.getContextPath() + "/inventory?action=create");
            return;
        }

        // Tạo mới inventory
        Inventory inventory = new Inventory();
        inventory.setProductID(productID);
        inventory.setWarehouseID(warehouseID);
        inventory.setQuantity(0); // Số lượng mặc định khi tạo mới
        inventory.setLastUpdated(new Date());
        
        inventoryDAO.createInventory(inventory);
        session.setAttribute("successMessage", "Thêm mới thành công!");
        response.sendRedirect(request.getContextPath() + "/inventory");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("inventoryID"));
        int productID = Integer.parseInt(request.getParameter("productID"));
        int warehouseID = Integer.parseInt(request.getParameter("warehouseID"));

        // Lấy inventory hiện tại và cập nhật
        Inventory inventory = inventoryDAO.getInventoryById(id);
        if (inventory != null) {
            inventory.setProductID(productID);
            inventory.setWarehouseID(warehouseID);
            inventory.setLastUpdated(new Date());
            
            inventoryDAO.updateInventory(inventory);
            session.setAttribute("successMessage", "Cập nhật thành công!");
        } else {
            session.setAttribute("errorMessage", "Không tìm thấy inventory!");
        }
        response.sendRedirect(request.getContextPath() + "/inventory");
    }

 private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    String idStr = request.getParameter("id");
    if (idStr != null && !idStr.trim().isEmpty()) {
        int id = Integer.parseInt(idStr);
        // Gọi phương thức xóa mà không cần kiểm tra
        inventoryDAO.deleteInventory(id);
    }
    // Sau khi xóa, điều hướng về danh sách
    response.sendRedirect(request.getContextPath() + "/inventory");
}


    @Override
    public String getServletInfo() {
        return "Inventory Controller";
    }
}