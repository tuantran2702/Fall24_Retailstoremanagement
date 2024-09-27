package controllers;

import dao.ImportDAO;
import model.Import;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.Inventory;

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
            request.getRequestDispatcher("/ImportController/updateImport.jsp").forward(request, response);
        } else if (action.equals("create")) {
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
        // Giả sử bạn có logic để lấy Inventory ID
        int inventoryID =Integer.parseInt(request.getParameter("inventoryID"));// Hàm tự định nghĩa để lấy Inventory ID
        Date importDate = Date.valueOf(request.getParameter("importDate"));
        double unitCost = Double.parseDouble(request.getParameter("unitCost"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String supplierName = request.getParameter("supplierName");

        Import imp = new Import(0, productID, inventoryID, importDate, unitCost, quantity, supplierName);
        importDAO.createImport(imp);
        response.sendRedirect(request.getContextPath() + "/import");
        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int inventoryID = Integer.parseInt(request.getParameter("inventoryID"));
            Date importDate = Date.valueOf(request.getParameter("importDate"));
            double unitCost = Double.parseDouble(request.getParameter("unitCost"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String supplierName = request.getParameter("supplierName");

            Import imp = new Import(id, productID, inventoryID, importDate, unitCost, quantity, supplierName);
            importDAO.updateImport(imp);
            response.sendRedirect(request.getContextPath() + "/import");
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            importDAO.deleteImport(id);
            response.sendRedirect(request.getContextPath() + "/import");
        }
    }
}
