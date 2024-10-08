<%-- 
    Document   : test
    Created on : 8 Oct 2024, 1:35:51 pm
    Author     : ptrung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập Dữ Liệu Người Dùng</title>
    <link rel="stylesheet" href="styles.css"> <!-- Kết nối với CSS nếu cần -->
</head>
<body>
    <div class="container">
        <h1>Nhập Dữ Liệu Người Dùng</h1>

        <!-- Hiển thị thông báo lỗi hoặc thông báo thành công -->
        <div class="notification">
            <c:if test="${not empty error}">
                <p style="color: red;">${error}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p style="color: green;">${message}</p>
            </c:if>
        </div>

        <form action="userInput" method="POST">
            <div class="wrap-input100 validate-input">
                <input class="input100" type="text" placeholder="Nhập tên" name="nameInput" required />
                <span class="focus-input100"></span>
                <span class="symbol-input100">
                    <i class='bx bx-user'></i>
                </span>
            </div>
            <div class="wrap-input100 validate-input">
                <input class="input100" type="email" placeholder="Nhập email" name="emailInput" required />
                <span class="focus-input100"></span>
                <span class="symbol-input100">
                    <i class='bx bx-mail-send'></i>
                </span>
            </div>
            <div class="container-login100-form-btn">
                <input type="submit" value="Gửi" class="btn-submit" />
            </div>
        </form>

        <!-- Hiển thị thông tin đã nhập -->
        <c:if test="${not empty email}">
            <h2>Thông Tin Đã Nhập:</h2>
            <p>Tên: ${name}</p>
            <p>Email: ${email}</p>
        </c:if>
    </div>
</body>
</html>

