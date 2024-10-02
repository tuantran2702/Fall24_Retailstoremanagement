package controllers;

import dao.CustomerRankDAO;
import model.CustomerRank;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CustomerRankController", urlPatterns = {"/customerRank"})
public class CustomerRankController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerRankController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerRankController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        CustomerRankDAO customerRankDAO = new CustomerRankDAO();

        if (action == null) {
            // Display list of customer ranks
            request.setAttribute("data", customerRankDAO.getListCustomerRank());
            request.getRequestDispatcher("/CustomerManager/CustomerRank/CustomerRankManager.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            // Edit customer rank
            int id = Integer.parseInt(idStr);
            CustomerRank customerRank = customerRankDAO.getCustomerRankById(id);
            request.setAttribute("customerRank", customerRank);
            request.getRequestDispatcher("/CustomerManager/CustomerRank/updateCustomerRank.jsp").forward(request, response);
        } else if (action.equals("create")) {
            // Create new customer rank
            request.getRequestDispatcher("/CustomerManager/CustomerRank/createCustomerRank.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Delete customer rank confirmation
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/CustomerManager/CustomerRank/deleteCustomerRank.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        CustomerRankDAO customerRankDAO = new CustomerRankDAO();

        if (action.equals("create")) {
            // Create new customer rank
            String name = request.getParameter("name");
            double minimumSpent = Double.parseDouble(request.getParameter("minimumSpent"));
            String description = request.getParameter("description");

            CustomerRank customerRank = new CustomerRank();
            customerRank.setRankName(name);
            customerRank.setMinimumSpent(minimumSpent);
            customerRank.setDescription(description);

            customerRankDAO.createCustomerRank(customerRank);
            response.sendRedirect(request.getContextPath() + "/customerRank");
        } else if (action.equals("update")) {
            // Update existing customer rank
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double minimumSpent = Double.parseDouble(request.getParameter("minimumSpent"));
            String description = request.getParameter("description");

            CustomerRank customerRank = new CustomerRank();
            customerRank.setRankID(id);
            customerRank.setRankName(name);
            customerRank.setMinimumSpent(minimumSpent);
            customerRank.setDescription(description);

            customerRankDAO.updateCustomerRank(customerRank);
            response.sendRedirect(request.getContextPath() + "/customerRank");
        } else if (action.equals("delete")) {
            // Delete customer rank
            int id = Integer.parseInt(request.getParameter("id"));
            customerRankDAO.deleteCustomerRank(id);
            response.sendRedirect(request.getContextPath() + "/customerRank");
        }
    }

    @Override
    public String getServletInfo() {
        return "CustomerRankController handles CRUD operations for Customer Rank entities.";
    }
}
