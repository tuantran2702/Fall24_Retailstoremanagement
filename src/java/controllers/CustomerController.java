package controllers;

import dao.CustomerDAO;
import dao.CustomerRankDAO;
import model.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CustomerController", urlPatterns = {"/customer"})
public class CustomerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        CustomerDAO customerDAO = new CustomerDAO();
        CustomerRankDAO customerRankDAO = new CustomerRankDAO();

        if (action == null) {
            // Display list of customers
            request.setAttribute("data", customerDAO.getListCustomers());
            request.getRequestDispatcher("/CustomerManager/Customer/CustomerManager.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            // Edit customer
            int id = Integer.parseInt(idStr);
            Customer customer = customerDAO.getCustomerById(id);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.setAttribute("ranks", customerRankDAO.getListCustomerRank());
                request.getRequestDispatcher("/CustomerManager/Customer/updateCustomer.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/customer");
            }
        } else if (action.equals("create")) {
            // Create new customer
            request.setAttribute("ranks", customerRankDAO.getListCustomerRank());
            request.getRequestDispatcher("/CustomerManager/Customer/createCustomer.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Delete customer confirmation
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/CustomerManager/Customer/deleteCustomer.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        CustomerDAO customerDAO = new CustomerDAO();

        if (action.equals("create")) {
            // Tạo mới khách hàng
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

            Customer customer = new Customer();
            customer.setFirstName(firstName);
            customer.setLastName(lastName);
            customer.setEmail(email);
            customer.setPhoneNumber(phoneNumber);
            customer.setAddress(address);
            customer.setRankID(1); // Thiết lập RankID mặc định là 1
            customer.setTotalSpent(0.0); // Thiết lập TotalSpent mặc định là 0

            customerDAO.createCustomer(customer);
            response.sendRedirect(request.getContextPath() + "/customer");
        } else if (action.equals("update")) {
            // Update existing customer
            int id = Integer.parseInt(request.getParameter("id"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

//            double totalSpent = Double.parseDouble(request.getParameter("totalSpent"));
//            int rankID = Integer.parseInt(request.getParameter("rankID"));

            Customer customer = new Customer();
            customer.setCustomerID(id);
            customer.setFirstName(firstName);
            customer.setLastName(lastName);
            customer.setEmail(email);
            customer.setPhoneNumber(phoneNumber);
            customer.setAddress(address);
//            customer.setTotalSpent(totalSpent);
//            customer.setRankID(rankID);

            customerDAO.updateCustomer(customer);
            response.sendRedirect(request.getContextPath() + "/customer");
        } else if (action.equals("delete")) {
            // Delete customer
            int id = Integer.parseInt(request.getParameter("id"));
            customerDAO.deleteCustomer(id);
            response.sendRedirect(request.getContextPath() + "/customer");
        }
    }

    @Override
    public String getServletInfo() {
        return "CustomerController handles CRUD operations for Customer entities.";
    }
}
