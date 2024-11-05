package controllers;

import dao.CategoryDAO;
import model.Category;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

public class CategoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            // Example code to output a sample page
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CategoryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CategoryController at " + request.getContextPath() + "</h1>");
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
        String keyword = request.getParameter("keyword");
        String categoryIDStr = request.getParameter("categoryID");
        Integer categoryID = null;

        // Chuyển đổi categoryID từ String sang Integer
        if (categoryIDStr != null && !categoryIDStr.isEmpty()) {
            try {
                categoryID = Integer.parseInt(categoryIDStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                // Xử lý lỗi nếu cần, có thể đặt categoryID về null hoặc thông báo lỗi
            }
        }

        CategoryDAO categoryDAO = new CategoryDAO();

        // Lấy danh sách danh mục để hiển thị trong dropdown
        List<Category> listCategory = categoryDAO.getListCategory();
        request.setAttribute("listCategory", listCategory);

        if (action == null) {
            // Hiển thị danh sách danh mục với chức năng tìm kiếm
            List<Category> categories = categoryDAO.searchCategories(keyword, categoryID);
            request.setAttribute("data", categories);
            request.getRequestDispatcher("/CategoryManager/listCategory.jsp").forward(request, response);
        } else if (action.equals("update") && idStr != null) {
            // Chỉnh sửa danh mục
            int id = Integer.parseInt(idStr);
            Category c = categoryDAO.getCategoryById(id);
            request.setAttribute("category", c);
            request.getRequestDispatcher("/CategoryManager/updateCategory.jsp").forward(request, response);
        } else if (action.equals("create")) {
            // Tạo danh mục mới
            request.getRequestDispatcher("/CategoryManager/createCategory.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Xóa danh mục
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.deleteCategory(id);
            response.sendRedirect("category");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("create")) {
            // Create new category
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");

            CategoryDAO categoryDAO = new CategoryDAO();

            if (categoryDAO.isCategoryExists(categoryName)) {
                request.setAttribute("errorMessage", "Tên danh mục đã tồn tại. Vui lòng chọn tên khác.");
                request.getRequestDispatcher("/CategoryManager/createCategory.jsp").forward(request, response);
                return;
            }

            Category category = new Category(0, categoryName, description);
            CategoryDAO c = new CategoryDAO();
            c.createCategory(category);
            response.sendRedirect("category");

        } else if (action.equals("update")) {
            // Update existing category
            int id = Integer.parseInt(request.getParameter("id"));
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");

            Category category = new Category(id, categoryName, description);

            CategoryDAO c = new CategoryDAO();
            c.updateCategory(category);
            response.sendRedirect("category");
        } else if ("createCategoryName".equals(action)) {
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
