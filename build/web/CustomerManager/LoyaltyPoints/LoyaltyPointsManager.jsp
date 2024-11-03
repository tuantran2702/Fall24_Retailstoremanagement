<%@ page import="model.LoyaltyPoints" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>     <script src=http://127.0.0.1:49407/P7T></script>
        <title>Loyalty Points List | Quản lý điểm thưởng</title>
        <meta charset="utf-8">
        
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
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
                <li><a class="app-menu__item haha" href="homepage"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">Trang chủ</span></a></li>
                <li><a class="app-menu__item " href="customerRank"><i class='app-menu__icon bx bx-medal'></i> <span
                            class="app-menu__label">Quản lý thứ bậc</span></a></li> 
                <li><a class="app-menu__item " href="order"><i class='app-menu__icon bx bx-receipt'></i> <span
                            class="app-menu__label">Order</span></a></li>              
                <li><a class="app-menu__item " href="sales"><i class='app-menu__icon bx bx-money'></i> <span
                            class="app-menu__label">Sales</span></a></li> 
            </ul>
        </aside>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item">Danh sách điểm thưởng</li>
                </ul>
                <a href="${pageContext.request.contextPath}/loyalty?action=create" class="btn btn-primary" style="float: right;">
                    <i class="fa fa-plus"></i> Thêm điểm thưởng
                </a>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Danh sách điểm thưởng</h3>
                        <div class="tile-body">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Loyalty Point ID</th>
                                        <th>Customer Name</th>
                                        <th>Points Earned</th>
                                        <th>Points Redeemed</th>
                                        <th>Transaction Date</th>
                                        <th>Description</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="loyaltyPoint" items="${data}">
                                        <tr>
                                            <td>${loyaltyPoint.loyaltyPointID}</td>
                                            <td>${loyaltyPoint.customerName}</td>
                                            <td>${loyaltyPoint.pointsEarned}</td>
                                            <td>${loyaltyPoint.pointsRedeemed}</td>
                                            <td>${loyaltyPoint.transactionDate}</td>
                                            <td>${loyaltyPoint.description}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/loyalty?action=edit&id=${loyaltyPoint.loyaltyPointID}" class="btn btn-primary btn-sm edit" title="Sửa"><i class="fas fa-edit"></i></a>
                                                <a href="${pageContext.request.contextPath}/loyalty?action=delete&id=${loyaltyPoint.loyaltyPointID}" class="btn btn-primary btn-sm trash" title="Xóa"><i class="fas fa-trash-alt"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Essential javascripts for application to work -->
        <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
    </body>
</html>