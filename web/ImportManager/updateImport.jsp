<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Import" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Update Import | Quản lý kho</title>
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
                <li class="breadcrumb-item"><a href="import">Danh sách nhập hàng</a></li>
                <li class="breadcrumb-item active">Cập nhật nhập hàng</li>
            </ul>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Cập nhật thông tin nhập hàng</h3>
                    <div class="tile-body">
                        <form action="${pageContext.request.contextPath}/import" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${importt.importID}">
                            <input type="hidden" name="productID" value="${importt.productID}">
                            <input type="hidden" name="inventoryID" value="${importt.inventoryID}">
                            <input type="hidden" name="importDate" value="${importt.importDate}">
                            
                            <div class="form-group">
                                <label class="control-label">Giá nhập đơn vị</label>
                                <input class="form-control" type="number" name="unitCost" value="${importt.unitCost}" step="0.01" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label">Số lượng</label>
                                <input class="form-control" type="number" name="quantity" value="${importt.quantity}" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label">Nhà cung cấp</label>
                                <select class="form-control" name="supplierName" required>
                                    <c:forEach items="${suppliers}" var="supplier">
                                        <option value="${supplier.supplierName}" ${supplier.supplierName eq importt.supplierName ? 'selected' : ''}>
                                            ${supplier.supplierName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <button class="btn btn-save" type="submit">Cập nhật</button>
                            <a class="btn btn-cancel" href="import">Hủy bỏ</a>
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