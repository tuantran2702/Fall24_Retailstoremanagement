package controllers;

import dao.CategoryDAO;
import model.Category;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CategoryController extends HttpServlet {

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
            // Example code to output a sample page
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CategoryController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CategoryController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // Handles the HTTP GET method.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if (action == null) {
            // Display list of categories
            CategoryDAO categoryDAO = new CategoryDAO();
            request.setAttribute("data", categoryDAO.getListCategory());
            request.getRequestDispatcher("/CategoryManager/listCategory.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            // Edit category
            int id = Integer.parseInt(idStr);
            CategoryDAO categoryDAO = new CategoryDAO();
            Category category = categoryDAO.getCategoryById(id);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/category/updateCategory.jsp").forward(request, response);
        } else if (action.equals("create")) {
            // Create new category
            request.getRequestDispatcher("/category/createCategory.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Delete category
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/category/deleteCategory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("create")) {
            // Create new category
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            Category category = new Category();
            category.setCategoryName(name);
            category.setDescription(description);

            CategoryDAO categoryDAO = new CategoryDAO();
            categoryDAO.createCategory(category);
            response.sendRedirect(request.getContextPath() + "/category");
        } else if (action.equals("update")) {
            // Update existing category
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            Category category = new Category();
            category.setCategoryID(id);
            category.setCategoryName(name);
            category.setDescription(description);

            CategoryDAO categoryDAO = new CategoryDAO();
            categoryDAO.updateCategory(category);
            response.sendRedirect(request.getContextPath() + "/category");
        } else if (action.equals("delete")) {
            // Delete category
            int id = Integer.parseInt(request.getParameter("id"));
            CategoryDAO categoryDAO = new CategoryDAO();
            categoryDAO.deleteCategory(id);
            response.sendRedirect(request.getContextPath() + "/category");
        }
        else if ("createCategoryName".equals(action)) {
            // Lấy giá trị của categoryName từ form
            String categoryName = request.getParameter("categoryName");

            // Thực hiện thêm Category vào database (giả sử có một service hoặc DAO xử lý)
            CategoryDAO categoryDAO = new CategoryDAO();
            categoryDAO.addCategoryName(new Category(categoryName));

            // Chuyển hướng sau khi thêm thành công
            response.sendRedirect("product?action=create");
        }
        
    }

    @Override
    public String getServletInfo() {
        return "CategoryController handles CRUD operations for category entities.";
    }
}
