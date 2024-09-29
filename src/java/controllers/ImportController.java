package controllers;

import java.io.PrintWriter;
import dao.ImportDAO;
import model.Import;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;

public class ImportController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ImportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String search = request.getParameter("search");

        ImportDAO importDAO = new ImportDAO();
        ArrayList<Import> imports;

        // Tìm kiếm
        if (search != null && !search.isEmpty()) {
            imports = importDAO.searchImports(search);
        } else {
            imports = importDAO.getListImport();
        }

        // Điều hướng dựa trên action
        if (action == null) {
            request.setAttribute("data", imports);
            request.getRequestDispatcher("/ImportController/importList.jsp").forward(request, response);
        } else if ("edit".equals(action) && idStr != null) {
            int id = Integer.parseInt(idStr);
            Import importItem = importDAO.getImportById(id);
            request.setAttribute("importEntry", importItem);
            request.getRequestDispatcher("/ImportController/updateImport.jsp").forward(request, response);
        } else if ("create".equals(action)) {
            request.getRequestDispatcher("/ImportController/createImport.jsp").forward(request, response);
        } else if ("delete".equals(action) && idStr != null) {
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/ImportController/deleteImport.jsp").forward(request, response);
        } else {
            // Xử lý trường hợp action không hợp lệ
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action không hợp lệ");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            ImportDAO importDAO = new ImportDAO();
            if ("create".equals(action)) {
                // Tạo mới
                createOrUpdateImport(request, importDAO, null);
                response.sendRedirect(request.getContextPath() + "/import");
            } else if ("update".equals(action)) {
                // Cập nhật
                int id = Integer.parseInt(request.getParameter("id"));
                createOrUpdateImport(request, importDAO, id);
                response.sendRedirect(request.getContextPath() + "/import");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                importDAO.deleteImport(id);
                response.sendRedirect(request.getContextPath() + "/import");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra: " + e.getMessage());
        }
    }

    private void createOrUpdateImport(HttpServletRequest request, ImportDAO importDAO, Integer id) {
        int productID = Integer.parseInt(request.getParameter("productID"));
        int inventoryID = Integer.parseInt(request.getParameter("inventoryID"));
        Date importDate = new Date(request.getParameter("importDate"));
        double unitCost = Double.parseDouble(request.getParameter("unitCost"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double totalCost = unitCost * quantity;
        String supplierName = request.getParameter("supplierName");
        String productName = request.getParameter("productName");

        Import importItem = new Import(id, productID, inventoryID, importDate, unitCost, quantity, totalCost, supplierName, productName);

        if (id == null) {
            importDAO.createImport(importItem);
        } else {
            importDAO.updateImport(importItem);
        }
    }
}
