/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.PermissionsDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Product;
import model.User;

/**
 *
 * @author trant
 */
public class ProductController extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //Xử lí Phân Quyền
        String END_POINT = "PRODUCT-MANAGE";
        if (request.getSession().getAttribute("User") != null) {
            PermissionsDAO pd = new PermissionsDAO();
            User u = (User) request.getSession().getAttribute("User");
            if (!pd.isAccess(u, END_POINT)) {
                response.sendRedirect("404.jsp");
                return;
            }
        } else {
            response.sendRedirect("404.jsp");
            return;
        }
        
//        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
//        out.print(action);

        if (action == null) {
            ProductDAO product = new ProductDAO();
            request.setAttribute("data", product.getListProduct());
            request.getRequestDispatcher("/ProductManager/listProduct.jsp").forward(request, response);

        } else if (action.equals("create")) {
            ProductDAO product = new ProductDAO();
            request.setAttribute("listCategory", product.GetListCategory());
            request.setAttribute("listUser", product.GetListUser());
            request.setAttribute("listUnit", product.GetListUnit());
            request.setAttribute("listSupplier", product.GetListSupplier());
            request.getRequestDispatcher("/ProductManager/createProduct.jsp").forward(request, response);
//            out.print(product.GetListCategory());
        } else if (action.equals("update") && idStr != null) {
            int id = Integer.parseInt(idStr);
            ProductDAO product = new ProductDAO();
            request.setAttribute("listCategory", product.GetListCategory());
            request.setAttribute("listUser", product.GetListUser());
            request.setAttribute("listUnit", product.GetListUnit());
            request.setAttribute("listSupplier", product.GetListSupplier());
            Product p = product.getProductById(id);
            request.setAttribute("product", p);
            request.getRequestDispatcher("/ProductManager/updateProduct.jsp").forward(request, response);
//                        out.print(product.getProductById(id));
        } else if (action.equals("delete") && idStr != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDAO product = new ProductDAO();
            product.deleteProduct(id);
            response.sendRedirect("product");

        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        if (action.equals("create")) {
            String productCode = request.getParameter("productCode");
            String productName = request.getParameter("productName");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            int userID = Integer.parseInt(request.getParameter("userID"));
            int unitID = Integer.parseInt(request.getParameter("unitID"));
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//                        Date createdDate = new Date(), expiredDate = null, updateDate = null;
            Date createdDate = new Date(), expiredDate = null, updateDate = new Date();

            try {
//                createdDate = dateFormat.parse(request.getParameter("createdDate"));
                expiredDate = dateFormat.parse(request.getParameter("expiredDate"));
            } catch (ParseException e) {
                e.printStackTrace();
            }

            Product product = new Product(0, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID);
            ProductDAO p = new ProductDAO();

            p.createProduct(product);
            response.sendRedirect("product");

        } else if (action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String productCode = request.getParameter("productCode");
            String productName = request.getParameter("productName");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            if (image == null || image.isEmpty()) {
                ProductDAO product = new ProductDAO();
                Product p = product.getProductById(id);
                image = p.getImage();

            }
            int userID = Integer.parseInt(request.getParameter("userID"));
            int unitID = Integer.parseInt(request.getParameter("unitID"));
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date createdDate = null, expiredDate = null, updateDate = new Date();

//            out.print(image);
//            out.print(productCode);
            try {
                createdDate = dateFormat.parse(request.getParameter("createdDate"));
                expiredDate = dateFormat.parse(request.getParameter("expiredDate"));
            } catch (ParseException e) {
                e.printStackTrace();
            }

            Product product = new Product(id, productCode, productName, categoryID, price, quantity, description, createdDate, expiredDate, updateDate, image, userID, unitID, supplierID);
            ProductDAO p = new ProductDAO();
            int importInventory = p.getInventoryQuantityByProductId(product.getProductID());

            // Nếu số lượng sản phẩm lớn hơn số lượng nhập
            if (quantity > importInventory) {
                // Gửi thông báo lỗi và chuyển về trang update
                request.setAttribute("error", "Số lượng sản phẩm không được vượt quá số lượng Inventory." + importInventory);
                request.setAttribute("product", product); // Gửi lại đối tượng Product với dữ liệu hiện tại
                request.setAttribute("listCategory", p.GetListCategory());
                request.setAttribute("listUser", p.GetListUser());
                request.setAttribute("listUnit", p.GetListUnit());
                request.setAttribute("listSupplier", p.GetListSupplier());
                request.getRequestDispatcher("/ProductManager/updateProduct.jsp").forward(request, response);
            } else {
                // Nếu đúng điều kiện thì tạo sản phẩm
                p.updateProduct(product);
                response.sendRedirect("product");
            }

        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}