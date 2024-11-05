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
        <title>Update Employee | GROUP1</title>
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
                    <li class="breadcrumb-item"><a href="userManage">Emloyees List</a></li>
                    <li class="breadcrumb-item"><a href="">Update Employee</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="tile">

                        <h3 class="tile-title">Update Employee</h3>
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" href="addRole"><b><i
                                                class="fas fa-folder-plus"></i> Add New Role</b></a>
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
                                    <label class="control-label">FirstName</label>
                                    <input class="form-control" type="text" value="<%= ((User) request.getAttribute("user")).getFirstName() != null ? ((User) request.getAttribute("user")).getFirstName() : "" %>" name="firstName" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">LastName</label>
                                    <input class="form-control" type="text" value="<%= ((User) request.getAttribute("user")).getLastName() != null ? ((User) request.getAttribute("user")).getLastName() : "" %>" name="lastName" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Email</label>
                                    <input class="form-control" type="email" value="<%= ((User) request.getAttribute("user")).getEmail() != null ? ((User) request.getAttribute("user")).getEmail() : "" %>" name="email" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Phone Number</label>
                                    <input class="form-control" type="text" value="<%= ((User) request.getAttribute("user")).getPhoneNumber() != null ? ((User) request.getAttribute("user")).getPhoneNumber() : "" %>" name="phone" required>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Address</label>
                                    <input class="form-control" type="text" value="<%= ((User) request.getAttribute("user")).getAddress() != null ? ((User) request.getAttribute("user")).getAddress() : "" %>" name="address">
                                </div>
                                <div class="form-group col-md-4">
                                    <label for="exampleSelect1" class="control-label">Role</label>
                                    <select class="form-control" id="exampleSelect1" name="role">
                                        <option>-- Select Role --</option>
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

                                    <label class="control-label">Employee 3x4 Image</label>
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

                                <button class="btn btn-save" type="submit">Save Change</button>
                                <a class="btn btn-cancel" href="userManage">Cancel</a>
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
                                            // Hàm kiểm tra file hợp lệ
                                            function validateFile(file) {
                                                const validImageTypes = ["image/jpeg", "image/png", "image/gif"];
                                                const maxFileSize = 2 * 1024 * 1024; // 2MB giới hạn kích thước
                                                if (!validImageTypes.includes(file.type))
                                                    return "Only image files (JPEG, PNG, GIF) are allowed.";
                                                if (file.size > maxFileSize)
                                                    return "Image size must be less than 2MB.";
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