<%@ page import="dao.ImportDAO" %>
<%@ page import="model.Product" %>
<%@ page import="model.Supplier" %>
<%@ page import="java.util.List" %>

<%
    ImportDAO importDAO = new ImportDAO();
    List<Product> products = importDAO.getAllProducts();
    List<Supplier> suppliers = importDAO.getAllSuppliers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Import</title>
</head>
<body>
    <h2>Create Import Record</h2>
    <form action="<%= request.getContextPath() %>/import" method="post">
        <input type="hidden" name="action" value="create">
        
        <label for="productID">Product:</label>
        <select name="productID" id="productID" required>
            <option value="">Select Product</option>
            <%
                for (Product product : products) {
            %>
            
            
            
                <option value="<%= product.getProductID() %>"><%= product.getProductName() %></option>
            <%
                }



            %>
        </select><br>
  <label for="inventory">inventoryID:</label>
        <input type="number" step="0.01" name="inventoryID" id="unitCost" required><br>

        <label for="importDate">Import Date:</label>
        <input type="date" name="importDate" id="importDate" required><br>

        <label for="unitCost">Unit Cost:</label>
        <input type="number" step="0.01" name="unitCost" id="unitCost" required><br>

        <label for="quantity">Quantity:</label>
        <input type="number" name="quantity" id="quantity" required><br>

        <label for="supplierName">Supplier:</label>
        <select name="supplierName" id="supplierName" required>
            <option value="">Select Supplier</option>
            <%
                for (Supplier supplier : suppliers) {
            %>
                <option value="<%= supplier.getSupplierName() %>"><%= supplier.getSupplierName() %></option>
            <%
                }
            %>
        </select><br>

        <button type="submit">Create Import</button>
    </form>
</body>
</html>
