package dto;

/**
 * Data Transfer Object for Order History.
 */
public class OrderHistoryDTO {

    private int orderId;
    private int orderDetailId;
    private int productId;
    private String productName;  // Product Name
    private String orderDate;    // Order Date
    private int quantity;        // Quantity of the product ordered
    private double totalAmount;   // Total amount of the order
    private String paymentMethod; // Payment method used
    private String status;       // Current status of the order
    private double unitPrice;    // Price per unit of the product

    // Constructor
    public OrderHistoryDTO() {
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    @Override
    public String toString() {
        return "OrderHistoryDTO{"
                + "orderId=" + orderId
                + ", orderDetailId=" + orderDetailId
                + ", productId=" + productId
                + ", productName='" + productName + '\''
                + ", orderDate='" + orderDate + '\''
                + ", quantity=" + quantity
                + ", totalAmount=" + totalAmount
                + ", paymentMethod='" + paymentMethod + '\''
                + ", status='" + status + '\''
                + ", unitPrice=" + unitPrice
                + '}';
    }
}
