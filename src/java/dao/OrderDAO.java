package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Item;
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

    // Method to get products for the specified page
    public List<Product> getProductsByPage(int currentPage, int pageLimit, List<Product> allProductDTOs) {
        Pagination pagination = new Pagination(allProductDTOs.size(), pageLimit, currentPage);
        List<Product> productsOnPage = new ArrayList<>();

        for (int i = pagination.getStartItem(); i <= pagination.getLastItem() && i < allProductDTOs.size(); i++) {
            productsOnPage.add(allProductDTOs.get(i));
        }

        return productsOnPage;
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

    public void addOrder(int userId, Cart cart, double paymentAmount, int paymentMethodId) {
        String date = java.time.LocalDate.now().toString();

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
            psOrder.setString(1, date);
            psOrder.setDouble(2, cart.getTotalMoney());
            psOrder.setString(3, "Pending");
            psOrder.setInt(4, userId);
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
                    psPayment.setString(2, date);
                    psPayment.setDouble(3, paymentAmount);
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

    public static void main(String[] args) {

    }

}
