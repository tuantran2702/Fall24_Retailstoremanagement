<%@ page import="model.Import" %>
<html>
<head>
    <title>Update Import</title>
</head>
<body>
    <h2>Update Import</h2>
    <form action="import" method="post">
        <input type="hidden" name="id" value="<%= ((Import) request.getAttribute("importt")).getImportID() %>" />
        Product ID: <input type="text" name="productID" value="<%= ((Import) request.getAttribute("importt")).getProductID() %>" /><br />
        Inventory ID: <input type="text" name="inventoryID" value="<%= ((Import) request.getAttribute("importt")).getInventoryID() %>" /><br />
        Import Date: <input type="date" name="importDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(((Import) request.getAttribute("importt")).getImportDate()) %>" /><br />
        Unit Cost: <input type="text" name="unitCost" value="<%= ((Import) request.getAttribute("importt")).getUnitCost() %>" /><br />
        Quantity: <input type="text" name="quantity" value="<%= ((Import) request.getAttribute("importt")).getQuantity() %>" /><br />
        Supplier Name: <input type="text" name="supplierName" value="<%= ((Import) request.getAttribute("importt")).getSupplierName() %>" /><br />
        <input type="submit" value="Update" />
        <input type="hidden" name="action" value="update" />
    </form>
</body>
</html>
