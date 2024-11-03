package controllers;

import dao.CashbookDAO;
import model.Cashbook;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "CashbookController", urlPatterns = {"/cashbook"})
public class CashbookController extends HttpServlet {

@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        CashbookDAO cashbookDAO = new CashbookDAO();
        BigDecimal initialBalance = cashbookDAO.getInitialBalance();
        request.setAttribute("initialBalance", initialBalance);

        if (action == null) {
            // Xử lý tìm kiếm và lọc
            String searchTerm = request.getParameter("search");
            String transactionType = request.getParameter("type");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");

            Timestamp startDate = parseTimestamp(startDateStr, "00:00:00");
            Timestamp endDate = parseTimestamp(endDateStr, "23:59:59");

            // Lấy danh sách giao dịch
            ArrayList<Cashbook> transactions;
            if (searchTerm != null || transactionType != null || startDate != null || endDate != null) {
                transactions = cashbookDAO.searchCashbook(searchTerm, transactionType, startDate, endDate);
            } else {
                transactions = cashbookDAO.getListCashbook();
            }

            // Tính toán tổng thu chi
            BigDecimal totalIncome = cashbookDAO.getTotalIncome();
            BigDecimal totalExpense = cashbookDAO.getTotalExpense();

            // Lấy số dư hiện tại
            BigDecimal currentBalance = cashbookDAO.getCurrentBalance();

            // Đặt các thuộc tính cho view
            request.setAttribute("transactions", transactions);
            request.setAttribute("currentBalance", currentBalance);
            request.setAttribute("totalIncome", totalIncome);
            request.setAttribute("totalExpense", totalExpense);
            request.setAttribute("searchTerm", searchTerm);
            request.setAttribute("transactionType", transactionType);
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);

