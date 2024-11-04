<%@ page import="model.Customer" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Customer | Quản lý khách hàng</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body class="app sidebar-mini rtl">
    <header class="app-header">
        <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
        <ul class="app-nav">
            <li><a class="app-nav__item" href="${pageContext.request.contextPath}/login"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
        </ul>
    </header>

    <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
        <div class="app-sidebar__user">
            <img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px" alt="User Image">
            <div>
                <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
                <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
            </div>
        </div>
        <hr>
        <ul class="app-menu">
            <!-- Same sidebar items -->
        </ul>
    </aside>

    <main class="app-content">
        <div class="app-title">
            <ul class="app-breadcrumb breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/customer">Danh sách khách hàng</a></li>
                <li class="breadcrumb-item">Chỉnh sửa khách hàng</li>
            </ul>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Chỉnh sửa thông tin khách hàng</h3>
                    <div class="tile-body">
                        <form action="${pageContext.request.contextPath}/customer?action=update" method="post">
                            <input type="hidden" name="id" value="${customer.customerID}">
                            <div class="form-group">
                                <label for="firstName">Họ</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="${customer.firstName}" required>
                            </div>
                            <div class="form-group">
                                <label for="lastName">Tên</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="${customer.lastName}" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${customer.email}" required>
                            </div>
                            <div class="form-group">
                                <label for="phoneNumber">Số điện thoại</label>
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="${customer.phoneNumber}" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Địa chỉ</label>
                                <textarea class="form-control" id="address" name="address" required>${customer.address}</textarea>
                            </div>
<!--                            <div class="form-group">
                                <label for="totalSpent">Tổng chi tiêu</label>
                                <input type="number" class="form-control" id="totalSpent" name="totalSpent" value="${customer.totalSpent}" required>
                            </div>
                            <div class="form-group">
                                <label for="rankID">Cấp bậc</label>
                                <select class="form-control" id="rankID" name="rankID" required>
                                    <c:forEach items="${ranks}" var="rank">
                                        <option value="${rank.rankID}" ${rank.rankID == customer.rankID ? 'selected' : ''}>${rank.rankName}</option>
                                    </c:forEach>
                                </select>
                            </div>-->
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                            <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">Hủy</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
</body>
</html>