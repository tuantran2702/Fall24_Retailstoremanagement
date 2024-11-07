<%@ page import="model.Customer" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Create Customer | Quản lý khách hàng</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <script>
            function validateForm() {
                // Lấy các trường từ biểu mẫu
                const firstName = document.getElementById('firstName').value.trim();
                const lastName = document.getElementById('lastName').value.trim();
                const email = document.getElementById('email').value.trim();
                const phoneNumber = document.getElementById('phoneNumber').value.trim();
                const address = document.getElementById('address').value.trim();

                // Kiểm tra First Name
                if (firstName === '') {
                    alert("Vui lòng nhập tên.");
                    return false;
                }
                if (!/^[a-zA-Z\s]+$/.test(firstName)) {
                    alert("Tên không được chứa số.");
                    return false;
                }
                if (firstName.length > 50) {
                    alert("Tên không được vượt quá 50 ký tự.");
                    return false;
                }

                // Kiểm tra Last Name
                if (lastName === '') {
                    alert("Vui lòng nhập họ.");
                    return false;
                }
                if (!/^[a-zA-Z\s]+$/.test(lastName)) {
                    alert("Họ không được chứa số.");
                    return false;
                }
                if (lastName.length > 50) {
                    alert("Họ không được vượt quá 50 ký tự.");
                    return false;
                }

                // Kiểm tra Email
                if (email !== '' && !validateEmail(email)) {
                    alert("Vui lòng nhập địa chỉ email hợp lệ.");
                    return false;
                }

                // Kiểm tra Phone Number
                if (phoneNumber === '') {
                    alert("Vui lòng nhập số điện thoại.");
                    return false;
                }
                if (!validatePhoneNumber(phoneNumber)) {
                    alert("Số điện thoại không hợp lệ..");
                    return false;
                }

                // Kiểm tra Address
                if (address === '') {
                    alert("Vui lòng nhập địa chỉ.");
                    return false;
                }

                // Nếu tất cả các trường hợp lệ, cho phép gửi biểu mẫu
                return true;
            }

            function validateEmail(email) {
                // Biểu thức chính quy để kiểm tra định dạng email
                const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return re.test(email);
            }

            function validatePhoneNumber(phoneNumber) {
                // Kiểm tra số điện thoại Việt Nam: bắt đầu bằng 0 và có độ dài từ 10 đến 11 ký tự
                const re = /^(0[1-9][0-9]{8,9})$/;
                return re.test(phoneNumber);
            }
        </script>
    </head>

    <body class="app sidebar-mini rtl">
        <!-- Navbar and Sidebar -->
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="${pageContext.request.contextPath}/login"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
            </ul>
        </header>

        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user">
                <img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px" alt="User  Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <!-- Sidebar items -->
            </ul>
        </aside>

        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/customer">Danh sách khách hàng</a></li>
                    <li class="breadcrumb-item">Thêm khách hàng</li>
                </ul>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Thêm khách hàng mới</h3>
                        <div class="tile-body">
                            <form action="${pageContext.request.contextPath}/customer?action=create" method="post" onsubmit="return validateForm()">
                                <!-- First Name -->
                                <div class="form-group">
                                    <label for="firstName">Tên (First Name)</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                                </div>

                                <!-- Last Name -->
                                <div ```html
                                     <div class="form-group">
                                    <label for="lastName">Họ (Last Name)</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                                </div>

                                <!-- Email -->
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email">
                                </div>

                                <!-- Phone Number -->
                                <div class="form-group">
                                    <label for="phoneNumber">Số điện thoại</label>
                                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                                </div>

                                <!-- Address -->
                                <div class="form-group">
                                    <label for="address">Địa chỉ</label>
                                    <textarea class="form-control" id="address" name="address"></textarea>
                                </div>

                                <!-- Submit and Cancel Buttons -->
                                <button type="submit" class="btn btn-primary">Thêm mới</button>
                                <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">Hủy</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Essential javascripts -->
        <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
    </body>
</html>