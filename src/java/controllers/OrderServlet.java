/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.OrderDAO;
import dao.PermissionsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Cart;
import model.Customer;
import model.Item;
import model.PaymentMethod;
import model.Product;
import model.User;

/**
 *
 * @author Admin
 */
public class OrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //Xử lí Phân Quyền
        String END_POINT = "ORDER-MANAGE";
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
        
        OrderDAO d = new OrderDAO();
        List<Product> listProduct = d.getAllListProduct();
        request.setAttribute("listProduct", listProduct);
        double total = 0;
        HttpSession session = request.getSession();
        Cart cart;
        Object o = session.getAttribute("cart");
        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();
        }
        List<Item> list = cart.getItems();
        for (Item item : list) {
            total += (item.getPrice() * item.getQuantity());
        }
        OrderDAO orderDAO = new OrderDAO();
        request.setAttribute("total", total);
        List<PaymentMethod> paymentMethods = orderDAO.getAllPaymentMethod();
        request.setAttribute("paymentMethods", paymentMethods);
        OrderDAO orderDAO1 = new OrderDAO();
        List<Customer> listCustomer = orderDAO1.getAllCustomers();
        request.setAttribute("listCustomer", listCustomer);
        
        request.getRequestDispatcher("oder1.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO dao = new OrderDAO();
        HttpSession session = request.getSession();
        Cart cart;
        Object o = session.getAttribute("cart");

        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();
        }

        String tid = request.getParameter("id");
        int id = 0;  // Default value

        try {
            if (tid != null) {
                id = Integer.parseInt(tid);
            }
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
        }

        String addtocart = request.getParameter("addtocart");

        if (addtocart != null) {
            Product p = dao.getProductById(id);
            double price = p.getPrice();

            Item t = new Item(p, 1, price);

            cart.addItem(t);

            // Calculate total
            List<Item> list = cart.getItems();

            session.setAttribute("cart", cart);
            session.setAttribute("size", list.size());
        }
        doGet(request, response);
    }

}
