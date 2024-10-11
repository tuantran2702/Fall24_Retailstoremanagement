<%-- 
    Document   : AddEmployee
    Created on : 25 Sep 2024, 8:02:23 am
    Author     : ptrung
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Thêm nhân viên | Quản trị Admin</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

    </head>

    <body class="app sidebar-mini rtl">
        <style>
            .Choicefile {
                display: block;
                background: #14142B;
                border: 1px solid #fff;
                color: #fff;
                width: 150px;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                padding: 5px 0px;
                border-radius: 5px;
                font-weight: 500;
                align-items: center;
                justify-content: center;
            }

            .Choicefile:hover {
                text-decoration: none;
                color: white;
            }

            #uploadfile,
            .removeimg {
                display: none;
            }

            #thumbbox {
                position: relative;
                width: 100%;
                margin-bottom: 20px;
            }

            .removeimg {
                height: 25px;
                position: absolute;
                background-repeat: no-repeat;
                top: 5px;
                left: 5px;
                background-size: 25px;
                width: 25px;
                /* border: 3px solid red; */
                border-radius: 50%;

            }

            .removeimg::before {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                content: '';
                border: 1px solid red;
                background: red;
                text-align: center;
                display: block;
                margin-top: 11px;
                transform: rotate(45deg);
            }

            .removeimg::after {
                /* color: #FFF; */
                /* background-color: #DC403B; */
                content: '';
                background: red;
                border: 1px solid red;
                text-align: center;
                display: block;
                transform: rotate(-45deg);
                margin-top: -2px;
            }
        </style>
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="logout"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px"
                                                alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item haha" href="banhang"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                <li><a class="app-menu__item " href="index.html"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item active" href="userManage"><i class='app-menu__icon bx bx-id-card'></i>
                        <span class="app-menu__label">Quản lý nhân viên</span></a></li>
                <li><a class="app-menu__item" href="#"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Quản lý khách hàng</span></a></li>
                <li><a class="app-menu__item" href="table-data-product.html"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>
                <li><a class="app-menu__item" href="table-data-oder.html"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý đơn hàng</span></a></li>
                <li><a class="app-menu__item" href="table-data-banned.html"><i class='app-menu__icon bx bx-run'></i><span
                            class="app-menu__label">Quản lý nội bộ
                        </span></a></li>
                <li><a class="app-menu__item" href="table-data-money.html"><i class='app-menu__icon bx bx-dollar'></i><span
                            class="app-menu__label">Bảng kê lương</span></a></li>
                <li><a class="app-menu__item" href="quan-ly-bao-cao.html"><i
                            class='app-menu__icon bx bx-pie-chart-alt-2'></i><span class="app-menu__label">Báo cáo doanh thu</span></a>
                </li>
                <li><a class="app-menu__item" href="page-calendar.html"><i class='app-menu__icon bx bx-calendar-check'></i><span
                            class="app-menu__label">Lịch công tác </span></a></li>
                <li><a class="app-menu__item" href="#"><i class='app-menu__icon bx bx-cog'></i><span class="app-menu__label">Cài
                            đặt hệ thống</span></a></li>
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item">Danh sách nhân viên</li>
                    <li class="breadcrumb-item"><a href="#">Thêm nhân viên</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="tile">

                        <h3 class="tile-title">Tạo mới nhân viên</h3>
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#exampleModalCenter"><b><i
                                                class="fas fa-folder-plus"></i> Tạo chức vụ mới</b></a>
                                </div>

                            </div> 
                            <c:if test="${not empty errorMessage}">
                                <p style="color:red">${errorMessage}</p>
                            </c:if>
                            <form class="row" action="addUser" method="POST" enctype="multipart/form-data">
                                <div class="form-group col-md-4">
                                    <label class="control-label">FirstName</label>
                                    <input class="form-control" type="text" value="<%= request.getAttribute("firstname") != null ? request.getAttribute("firstname") : "" %>" name="firstName" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">LastName</label>
                                    <input class="form-control" type="text" value="<%= request.getAttribute("lastname") != null ? request.getAttribute("lastname") : "" %>" name="lastName" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Email</label>
                                    <input class="form-control" type="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" name="email" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Số điện thoại</label>
                                    <input class="form-control" type="text" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>" name="phone" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Address</label>
                                    <input class="form-control" type="text" value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>" name="address">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Password</label>
                                    <input class="form-control" id="password" type="password" value="<%= request.getAttribute("pass") != null ? request.getAttribute("pass") : "" %>" name="password" required>
                                    <input type="checkbox" id="togglePassword"> Hiển thị mật khẩu
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="exampleSelect1" class="control-label">Chức vụ</label>
                                    <select class="form-control" id="exampleSelect1" name="role">
                                        <option>-- Chọn chức vụ --</option>
                                        <c:forEach var="role" items="${roles}">
                                            <option value="${role.roleID}">${role.roleName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group col-md-12">
                                    
                                    <label class="control-label">Ảnh 3x4 nhân viên</label>
                                    <p id="error-message" class="error" style="color: red"></p> <!-- Thông báo lỗi -->
                                    <div id="myfileupload">
                                        <input type="file" id="uploadfile" name="ImageUpload" onchange="readURL(this);" />
                                    </div>

                                    <div id="thumbbox">
                                        <img height="300" width="300" alt="Thumb image" id="thumbimage" style="display: none" />
                                        <a class="removeimg" href="javascript:" onclick="removeImage()"></a>
                                    </div>

                                    <div id="boxchoice">
                                        <a href="javascript:" class="Choicefile"><i class='bx bx-upload'></i> Chọn file</a>
                                        <p style="clear:both"></p>
                                    </div>
                                </div>
                                <button class="btn btn-save" type="submit">Lưu lại</button>
                                <a class="btn btn-cancel" href="userManage">Hủy bỏ</a>
                            </form>

                        </div>
                    </div>

                    </main>


                    <!--
                    MODAL
                    -->
                    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                         data-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">

                                <div class="modal-body">
                                    <div class="row">
                                        <div class="form-group  col-md-12">
                                            <span class="thong-tin-thanh-toan">
                                                <h5>Tạo chức vụ mới</h5>
                                            </span>
                                        </div>
                                        <div class="form-group col-md-12">
                                            <label class="control-label">Nhập tên chức vụ mới</label>
                                            <input class="form-control" type="text" required>
                                        </div>
                                    </div>
                                    <BR>
                                    <button class="btn btn-save" type="button">Lưu lại</button>
                                    <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                    <BR>
                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--
                    MODAL
                    -->


                    <!-- Essential javascripts for application to work-->
                    <script src="js/jquery-3.2.1.min.js"></script>
                    <script src="js/popper.min.js"></script>
                    <script src="js/bootstrap.min.js"></script>
                    <script src="js/main.js"></script>
                    <!-- The javascript plugin to display page loading on top-->
                    <script src="js/plugins/pace.min.js"></script>
                    <script>
                                            const togglePassword = document.getElementById('togglePassword');
                                            const passwordInput = document.getElementById('password');

                                            togglePassword.addEventListener('change', function () {
                                                if (this.checked) {
                                                    passwordInput.type = 'text';  // Hiện mật khẩu
                                                } else {
                                                    passwordInput.type = 'password';  // Ẩn mật khẩu
                                                }
                                            });
                    </script>

                    <script>
                        // Hàm kiểm tra file hợp lệ
                        function validateFile(file) {
                            const validImageTypes = ["image/jpeg", "image/png", "image/gif"];
                            const maxFileSize = 2 * 1024 * 1024; // 2MB giới hạn kích thước

                            // Kiểm tra loại file và kích thước file
                            if (!validImageTypes.includes(file.type)) {
                                return "Chỉ cho phép file ảnh (JPEG, PNG, GIF).";
                            }
                            if (file.size > maxFileSize) {
                                return "Kích thước ảnh phải nhỏ hơn 2MB.";
                            }
                            return null;
                        }

                        // Hàm hiển thị ảnh xem trước và validate file
                        function readURL(input) {
                            if (input.files && input.files[0]) { // Sử dụng cho Firefox - Chrome
                                const file = input.files[0];
                                const error = validateFile(file);

                                if (error) {
                                    // Hiển thị thông báo lỗi và reset input nếu file không hợp lệ
                                    $("#error-message").text(error);
                                    input.value = ""; // Reset input file
                                    $("#thumbimage").hide();
                                    $(".removeimg").hide();
                                    $(".Choicefile").css('background', '#14142B').css('cursor', 'pointer');
                                    $(".filename").text("");
                                    return;
                                }

                                // Nếu hợp lệ, hiển thị ảnh xem trước
                                const reader = new FileReader();
                                reader.onload = function (e) {
                                    $("#thumbimage").attr('src', e.target.result).show();
                                    $(".removeimg").show();
                                    $(".Choicefile").css('background', '#14142B').css('cursor', 'default');
                                    $(".filename").text(input.files[0].name); // Hiển thị tên file
                                }
                                reader.readAsDataURL(file);
                                $("#error-message").text(""); // Xóa thông báo lỗi
                            } else { // Sử dụng cho IE
                                $("#thumbimage").attr('src', input.value).show();
                            }
                        }

                        $(document).ready(function () {
                            $(".Choicefile").bind('click', function () {
                                $("#uploadfile").click();
                            });
                            $(".removeimg").click(function () {
                                $("#thumbimage").attr('src', '').hide();
                                $("#myfileupload").html('<input type="file" id="uploadfile" onchange="readURL(this);" />');
                                $(".removeimg").hide();
                                $(".Choicefile").bind('click', function () {
                                    $("#uploadfile").click();
                                });
                                $('.Choicefile').css('background', '#14142B').css('cursor', 'pointer');
                                $(".filename").text("");
                                $("#error-message").text(""); // Reset thông báo lỗi
                            });
                        });
                    </script>


                    </body>

                    </html>
