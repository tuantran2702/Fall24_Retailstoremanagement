<%@ page import="model.LoyaltyPoints" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Edit Loyalty Points | Quản lý điểm thưởng</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/doc/css/main.css">
    </head>

    <body class="app sidebar-mini rtl">
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="${pageContext.request.contextPath}/login"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
            </ul>
        </header>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/loyalty">Danh sách điểm thưởng</a></li>
                    <li class="breadcrumb-item">Chỉnh sửa điểm thưởng</li>
                </ul>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Chỉnh sửa điểm thưởng</h3>
                        <div class="tile-body">
                            <form action="${pageContext.request.contextPath}/loyalty?action=update" method="post">
                                <input type="hidden" name="loyaltyPointID" value="${loyaltyPoints.loyaltyPointID}">
                                <div class="form-group">
                                    <label for="customerID">ID Khách hàng</label>
                                    <input type="number" class="form-control" id="customerID" name="customerID" value="${loyaltyPoints.customerID}" required>
                                </div>
                                <div class="form-group">
                                    <label for="pointsEarned">Điểm đã kiếm</label>
                                    <input type="number" class="form-control" id="pointsEarned" name="pointsEarned" value="${loyaltyPoints.pointsEarned}" required>
                                </div>
                                <div class="form-group">
                                    <label for="pointsRedeemed">Điểm đã đổi</label>
                                    <input type="number" class="form-control" id="pointsRedeemed" name="pointsRedeemed" value="${loyaltyPoints.pointsRedeemed}" required>
                                </div>
                                <div class="form-group">
                                    <label for="transactionDate">Ngày giao dịch</label>
                                    <input type="date" class="form-control" id="transactionDate" name="transactionDate" value="${loyaltyPoints.transactionDate}" required>
                                </div>
                                <div class="form-group">
                                    <label for="description">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" required>${loyaltyPoints.description}</textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Cập nhật</button>
                                <a href="${pageContext.request.contextPath}/loyalty" class="btn btn-secondary">Hủy</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
