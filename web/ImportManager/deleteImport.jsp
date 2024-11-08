<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Delete Import | Quản lý kho</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">
    <!-- Navbar -->
    <header class="app-header">
        <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
        <ul class="app-nav">
            <li><a class="app-nav__item" href="${pageContext.request.contextPath}/login"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
        </ul>
    </header>

    <!-- Sidebar menu -->
    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <jsp:include page="/menu.jsp" />
    <main class="app-content">
        <div class="app-title">
            <ul class="app-breadcrumb breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/import">Danh sách nhập hàng</a></li>
                <li class="breadcrumb-item active">Xóa nhập hàng</li>
            </ul>
        </div>
        <div class="container">
            <div class="col-md-12">
                <h2>Xóa nhập hàng</h2>
                <form action="${pageContext.request.contextPath}/import" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="${id}">
                    <p>Bạn có chắc chắn muốn xóa nhập hàng này không?</p>
                    <button type="submit" class="btn btn-danger">Xóa</button>
                    <a href="${pageContext.request.contextPath}/import" class="btn btn-secondary">Hủy</a>
                </form>
            </div>
        </div>
    </main>
</body>
</html>