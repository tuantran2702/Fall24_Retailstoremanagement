<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thêm giao dịch mới | Quản lý thu chi</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Main CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">

    <!-- Font-icon CSS -->
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
                <li class="breadcrumb-item"><a href="cashbook">Danh sách giao dịch</a></li>
                <li class="breadcrumb-item active">Thêm giao dịch mới</li>
            </ul>
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <a href="${pageContext.request.contextPath}/cashbook" class="btn btn-secondary" style="margin-right: 10px;">
                        <i class="fa fa-list"></i> Danh sách giao dịch
                    </a>
                
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Thêm giao dịch mới</h3>
                    <div class="tile-body">
                        <form action="${pageContext.request.contextPath}/cashbook" method="POST" class="row">
                            <input type="hidden" name="action" value="create">
                            
                            <div class="form-group col-md-4">
                                <label for="transactionDate"><i class="fa fa-calendar"></i> Ngày giao dịch:</label>
                                <input type="datetime-local" class="form-control" id="transactionDate" name="transactionDate" required>
                            </div>

                            <div class="form-group col-md-4">
                                <label for="description"><i class="fa fa-file-text"></i> Mô tả:</label>
                                <input type="text" class="form-control" id="description" name="description" required>
                            </div>

                            <div class="form-group col-md-4">
                                <label for="amount"><i class="fa fa-money"></i> Số tiền:</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="amount" name="amount" step="1000" required>
                                    <span class="input-group-text">VNĐ</span>
                                </div>
                            </div>

                            <div class="form-group col-md-4">
                                <label for="transactionType"><i class="fa fa-exchange"></i> Loại giao dịch:</label>
                                <select class="form-control" id="transactionType" name="transactionType" required>
                                    <option value="Thu">Thu</option>
                                    <option value="Chi">Chi</option>
                                </select>
                            </div>

                            <div class="form-group col-md-12">
                                <button class="btn btn-save" type="submit"><i class="fa fa-save"></i> Lưu lại</button>
                                <a class="btn btn-cancel" href="cashbook"><i class="fa fa-times"></i> Hủy bỏ</a>
                            </div>
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
    
    <script>
        document.getElementById('transactionType').addEventListener('change', function() {
            const amountField = document.getElementById('amount');
            let amountValue = parseFloat(amountField.value);

            if (this.value === 'Chi' && amountValue > 0) {
                amountField.value = -Math.abs(amountValue);
            } else if (this.value === 'Thu' && amountValue < 0) {
                amountField.value = Math.abs(amountValue);
            }
        });
    </script>
</body>
</html>