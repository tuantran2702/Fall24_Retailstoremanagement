package controllers;

import dao.LoyaltyPointsDAO;
import model.LoyaltyPoints;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LoyaltyPointsController", urlPatterns = {"/loyalty"})
public class LoyaltyPointsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoyaltyPointsController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoyaltyPointsController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        LoyaltyPointsDAO loyaltyPointsDAO = new LoyaltyPointsDAO();

        if (action == null) {
            // Display list of loyalty points
            request.setAttribute("data", loyaltyPointsDAO.getListLoyaltyPoints());
            request.getRequestDispatcher("/CustomerManager/LoyaltyPoints/LoyaltyPointsManager.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            // Edit loyalty points entry
            int id = Integer.parseInt(idStr);
            LoyaltyPoints loyaltyPoints = loyaltyPointsDAO.getLoyaltyPointsById(id);
            request.setAttribute("loyaltyPoints", loyaltyPoints);
            request.getRequestDispatcher("/CustomerManager/LoyaltyPoints/updateLoyaltyPoints.jsp").forward(request, response);
        } else if (action.equals("create")) {
            // Create new loyalty points entry
            request.getRequestDispatcher("/CustomerManager/LoyaltyPoints/createLoyaltyPoints.jsp").forward(request, response);
        } else if (action.equals("delete") && idStr != null) {
            // Delete loyalty points confirmation
            int id = Integer.parseInt(idStr);
            request.setAttribute("id", id);
            request.getRequestDispatcher("/CustomerManager/LoyaltyPoints/deleteLoyaltyPoints.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        LoyaltyPointsDAO loyaltyPointsDAO = new LoyaltyPointsDAO();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        if (action.equals("create")) {
            try {
                int customerID = Integer.parseInt(request.getParameter("customerID"));
                int pointsEarned = Integer.parseInt(request.getParameter("pointsEarned"));
                int pointsRedeemed = Integer.parseInt(request.getParameter("pointsRedeemed"));
                Date transactionDate = dateFormat.parse(request.getParameter("transactionDate"));
                String description = request.getParameter("description");

                LoyaltyPoints lp = new LoyaltyPoints(0, customerID, pointsEarned, pointsRedeemed, transactionDate, description);
                loyaltyPointsDAO.createLoyaltyPoints(lp);
                response.sendRedirect(request.getContextPath() + "/loyalty");
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else if (action.equals("update")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int customerID = Integer.parseInt(request.getParameter("customerID"));
                int pointsEarned = Integer.parseInt(request.getParameter("pointsEarned"));
                int pointsRedeemed = Integer.parseInt(request.getParameter("pointsRedeemed"));
                Date transactionDate = dateFormat.parse(request.getParameter("transactionDate"));
                String description = request.getParameter("description");

                LoyaltyPoints lp = new LoyaltyPoints(id, customerID, pointsEarned, pointsRedeemed, transactionDate, description);
                loyaltyPointsDAO.updateLoyaltyPoints(lp);
                response.sendRedirect(request.getContextPath() + "/loyalty");
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "LoyaltyPointsController handles CRUD operations for Loyalty Points entities.";
    }
}