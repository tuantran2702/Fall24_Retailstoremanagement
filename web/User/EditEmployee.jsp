<%-- 
    Document   : EditEmployee
    Created on : 4 Oct 2024, 5:05:29 pm
    Author     : ptrung
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Cập nhật nhân viên | GROUP1</title>
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
        <!-- Include menu -->
        <jsp:include page="/menu.jsp" />


        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="userManage">Danh sách nhân viên</a></li>
                    <li class="breadcrumb-item"><a href="">Cập nhật nhân viên</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="tile">

                        <h3 class="tile-title">Cập nhật nhân viên</h3>
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" href="addRole"><b><i
                                                class="fas fa-folder-plus"></i>Tạo chức vụ</b></a>
                                </div>

                            </div> 
                            <c:if test="${not empty errorMessage}">
                                <p style="color:red">${errorMessage}</p>
                            </c:if>
                            <form class="row" action="updateUser" method="POST" enctype="multipart/form-data">
                                <div class="form-group col-md-12">
                                    <label class="control-label">ID</label>
                                    <input class="form-control" type="text" value="<%= ((User) request.getAttribute("user")) != null ? ((User) request.getAttribute("user")).getUserID() : "" %>" name="userID" readonly="true" required style="max-width: 15%">
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Họ</label>
                                    <input class="form-control" type="text" value="<%= ((User) request.getAttribute("user")).getFirstName() != null ? ((User) request.getAttribute("user")).getFirstName() : "" %>" name="firstName" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Tên</label>
                                    <input class="form-control" type="text" value="<%= ((User) request.getAttribute("user")).getLastName() != null ? ((User) request.getAttribute("user")).getLastName() : "" %>" name="lastName" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Email</label>
                                    <!-- Thẻ span để hiển thị lỗi cho trường Email -->
                                    <span id="emailError" style="color:red; display:none;">Vui lòng nhập email hợp lệ.</span>
                                    <input class="form-control" type="email" name="email" id="emailInput" required>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="control-label">Số điện thoại</label>
                                    <!-- Thẻ span để hiển thị lỗi cho trường Số điện thoại -->
                                    <span id="phoneError" style="color:red; display:none;">Vui lòng nhập số điện thoại hợp lệ (ít nhất 10 chữ số).</span>
                                    <input class="form-control" type="text" name="phone" id="phoneInput" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Địa chỉ</label>
                                    <input class="form-control" type="text" value="<%= ((User) request.getAttribute("user")).getAddress() != null ? ((User) request.getAttribute("user")).getAddress() : "" %>" name="address">
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="exampleSelect1" class="control-label">Role</label>
                                    <select class="form-control" id="exampleSelect1" name="role">
                                        <option>-- Chọn chức vụ --</option>
                                        <c:forEach var="role" items="${roles}">
                                            <option value="${role.roleID}" 
                                                    <c:if test="${role.roleID == user.roleID}">
                                                        selected="selected"
                                                    </c:if>>
                                                ${role.roleName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <div class="form-group col-md-12">

                                    <label class="control-label">Ảnh nhân viên 3x4</label>
                                    <p id="error-message" class="error" style="color: red"></p> <!-- Thông báo lỗi -->
                                    <div id="myfileupload">
                                        <input type="file" id="uploadfile" name="ImageUpload" onchange="readURL(this);" />
                                    </div>

                                    <div id="thumbbox">
                                        <img height="300" width="300" alt="Thumb image" id="thumbimage" 
                                             src="<%= ((User) request.getAttribute("user")).getImg() != null ? ((User) request.getAttribute("user")).getImg() : "" %>"
                                             style="<%= ((User) request.getAttribute("user")).getImg() != null ? "display: block;" : "display: none;" %>" />
                                        <a class="removeimg" href="javascript:" onclick="removeImage()"
                                           style="<%= ((User) request.getAttribute("user")).getImg() != null ? "display: block;" : "display: none;" %>"></a>
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





                    <!-- Essential javascripts for application to work-->
                    <script src="js/jquery-3.2.1.min.js"></script>
                    <script src="js/popper.min.js"></script>
                    <script src="js/bootstrap.min.js"></script>
                    <script src="js/main.js"></script>
                    <!-- The javascript plugin to display page loading on top-->
                    <script src="js/plugins/pace.min.js"></script>

                    <script>
                                            function validateForm() {
                                                let isValid = true;

                                                // Lấy các input và span lỗi
                                                let emailInput = document.getElementById("emailInput");
                                                let phoneInput = document.getElementById("phoneInput");
                                                let emailError = document.getElementById("emailError");
                                                let phoneError = document.getElementById("phoneError");

                                                // Reset thông báo lỗi
                                                emailError.style.display = "none";
                                                phoneError.style.display = "none";

                                                // Kiểm tra Email
                                                if (!isValidEmail(emailInput.value)) {
                                                    emailError.style.display = "block";
                                                    emailInput.focus();
                                                    isValid = false;
                                                }

                                                // Kiểm tra Số điện thoại
                                                if (!isValidPhoneNumber(phoneInput.value)) {
                                                    phoneError.style.display = "block";
                                                    if (isValid)
                                                        phoneInput.focus(); // Chỉ focus vào phoneInput nếu email đã hợp lệ
                                                    isValid = false;
                                                }

                                                return isValid;
                                            }

                                     // Hàm kiểm tra định dạng email
                                            function isValidEmail(email) {
                                                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                                return emailRegex.test(email);
                                            }

                                            // Hàm kiểm tra định dạng số điện thoại
                                            function isValidPhoneNumber(phone) {
                                                const phoneRegex = /^0\d{9}$/;
                                                return phoneRegex.test(phone);
                                            }

                                    // Gắn hàm validateForm vào sự kiện onsubmit của form
                                            document.querySelector("form").onsubmit = function () {
                                                return validateForm();
                                            };

                    </script>


                    <script>
                        // Hàm kiểm tra file hợp lệ
                        function validateFile(file) {
                            const validImageTypes = ["image/jpeg", "image/png", "image/gif"];
                            const maxFileSize = 2 * 1024 * 1024; // 2MB giới hạn kích thước
                            if (!validImageTypes.includes(file.type))
                                return "Chỉ cho phép file ảnh (JPEG, PNG, GIF).";
                            if (file.size > maxFileSize)
                                return "Ảnh phải có kích thước nhỏ hơn 2MB.";
                            return null;
                        }

                        // Hàm hiển thị ảnh xem trước và kiểm tra file
                        function readURL(input) {
                            const file = input.files?.[0];
                            if (!file)
                                return;

                            const error = validateFile(file);
                            if (error) {
                                displayError(error);
                                resetFileInput(input);
                                return;
                            }

                            // Hiển thị ảnh xem trước
                            const reader = new FileReader();
                            reader.onload = e => {
                                $("#thumbimage").attr('src', e.target.result).show();
                                $(".removeimg").show();
                                updateChoiceFileStyle(false);
                                $(".filename").text(file.name);
                                $("#error-message").text("");
                            };
                            reader.readAsDataURL(file);
                        }

                        function displayError(message) {
                            $("#error-message").text(message);
                        }

                        function resetFileInput(input) {
                            input.value = "";
                            $("#thumbimage").hide();
                            $(".removeimg").hide();
                            updateChoiceFileStyle(true);
                            $(".filename").text("");
                        }

                        function updateChoiceFileStyle(isReset) {
                            const style = isReset ? {background: '#14142B', cursor: 'pointer'} : {background: '#14142B', cursor: 'default'};
                            $(".Choicefile").css(style);
                        }

                        $(document).ready(function () {
                            $(".Choicefile").on('click', () => $("#uploadfile").click());

                            $(".removeimg").on('click', function () {
                                $("#thumbimage").hide().attr('src', '');
                                $("#myfileupload").html('<input type="file" id="uploadfile" onchange="readURL(this);" />');
                                $(".removeimg").hide();
                                updateChoiceFileStyle(true);
                                $(".filename").text("");
                                $("#error-message").text("");
                            });
                        });
                    </script>




                    </body>


                    </html>