<%-- 
    Document   : PoductManager
    Created on : 17-Sep-2024, 14:29:49
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="dao.ProductDAO"%>
<%@page import="model.Product"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Product List</h1>
    <table>
        <tr>
            <th>Product ID</th>
            <th>Product Code</th>
            <th>Product Name</th>
            <th>Category ID</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Description</th>
        </tr>
        <c:forEach var="p" items="${data}">
            <tr>
                <td>${p.getProductID()}</td>
                <td>${p.getProductCode()}</td>
                <td>${p.getProductName()}</td>
                <td>${p.getCategoryID()}</td>
                <td>${p.getPrice()}</td>
                <td>${p.getQuantity()}</td>
                <td>${p.getDescription()}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
