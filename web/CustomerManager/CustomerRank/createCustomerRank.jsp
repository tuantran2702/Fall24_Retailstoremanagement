<%@ page import="model.CustomerRank" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Create Customer Rank | Quản lý cấp bậc khách hàng</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <body class="app sidebar-mini rtl">
        <!-- Navbar and Sidebar (same as before) -->
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
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/customerRank">Danh sách cấp bậc khách hàng</a></li>
                    <li class="breadcrumb-item">Thêm cấp bậc</li>
                </ul>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Thêm cấp bậc khách hàng</h3>
                        <div class="tile-body">
                            <form action="${pageContext.request.contextPath}/customerRank?action=create" method="post">
                                <div class="form-group">
                                    <label for="rankName">Tên cấp bậc</label>
                                    <input type="text" class="form-control" id="rankName" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label for="minimumSpent">Chi tiêu tối thiểu</label>
                                    <input type="number" class="form-control" id="minimumSpent" name="minimumSpent" required>
                                </div>
                                <div class="form-group">
                                    <label for="description">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Thêm mới</button>
                                <a href="${pageContext.request.contextPath}/customerRank" class="btn btn-secondary">Hủy</a>
                            </form>

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
