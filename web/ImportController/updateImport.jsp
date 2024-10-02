<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Import</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        form { max-width: 400px; margin: 0 auto; }
        label { display: inline-block; width: 120px; margin-bottom: 10px; }
        input, select { width: 200px; padding: 5px; margin-bottom: 10px; }
        input[type="submit"] { width: auto; cursor: pointer; }
    </style>
</head>
<body>
    <h2>Update Import</h2>
    <form action="${pageContext.request.contextPath}/import?action=update" method="post">
        <input type="hidden" name="id" value="${importt.importID}">
        <input type="hidden" name="productID" value="${importt.productID}">
        <input type="hidden" name="inventoryID" value="${importt.inventoryID}">
        <input type="hidden" name="importDate" value="${importt.importDate}">
        
        <label for="unitCost">Unit Cost:</label>
        <input type="number" id="unitCost" name="unitCost" value="${importt.unitCost}" step="0.01" required><br>
        
        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" value="${importt.quantity}" required><br>
        
        <label for="supplierName">Supplier:</label>
        <select id="supplierName" name="supplierName" required>
            <c:forEach items="${suppliers}" var="supplier">
                <option value="${supplier.supplierName}" ${supplier.supplierName eq importt.supplierName ? 'selected' : ''}>
                    ${supplier.supplierName}
                </option>
            </c:forEach>
        </select><br>
        
        <input type="submit" value="Update Import">
    </form>
</body>
</html>