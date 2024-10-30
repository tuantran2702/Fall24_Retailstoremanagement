<%-- 
    Document   : test
    Created on : Sep 25, 2024, 10:19:04 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h3 class="tile-title">Danh Sách Sản Phẩm</h3>
        <table>
            <thead>
                <tr>
                    <th>Tên Sản Phẩm</th>
                    <th>Mô Tả</th>
                    <th>Giá Tiền</th>
                    <th>Số Lượng Tồn Kho</th>
                    <th>Order</th>
                </tr>
            </thead>
            <tbody>
                <!-- Loop through the listProduct -->
            <c:forEach var="product" items="${listProduct}">
                <tr>
                    <td>${product.productName}</td> <!-- Make sure productName is available -->
                    <td>${product.description}</td>
                    <td>${product.price}</td>
                    <td>${product.quantity}</td>
                    <td>
                        <form action="cart" method="post"> <!-- Update the action URL -->
                            <input type="hidden" name="id" value="${product.productID}"/> 
                            <button type="submit" title="Order" name="addtocart">
                                <i class="bx bx-plus"></i> 
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <%@include file="pagination.jsp" %>
</body>
</html>
