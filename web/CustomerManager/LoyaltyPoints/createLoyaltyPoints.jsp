<%@ page import="model.LoyaltyPoints" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Create Loyalty Points | Quản lý điểm thưởng</title>
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

        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user">
                <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
                <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
            </div>
            <hr>
        </aside>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/loyalty">Danh sách điểm thưởng</a></li>
                    <li class="breadcrumb-item">Thêm điểm thưởng</li>
                </ul>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Thêm điểm thưởng</h3>
                        <div class="tile-body">
                            <form action="${pageContext.request.contextPath}/loyalty?action=create" method="post">
                                <div class="form-group">
                                    <label for="customerID">ID Khách hàng</label>
                                    <input type="number" class="form-control" id="customerID" name="customerID" required>
                                </div>
                                <div class="form-group">
                                    <label for="pointsEarned">Điểm đã kiếm</label>
                                    <input type="number" class="form-control" id="pointsEarned" name="pointsEarned" required>
                                </div>
                                <div class="form-group">
                                    <label for="pointsRedeemed">Điểm đã đổi</label>
                                    <input type="number" class="form-control" id="pointsRedeemed" name="pointsRedeemed" required>
                                </div>
                                <div class="form-group">
                                    <label for="transactionDate">Ngày giao dịch</label>
                                    <input type="date" class="form-control" id="transactionDate" name="transactionDate" required>
                                </div>
                                <div class="form-group">
                                    <label for="description">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Thêm mới</button>
                                <a href="${pageContext.request.contextPath}/loyalty" class="btn btn-secondary">Hủy</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
