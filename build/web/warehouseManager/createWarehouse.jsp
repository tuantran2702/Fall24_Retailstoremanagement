<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create Warehouse | Quản lý kho</title>
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
            <li><a class="app-nav__item" href="/index.html"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
        </ul>
    </header>

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
                <li class="breadcrumb-item"><a href="warehouse">Danh sách kho hàng</a></li>
                <li class="breadcrumb-item active">Thêm kho hàng</li>
            </ul>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <h3 class="tile-title">Thêm kho hàng</h3>
                    <div class="tile-body">
                      <form action="warehouse" method="post" onsubmit="return validateForm();">
    <input type="hidden" name="action" value="create">
    <div class="form-group">
        <label for="name">Tên kho hàng:</label>
        <input type="text" class="form-control" id="name" name="name" required>
    </div>
    <div class="form-group">
        <label for="location">Vị trí:</label>
        <input type="text" class="form-control" id="location" name="location" required>
    </div>
    <div class="form-group">
        <label for="manager">Tên quản lý:</label>
        <input type="text" class="form-control" id="manager" name="manager" required>
    </div>
    <div class="form-group">
        <label for="contact">Số liên lạc:</label>
        <input type="text" class="form-control" id="contact" name="contact" required>
    </div>
    <button type="submit" class="btn btn-primary">Lưu</button>
</form>

                    </div>
                </div>
            </div>
        </div>
    </main>
<script>
    function validateForm() {
        // Kiểm tra tên kho hàng (bắt buộc, ít nhất 3 ký tự)
        const name = document.getElementById("name").value;
        if (name.trim().length < 3) {
            alert("Tên kho hàng phải có ít nhất 3 ký tự.");
            return false;
        }

      // Kiểm tra vị trí (bắt buộc, ít nhất 3 ký tự, không chứa ký tự đặc biệt)
const location = document.getElementById("location").value;
if (location.trim().length < 3 || !/^[a-zA-Z0-9\s]+$/.test(location.trim())) {
    alert("Vị trí phải có ít nhất 3 ký tự và không được chứa ký tự đặc biệt.");
    return false;
}


        // Kiểm tra tên quản lý (bắt buộc, ít nhất 3 ký tự)
        const manager = document.getElementById("manager").value;
        if (manager.trim().length < 3) {
            alert("Tên quản lý phải có ít nhất 3 ký tự.");
            return false;
        }

      const contact = document.getElementById("contact").value;
if (!/^0\d{9,10}$/.test(contact.trim())) {
    alert("Số liên lạc phải bắt đầu bằng số 0 và có độ dài 10-11 chữ số.");
    return false;
}


        return true; // Nếu tất cả các kiểm tra đều hợp lệ
    }
</script>

    <!-- Essential javascripts for application to work -->
    <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
</body>
</html>
