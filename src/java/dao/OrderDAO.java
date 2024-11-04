package dao;

import dto.OrderHistoryDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Customer;
import model.Item;
import model.Order;
import model.Pagination;
import model.PaymentMethod;
import model.Product;

public class OrderDAO extends DBContext {

    // Method to retrieve all products from the database
    public List<Product> getAllListProduct() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Product";

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("productID"));
                product.setProductCode(rs.getString("productCode"));
                product.setProductName(rs.getString("productName"));
                product.setCategoryID(rs.getInt("categoryID"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setDescription(rs.getString("description"));
                product.setCreatedDate(rs.getDate("createdDate"));
                product.setExpiredDate(rs.getDate("expiredDate"));
                product.setUpdateDate(rs.getDate("updateDate"));
                product.setImage(rs.getString("image"));
                product.setUserID(rs.getInt("userID"));
                product.setUnitID(rs.getInt("unitID"));
                product.setSupplierID(rs.getInt("supplierID"));

                productList.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }

    // Method to retrieve a product by its ID
    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT * FROM Product WHERE productID = ?";

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id); // Set the ID parameter

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setProductID(rs.getInt("productID"));
                    product.setProductCode(rs.getString("productCode"));
                    product.setProductName(rs.getString("productName"));
                    product.setCategoryID(rs.getInt("categoryID"));
                    product.setPrice(rs.getDouble("price"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setDescription(rs.getString("description"));
                    product.setCreatedDate(rs.getDate("createdDate"));
                    product.setExpiredDate(rs.getDate("expiredDate"));
                    product.setUpdateDate(rs.getDate("updateDate"));
                    product.setImage(rs.getString("image"));
                    product.setUserID(rs.getInt("userID"));
                    product.setUnitID(rs.getInt("unitID"));
                    product.setSupplierID(rs.getInt("supplierID"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }

    public List<Product> searchProductByName(String key) {
        List<Product> productList = new ArrayList<>();

        // Check if the search key is null or empty
        if (key == null || key.trim().isEmpty()) {
            return productList; // Return empty list if key is invalid
        }

        // Update the SQL query to search by productName or productCode
        String query = "SELECT * FROM Product WHERE LOWER(productName) LIKE LOWER(?) OR LOWER(productCode) LIKE LOWER(?)";

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(query)) {
            // Set the same key for both productName and productCode search
            String searchKey = "%" + key.toLowerCase() + "%";
            ps.setString(1, searchKey); // For productName
            ps.setString(2, searchKey); // For productCode

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("productID"));
                    product.setProductCode(rs.getString("productCode"));
                    product.setProductName(rs.getString("productName"));
                    product.setCategoryID(rs.getInt("categoryID"));
                    product.setPrice(rs.getDouble("price"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setDescription(rs.getString("description"));
                    product.setCreatedDate(rs.getDate("createdDate"));
                    product.setExpiredDate(rs.getDate("expiredDate"));
                    product.setUpdateDate(rs.getDate("updateDate"));
                    product.setImage(rs.getString("image"));
                    product.setUserID(rs.getInt("userID"));
                    product.setUnitID(rs.getInt("unitID"));
                    product.setSupplierID(rs.getInt("supplierID"));

                    productList.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return productList;
    }

    // Method to retrieve all payment methods from the database
    public List<PaymentMethod> getAllPaymentMethod() {
        List<PaymentMethod> paymentMethodList = new ArrayList<>();
        String query = "SELECT * FROM PaymentMethod"; // Adjust table name as needed

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PaymentMethod paymentMethod = new PaymentMethod();
                paymentMethod.setPaymentMethodID(rs.getInt("PaymentMethodID"));
                paymentMethod.setMethodName(rs.getString("MethodName"));
                paymentMethod.setDescription(rs.getString("Description"));

                paymentMethodList.add(paymentMethod);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return paymentMethodList;
    }

    public void addOrder(Cart cart, double paymentAmount, int paymentMethodId) {
        LocalDateTime dateTime = LocalDateTime.now();
        if (cart == null || cart.getItems().isEmpty()) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.WARNING, "Cart is empty or null.");
            return; // Early exit if the cart is not valid
        }

        try (
                PreparedStatement psOrder = connection.prepareStatement(
                        "INSERT INTO [Order] (OrderDate, TotalAmount, Status) VALUES (?, ?, ?)",
                        PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement psOrderDetail = connection.prepareStatement(
                        "INSERT INTO [OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (?, ?, ?, ?)"); PreparedStatement psPayment = connection.prepareStatement(
                        "INSERT INTO Payment ([OrderID], [PaymentDate], [Amount], [PaymentMethodID]) VALUES (?, ?, ?, ?)")) {
            // Add data to the Order table
            psOrder.setObject(1, dateTime);
            psOrder.setDouble(2, cart.getTotalMoney());
            psOrder.setString(3, "Pending");
            psOrder.executeUpdate();

            // Get the generated OrderID
            try (ResultSet rs = psOrder.getGeneratedKeys()) {
                if (rs.next()) {
                    int orderId = rs.getInt(1);
                    for (Item item : cart.getItems()) {
                        psOrderDetail.setInt(1, orderId);
                        psOrderDetail.setInt(2, item.getProduct().getProductID());
                        psOrderDetail.setInt(3, item.getQuantity());
                        psOrderDetail.setDouble(4, item.getProduct().getPrice());
                        psOrderDetail.executeUpdate();
                    }

                    // Add data to the Payment table
                    psPayment.setInt(1, orderId);
                    psPayment.setObject(2, dateTime);
                    psPayment.setDouble(3, paymentAmount);
                    psPayment.setInt(4, paymentMethodId);
                    psPayment.executeUpdate(); // Execute the payment insert
                }
            }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Unexpected error: " + e.getMessage(), e);
        }
    }

    public void addOrder(int customerId, Cart cart, double totalAmout, int paymentMethodId) {
        LocalDateTime dateTime = LocalDateTime.now();
        if (cart == null || cart.getItems().isEmpty()) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.WARNING, "Cart is empty or null.");
            return; // Early exit if the cart is not valid
        }

        try (
                PreparedStatement psOrder = connection.prepareStatement(
                        "INSERT INTO [Order] (OrderDate, TotalAmount, Status, CustomerID) VALUES (?, ?, ?, ?)",
                        PreparedStatement.RETURN_GENERATED_KEYS); PreparedStatement psOrderDetail = connection.prepareStatement(
                        "INSERT INTO [OrderDetail] ([OrderID], [ProductID], [Quantity], [UnitPrice]) VALUES (?, ?, ?, ?)"); PreparedStatement psPayment = connection.prepareStatement(
                        "INSERT INTO Payment ([OrderID], [PaymentDate], [Amount], [PaymentMethodID]) VALUES (?, ?, ?, ?)")) {
            // Add data to the Order table
            psOrder.setObject(1, dateTime);
            psOrder.setDouble(2, totalAmout);
            psOrder.setString(3, "Pending");
            psOrder.setInt(4, customerId);
            psOrder.executeUpdate();

            // Get the generated OrderID
            try (ResultSet rs = psOrder.getGeneratedKeys()) {
                if (rs.next()) {
                    int orderId = rs.getInt(1);
                    for (Item item : cart.getItems()) {
                        psOrderDetail.setInt(1, orderId);
                        psOrderDetail.setInt(2, item.getProduct().getProductID());
                        psOrderDetail.setInt(3, item.getQuantity());
                        psOrderDetail.setDouble(4, item.getProduct().getPrice());
                        psOrderDetail.executeUpdate();
                    }

                    // Add data to the Payment table
                    psPayment.setInt(1, orderId);
                    psPayment.setObject(2, dateTime);
                    psPayment.setDouble(3, totalAmout);
                    psPayment.setInt(4, paymentMethodId);
                    psPayment.executeUpdate(); // Execute the payment insert
                }
            }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Unexpected error: " + e.getMessage(), e);
        }
    }

    public void updateProductQuantity(int productId, int quantityOrdered) {
        String sql = "UPDATE Product SET Quantity = Quantity - ? WHERE ProductID = ? AND Quantity >= ?";
        try (Connection conn = connection; PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, quantityOrdered);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantityOrdered); // Kiểm tra số lượng trước khi cập nhật
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected == 0) {
                System.out.println("Cảnh báo: Không đủ hàng trong kho để thực hiện yêu cầu.");
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Product> getProductsByPage(int currentPage, int pageLimit, List<Product> allProducts) {
        Pagination pagination = new Pagination(allProducts.size(), pageLimit, currentPage);
        List<Product> productsOnPage = new ArrayList<>();

        for (int i = pagination.getStartItem(); i <= pagination.getLastItem() && i < allProducts.size(); i++) {
            productsOnPage.add(allProducts.get(i));
        }

        return productsOnPage;
    }

    public List<OrderHistoryDTO> getOrderHistoryDTOsByPage(int currentPage, int pageLimit, List<OrderHistoryDTO> allProducts) {
        Pagination pagination = new Pagination(allProducts.size(), pageLimit, currentPage);
        List<OrderHistoryDTO> productsOnPage = new ArrayList<>();

        for (int i = pagination.getStartItem(); i <= pagination.getLastItem() && i < allProducts.size(); i++) {
            productsOnPage.add(allProducts.get(i));
        }

        return productsOnPage;
    }

    public List<Order> getOrderByPage(int currentPage, int pageLimit, List<Order> allProducts) {
        Pagination pagination = new Pagination(allProducts.size(), pageLimit, currentPage);
        List<Order> productsOnPage = new ArrayList<>();

        for (int i = pagination.getStartItem(); i <= pagination.getLastItem() && i < allProducts.size(); i++) {
            productsOnPage.add(allProducts.get(i));
        }

        return productsOnPage;
    }

    public List<OrderHistoryDTO> orderHistory(int orderId) {
        List<OrderHistoryDTO> orderHistoryList = new ArrayList<>();
        String query = "SELECT \n"
                + "    o.OrderID, \n" // Select the Order ID
                + "    od.OrderDetailID, \n" // Select the Order Detail ID
                + "    p.ProductID, \n" // Select the Product ID
                + "    p.ProductName, \n"
                + "    o.OrderDate, \n"
                + "    od.Quantity, \n"
                + "    o.TotalAmount, \n"
                + "    pm.MethodName, \n"
                + "    o.Status, \n"
                + "    od.UnitPrice \n" // Add the unit price to the query
                + "FROM \n"
                + "    [Order] o\n"
                + "JOIN \n"
                + "    OrderDetail od ON o.OrderID = od.OrderID\n"
                + "JOIN \n"
                + "    Product p ON od.ProductID = p.ProductID\n"
                + "JOIN \n"
                + "    Payment pay ON o.OrderID = pay.OrderID\n"
                + "JOIN \n"
                + "    PaymentMethod pm ON pay.PaymentMethodID = pm.PaymentMethodID\n"
                + "WHERE \n"
                + "    o.OrderID = ?";

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, orderId); // Set the customer ID parameter

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Create a new OrderHistoryDTO object for each record
                    OrderHistoryDTO orderHistory = new OrderHistoryDTO();
                    orderHistory.setOrderId(rs.getInt("OrderID"));            // Set the Order ID
                    orderHistory.setOrderDetailId(rs.getInt("OrderDetailID")); // Set the Order Detail ID
                    orderHistory.setProductId(rs.getInt("ProductID"));         // Set the Product ID
                    orderHistory.setProductName(rs.getString("ProductName"));
                    orderHistory.setOrderDate(rs.getString("OrderDate"));
                    orderHistory.setQuantity(rs.getInt("Quantity"));
                    orderHistory.setTotalAmount(rs.getDouble("TotalAmount"));
                    orderHistory.setPaymentMethod(rs.getString("MethodName"));
                    orderHistory.setStatus(rs.getString("Status"));
                    orderHistory.setUnitPrice(rs.getDouble("UnitPrice"));     // Set the unit price

                    // Add the order history to the list
                    orderHistoryList.add(orderHistory);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Error fetching order history", e);
        }

        return orderHistoryList;
    }

    public List<OrderHistoryDTO> viewOrderHistory(int orderId) {
        List<OrderHistoryDTO> orderHistoryList = new ArrayList<>();
        String query = "SELECT \n"
                + "    o.OrderID, \n" // Select the Order ID
                + "    od.OrderDetailID, \n" // Select the Order Detail ID
                + "    p.ProductID, \n" // Select the Product ID
                + "    p.ProductName, \n"
                + "    o.OrderDate, \n"
                + "    od.Quantity, \n"
                + "    o.TotalAmount, \n"
                + "    pm.MethodName, \n"
                + "    o.Status, \n"
                + "    od.UnitPrice \n" // Add the unit price to the query
                + "FROM \n"
                + "    [Order] o\n"
                + "JOIN \n"
                + "    OrderDetail od ON o.OrderID = od.OrderID\n"
                + "JOIN \n"
                + "    Product p ON od.ProductID = p.ProductID\n"
                + "JOIN \n"
                + "    Payment pay ON o.OrderID = pay.OrderID\n"
                + "JOIN \n"
                + "    PaymentMethod pm ON pay.PaymentMethodID = pm.PaymentMethodID\n"
                + "WHERE \n"
                + "    od.OrderDetailID = ?";

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, orderId); // Set the customer ID parameter

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Create a new OrderHistoryDTO object for each record
                    OrderHistoryDTO orderHistory = new OrderHistoryDTO();
                    orderHistory.setOrderId(rs.getInt("OrderID"));            // Set the Order ID
                    orderHistory.setOrderDetailId(rs.getInt("OrderDetailID")); // Set the Order Detail ID
                    orderHistory.setProductId(rs.getInt("ProductID"));         // Set the Product ID
                    orderHistory.setProductName(rs.getString("ProductName"));
                    orderHistory.setOrderDate(rs.getString("OrderDate"));
                    orderHistory.setQuantity(rs.getInt("Quantity"));
                    orderHistory.setTotalAmount(rs.getDouble("TotalAmount"));
                    orderHistory.setPaymentMethod(rs.getString("MethodName"));
                    orderHistory.setStatus(rs.getString("Status"));
                    orderHistory.setUnitPrice(rs.getDouble("UnitPrice"));     // Set the unit price

                    // Add the order history to the list
                    orderHistoryList.add(orderHistory);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Error fetching order history", e);
        }

        return orderHistoryList;
    }

    public List<Order> getAllOrder() {
        List<Order> orderList = new ArrayList<>();
        // Define the SQL query to retrieve all orders
        String query = "SELECT OrderID, OrderDate, TotalAmount, Status, CustomerID FROM [Order]";

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(query)) {
            // Execute the query and get the result set
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Create a new Order object for each record
                    Order order = new Order();
                    order.setOrderID(rs.getInt("OrderID"));                  // Set Order ID
                    order.setOrderDate(rs.getTimestamp("OrderDate"));       // Set Order Date
                    order.setTotalAmount(rs.getDouble("TotalAmount"));       // Set Total Amount
                    order.setStatus(rs.getString("Status"));                 // Set Status
                    order.setCustomerID(rs.getInt("CustomerID"));           // Set Customer ID

                    // Add the order to the list
                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Error fetching all orders", e);
        }

        return orderList;
    }

     public boolean updateOrderStatus(int orderId, String status) {
        String query = "UPDATE [dbo].[Order] SET [Status] = ?\n"
                + "WHERE [OrderID] = ?";

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status); // Set the new status
            ps.setInt(2, orderId); // Set the OrderDetail ID

            int rowsAffected = ps.executeUpdate(); // Execute the update
            return rowsAffected > 0; // Return true if at least one row was updated
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Error updating order status", e);
            return false; // Return false if there was an error
        }
    }

    public List<Customer> getAllCustomers() {
    List<Customer> customers = new ArrayList<>();
    String query = "SELECT CustomerID, FirstName, LastName, Email, PhoneNumber, TotalSpent, Address, RankID, CurrentPoint FROM Customer"; // Đảm bảo cột CurrentPoint tồn tại

    try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Customer customer = new Customer();
            customer.setCustomerID(rs.getInt("CustomerID"));
            customer.setFirstName(rs.getString("FirstName"));
            customer.setLastName(rs.getString("LastName"));
            customer.setEmail(rs.getString("Email"));
            customer.setPhoneNumber(rs.getString("PhoneNumber"));

            // Chuyển kiểu dữ liệu TotalSpent từ ResultSet thành double
            customer.setTotalSpent(rs.getDouble("TotalSpent"));
            customer.setAddress(rs.getString("Address"));

            // Chuyển kiểu dữ liệu RankID từ ResultSet thành int
            customer.setRankID(rs.getInt("RankID"));

            // Thêm dòng này để thiết lập currentPoint
            customer.setCurrentPoint(rs.getInt("CurrentPoint")); // Cần đảm bảo cột CurrentPoint tồn tại trong cơ sở dữ liệu

            customers.add(customer);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return customers;
}

    public static void main(String[] args) {
        OrderDAO d = new OrderDAO();
        List<Order> d1 = d.getAllOrder();
        for (Order order : d1) {
            System.out.println("id: " + order.getOrderID());
        }
    }

}