            // Chuyển hướng đến trang danh sách
            request.getRequestDispatcher("/cashbook/cashbookList.jsp").forward(request, response);
        } else if (action.equals("edit") && idStr != null) {
            handleEditAction(idStr, request, response, cashbookDAO);
        } else if (action.equals("create")) {
            handleCreateAction(request, response, cashbookDAO);
        } else if (action.equals("delete") && idStr != null) {
            handleDeleteAction(idStr, request, response, cashbookDAO);
        }
    }


 
  @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        CashbookDAO cashbookDAO = new CashbookDAO();

        if ("reset".equals(action)) {
            handleResetAction(request, response, cashbookDAO);
            return;
        }
        if ("updateInitialBalance".equals(action)) {
            try {
                String initialBalanceStr = request.getParameter("initialBalance");
                if (initialBalanceStr == null || initialBalanceStr.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMessage", "Vui lòng nhập số tiền!");
                    response.sendRedirect(request.getContextPath() + "/cashbook");
                    return;
                }

                BigDecimal initialBalance = new BigDecimal(initialBalanceStr);
                if (initialBalance.compareTo(BigDecimal.ZERO) < 0) {
                    request.getSession().setAttribute("errorMessage", "Số tiền không được âm!");
                    response.sendRedirect(request.getContextPath() + "/cashbook");
                    return;
                }

                boolean success = cashbookDAO.updateInitialBalance(initialBalance);
                if (success) {
                    request.getSession().setAttribute("successMessage", "Cập nhật quỹ đầu kỳ thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Không thể cập nhật quỹ đầu kỳ!");
                }

            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Số tiền không hợp lệ");
            }
            response.sendRedirect(request.getContextPath() + "/cashbook");
            return;
        }

        if (action.equals("create")) {
            handleCreatePostAction(request, response, cashbookDAO);
        } else if (action.equals("update")) {
            handleUpdatePostAction(request, response, cashbookDAO);
        } else if (action.equals("delete")) {
            handleDeletePostAction(request, response, cashbookDAO);
        }
    }

    // Hàm xử lý cập nhật giao dịch
    private void handleEditAction(String idStr, HttpServletRequest request, HttpServletResponse response, CashbookDAO cashbookDAO) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(idStr);
            Cashbook transaction = cashbookDAO.getCashbookById(id);
            if (transaction != null) {
                request.setAttribute("transaction", transaction);
                request.getRequestDispatcher("/cashbook/updateCashbook.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/cashbook");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cashbook");
        }
    }

    // Hàm xử lý tạo giao dịch
    private void handleCreateAction(HttpServletRequest request, HttpServletResponse response, CashbookDAO cashbookDAO) throws ServletException, IOException {
        BigDecimal currentBalance = cashbookDAO.getCurrentBalance();
        request.setAttribute("currentBalance", currentBalance);
        request.getRequestDispatcher("/cashbook/createCashbook.jsp").forward(request, response);
    }

    // Hàm xử lý xóa giao dịch
    private void handleDeleteAction(String idStr, HttpServletRequest request, HttpServletResponse response, CashbookDAO cashbookDAO) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(idStr);
            Cashbook transaction = cashbookDAO.getCashbookById(id);
            if (transaction != null) {
                request.setAttribute("transaction", transaction);
                request.getRequestDispatcher("/cashbook/deleteCashbook.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/cashbook");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cashbook");
        }
    }

    // Hàm xử lý POST khi tạo mới giao dịch
    private void handleCreatePostAction(HttpServletRequest request, HttpServletResponse response, CashbookDAO cashbookDAO) throws ServletException, IOException {
        try {
            Timestamp transactionDate = parseTransactionDate(request.getParameter("transactionDate"));
            String description = request.getParameter("description");
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));
            String transactionType = request.getParameter("transactionType");
            Integer orderID = parseInteger(request.getParameter("orderID"));
            Integer importID = parseInteger(request.getParameter("importID"));

            // Tính toán số dư mới
            BigDecimal currentBalance = cashbookDAO.getCurrentBalance();
            BigDecimal newBalance = transactionType.equals("Thu")
                    ? currentBalance.add(amount)
                    : currentBalance.subtract(amount);

            // Tạo đối tượng Cashbook mới
            Cashbook cashbook = new Cashbook();
            cashbook.setTransactionDate(transactionDate);
            cashbook.setDescription(description);
            cashbook.setAmount(amount);
            cashbook.setTransactionType(transactionType);
            cashbook.setBalance(newBalance);
            cashbook.setOrderID(orderID);
            cashbook.setImportID(importID);

            // Lưu vào database
            cashbookDAO.createCashbook(cashbook);
            response.sendRedirect(request.getContextPath() + "/cashbook");

        } catch (ParseException | NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/cashbook/createCashbook.jsp").forward(request, response);
        }
    }

    // Hàm xử lý POST khi cập nhật giao dịch
    private void handleUpdatePostAction(HttpServletRequest request, HttpServletResponse response, CashbookDAO cashbookDAO) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Timestamp transactionDate = parseTransactionDate(request.getParameter("transactionDate"));
            String description = request.getParameter("description");
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));
            String transactionType = request.getParameter("transactionType");
            Integer orderID = parseInteger(request.getParameter("orderID"));
            Integer importID = parseInteger(request.getParameter("importID"));

            // Tạo đối tượng Cashbook
            Cashbook cashbook = new Cashbook();
            cashbook.setTransactionID(id);
            cashbook.setTransactionDate(transactionDate);
            cashbook.setDescription(description);
            cashbook.setAmount(amount);
            cashbook.setTransactionType(transactionType);
            cashbook.setOrderID(orderID);
            cashbook.setImportID(importID);

            // Cập nhật vào database
            cashbookDAO.updateCashbook(cashbook);
            response.sendRedirect(request.getContextPath() + "/cashbook");

        } catch (ParseException | NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/cashbook/updateCashbook.jsp").forward(request, response);
        }
    }

    // Hàm xử lý POST khi xóa giao dịch
    private void handleDeletePostAction(HttpServletRequest request, HttpServletResponse response, CashbookDAO cashbookDAO) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        cashbookDAO.deleteCashbook(id);
        response.sendRedirect(request.getContextPath() + "/cashbook");
    }

    // Helper để parse Timestamp
    private Timestamp parseTimestamp(String dateStr, String defaultTime) {
        if (dateStr == null || dateStr.isEmpty()) {
            return null;
        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return new Timestamp(sdf.parse(dateStr + " " + defaultTime).getTime());
        } catch (ParseException e) {
            return null;
        }
    }

    // Helper để parse ngày giao dịch
    private Timestamp parseTransactionDate(String dateStr) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date date = sdf.parse(dateStr);
        return new Timestamp(date.getTime());
    }

    // Helper để parse Integer
    private Integer parseInteger(String intStr) {
        try {
            return Integer.parseInt(intStr);
        } catch (NumberFormatException e) {
            return null;
        }
    }
 private void handleResetAction(HttpServletRequest request, HttpServletResponse response, CashbookDAO cashbookDAO)
            throws ServletException, IOException {
        boolean success = cashbookDAO.resetCashbook();
        if (success) {
            request.getSession().setAttribute("successMessage", "Cashbook has been reset successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to reset the cashbook. Please try again.");
        }
        response.sendRedirect(request.getContextPath() + "/cashbook");
    }}
