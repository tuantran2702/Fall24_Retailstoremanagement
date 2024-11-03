<%-- 
    Document   : ForgotPass
    Created on : 8 Oct 2024, 11:46:42 am
    Author     : ptrung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Khôi phục mật khẩu | Website quản trị v2.0</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    </head>

    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login100-pic js-tilt" data-tilt>
                        <img src="images/fg-img.png" alt="IMG">
                    </div>
                    <!-- Form để khôi phục mật khẩu -->
                    <form class="login100-form validate-form" id="resetPasswordForm" action="forgotPass" method="POST">
                        <span class="login100-form-title">
                            <b>KHÔI PHỤC MẬT KHẨU</b>
                            <!-- Hiển thị thông báo lỗi hoặc thông báo thành công -->
                            <div class="notification">
                                <c:if test="${not empty error}">
                                    <p style="color: red;">${error}</p>
                                </c:if>
                                <c:if test="${not empty message}">
                                    <p style="color: green;">${message}</p>
                                </c:if>
                            </div>
                        </span>



                        <div class="wrap-input100 validate-input" data-validate="Bạn cần nhập đúng thông tin như: ex@abc.xyz">
                            <input class="input100" type="text" placeholder="Nhập email" name="emailInput" id="emailInput" value="" required />
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class='bx bx-mail-send'></i>
                            </span>
                        </div>
                        <div class="container-login100-form-btn">
                            <input type="submit" value="Lấy mật khẩu" class="btn-submit" onclick="return validateEmail()"/> <!-- Nút submit cho form này -->
                        </div>

                        <div class="text-center p-t-12">
                            <a class="txt2" href="login">Trở về đăng nhập</a>
                        </div>
                    </form>



                    <div class="text-center p-t-70 txt2">
                        Phần mềm quản lý bán hàng <i class="far fa-copyright" aria-hidden="true"></i>
                        <br>
                        <a class="txt2"> Team 1 - SE1854-NET </a>
                    </div>

                </div>
            </div>
        </div>
        <!--===============================================================================================-->
        <script src="/js/main.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->

    </body>

    <script>
                                function validateEmail() {
                                    var emailInput = document.getElementById("emailInput").value;
                                    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Regex kiểm tra email

                                    if (!emailPattern.test(emailInput)) {
                                        alert("Vui lòng nhập địa chỉ email hợp lệ."); // Hiển thị thông báo nếu email không hợp lệ
                                        return false; // Ngăn chặn gửi form
                                    }

                                    alert("Đang gửi yêu cầu đặt lại mật khẩu..."); // Thông báo cho người dùng
                                    return true; // Cho phép gửi form
                                }
    </script>

</html>