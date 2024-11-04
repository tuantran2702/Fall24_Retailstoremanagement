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
import java.util.List;
import com.google.gson.Gson;

public class ImportController extends HttpServlet {
    private final ImportDAO importDAO = new ImportDAO();
    private final Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("getInventories".equals(request.getServletPath())) {
            handleGetInventories(request, response);
            return;
        }

        try {
            switch (action == null ? "list" : action) {
                case "list":
                    listImports(request, response);
                    break;
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    showDeleteForm(request, response);
                    break;
                default:
                    listImports(request, response);
                    break;
            }
        } catch (Exception e) {
            System.out.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/ImportManager/importList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "create":
                    createImport(request, response);
                    break;
                case "update":
                    updateImport(request, response);
                    break;
                case "delete":
                    deleteImport(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/import");
                    break;
            }
        } catch (Exception e) {
            System.out.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/ImportManager/importList.jsp").forward(request, response);
        }
    }

    private void listImports(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Import> imports = importDAO.getListImport();
        request.setAttribute("data", imports);
        request.getRequestDispatcher("/ImportManager/importList.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Product> products = importDAO.getAllProducts();
        List<Supplier> suppliers = importDAO.getAllSuppliers();
        request.setAttribute("products", products);
        request.setAttribute("suppliers", suppliers);
        request.getRequestDispatcher("/ImportManager/createImport.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Import imp = importDAO.getImportById(id);
        if (imp != null) {
            List<Product> products = importDAO.getAllProducts();
            List<Inventory> inventories = importDAO.getInventoriesByProductId(imp.getProductID());
            List<Supplier> suppliers = importDAO.getAllSuppliers();
            
            request.setAttribute("importt", imp);
            request.setAttribute("products", products);
            request.setAttribute("inventories", inventories);
            request.setAttribute("suppliers", suppliers);
            request.getRequestDispatcher("/ImportManager/updateImport.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không tìm thấy đơn nhập hàng");
            response.sendRedirect(request.getContextPath() + "/import");
        }
    }

    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        request.setAttribute("id", id);
        request.getRequestDispatcher("/ImportManager/deleteImport.jsp").forward(request, response);
    }

    private void createImport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            int inventoryID = Integer.parseInt(request.getParameter("inventoryID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            // Validate product exists
            String productName = importDAO.getProductNameById(productID);
            if (productName == null) {
                request.setAttribute("error", "Sản phẩm không tồn tại");
                showCreateForm(request, response);
                return;
            }

            // Parse other fields
            Date importDate = Date.valueOf(request.getParameter("importDate"));
            double unitCost = Double.parseDouble(request.getParameter("unitCost"));
            String supplierName = request.getParameter("supplierName");
            double totalCost = unitCost * quantity;

            // Create import object
            Import imp = new Import(0, productID, productName, inventoryID, 
                                  importDate, unitCost, quantity, totalCost, supplierName);

            // Save to database
            importDAO.createImport(imp);
            
            request.setAttribute("success", "Đã nhập hàng thành công cho sản phẩm: " + productName);
            listImports(request, response);
            
        } catch (NumberFormatException e) {
            System.out.println("Error parsing numbers: " + e.getMessage());
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            showCreateForm(request, response);
        } catch (Exception e) {
            System.out.println("Error creating import: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi nhập hàng: " + e.getMessage());
            showCreateForm(request, response);
        }
    }

    private void updateImport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int inventoryID = Integer.parseInt(request.getParameter("inventoryID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            String productName = importDAO.getProductNameById(productID);
            Date importDate = Date.valueOf(request.getParameter("importDate"));
            double unitCost = Double.parseDouble(request.getParameter("unitCost"));
            String supplierName = request.getParameter("supplierName");
            double totalCost = unitCost * quantity;

            Import imp = new Import(id, productID, productName, inventoryID, 
                                  importDate, unitCost, quantity, totalCost, supplierName);
            
            importDAO.updateImport(imp);
            response.sendRedirect(request.getContextPath() + "/import");
            
        } catch (Exception e) {
            System.out.println("Error updating import: " + e.getMessage());
            request.setAttribute("error", "Lỗi khi cập nhật: " + e.getMessage());
            showEditForm(request, response);
        }
    }

    private void deleteImport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            importDAO.deleteImport(id);
            response.sendRedirect(request.getContextPath() + "/import");
        } catch (Exception e) {
            System.out.println("Error deleting import: " + e.getMessage());
            request.setAttribute("error", "Lỗi khi xóa: " + e.getMessage());
            showDeleteForm(request, response);
        }
    }

    private void handleGetInventories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            List<Inventory> inventories = importDAO.getInventoriesByProductId(productId);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(inventories));
            
        } catch (Exception e) {
            System.out.println("Error getting inventories: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error getting inventories: " + e.getMessage());
        }
    }
}