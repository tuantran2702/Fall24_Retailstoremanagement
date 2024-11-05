<%-- 
    Document   : QuanLyNhanVien
    Created on : 19 Sep 2024, 11:13:20 am
    Author     : ptrung
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Danh sách nhân viên | Quản trị Admin</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="doc/css/main.css">
        <link rel="stylesheet" type="text/css" href="css/main_2.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

    </head>
    <style>
        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* Tạo 2 cột với chiều rộng bằng nhau */
            gap: 10px; /* Khoảng cách giữa các checkbox */
        }

        .checkbox-group label {
            display: inline-block;
            margin-bottom: 10px; /* Tùy chỉnh khoảng cách giữa các nhãn */
        }

        .tile-title {
            margin-top: 10px;
            font-size: 24px; /* Kích thước chữ */
            font-weight: bold; /* Chữ đậm */
            color: #333; /* Màu chữ */
            text-align: center; /* Canh giữa chữ */
            text-transform: uppercase; /* Chuyển đổi chữ thường thành chữ in hoa */
            border-bottom: 2px solid #007bff; /* Đường gạch dưới */
        }
        /* Nút lưu lại và hủy bỏ */
        .btnn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-save {
            background-color: #28a745;
            color: white;
            margin-right: 10px;
        }

        .btn-save:hover {
            background-color: #218838;
        }

        .btn-cancel {
            background-color: #dc3545;
            color: white;
        }

        .btn-cancel:hover {
            background-color: #c82333;
        }


    </style>

    <body onload="time()" class="app sidebar-mini rtl">
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
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="roles"><b>Danh sách Phân Quyền</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">

                            <div class="row element-button">
                                <div class="col-sm-2">

                                    <a class="btn btn-add btn-sm" href="addRole" title="Thêm"><i class="fas fa-plus"></i>
                                        Tạo mới Phân Quyền</a>
                                </div>
                            </div>

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>
                                        <th width="10">RoleID</th>
                                        <th width="180">Role Name</th>
                                        <th>Description</th>
                                        <th width="100">Tính năng</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="r" items="${requestScope.roleList}">
                                        <tr>
                                            <td>${r.roleID}</td>
                                            <td>${r.roleName}</td>
                                            <td>${r.description}</td>
                                            <td>
                                                <!-- Nút Sửa -->
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" 
                                                        onclick="loadRoleData('${r.roleID}'); $('#updateRoleModal').modal('show');">
                                                    <i class="fas fa-edit"></i>
                                                </button>

                                                <!-- Nút Xóa -->
                                                <button class="btn btn-danger btn-sm trash" type="button" title="Xóa"
                                                        onclick="deleteRole(${r.roleID})">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>


        <!-- Modal -->
        <div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="updateRoleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <h3 class="tile-title">Update Role</h3>

                    <!-- Form cập nhật role -->
                    <form id="updateRoleForm" method="POST">
                        <div class="modal-body">
                            <!-- Tên vai trò -->
                            <input name="roleID" value="" style="display: none"> <!-- Hidden field để giữ roleID -->
                            <div class="form-group">
                                <label for="roleName">Role Name</label>
                                <input type="text" class="form-control" id="roleName" name="roleName" value="" required>
                            </div>

                            <!-- Mô tả vai trò -->
                            <div class="form-group">
                                <label for="description">Description</label>
                                <input type="text" class="form-control" id="description" name="description" value="" required>
                            </div>

                            <!-- Danh sách quyền (permissions) -->
                            <div class="form-group">
                                <label for="permissions">Permissions</label>
                                <div class="checkbox-group">
                                    <!-- Danh sách checkbox sẽ được thêm qua JavaScript -->
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btnn btn-cancel" data-dismiss="modal">Close</button>
                            <button type="submit" class="btnn btn-save">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>







        <!-- Essential javascripts for application to work-->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="src/jquery.table2excel.js"></script>
        <script src="js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
        <!-- Thêm jsPDF -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <!-- Thêm autoTable -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.10/jspdf.plugin.autotable.min.js"></script>
        <!-- Font Awesome cho biểu tượng -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script type="text/javascript">$('#sampleTable').DataTable();</script>

        

        <script>
            // Hàm tải dữ liệu vai trò vào modal
            function loadRoleData(roleID) {
                $.ajax({
                    url: 'getRole', // URL của servlet để lấy dữ liệu vai trò
                    type: 'GET',
                    data: {id: roleID},
                    success: function (role) {
                        if (role) {
                            // Hiển thị dữ liệu vai trò vào form modal
                            $('#updateRoleForm input[name="roleName"]').val(role.roleName);
                            $('#updateRoleForm input[name="description"]').val(role.description);
                            $('#updateRoleForm input[name="roleID"]').val(role.roleID); // Hidden field
                            // Hiển thị các quyền hạn trong modal
                            $('.checkbox-group').empty();
                            $.each(role.allPermissions, function (index, permission) {
                                // Kiểm tra xem quyền hạn này có nằm trong danh sách assignedPermissions hay không
                                var checked = role.assignedPermissions.includes(String(permission.permissionName)) ? 'checked' : '';

                                // Tạo checkbox cho mỗi quyền hạn
                                $('.checkbox-group').append(
                                        '<div class="form-check">' +
                                        '<input class="form-check-input" type="checkbox" name="permissions" value="' + permission.id + '" ' + checked + '>' +
                                        '<label class="form-check-label">' + permission.permissionName + '</label>' +
                                        '</div>'
                                        );
                            });


                        }
                    },
                    error: function () {
                        swal("Không thể tải dữ liệu vai trò!", {icon: "error"});
                    }
                });
            }





            // Hàm cập nhật vai trò
            $(document).ready(function () {
                $('#updateRoleForm').submit(function (e) {
                    e.preventDefault(); // Ngăn submit mặc định

                    var formData = $(this).serialize(); // Lấy dữ liệu từ form

                    $.ajax({
                        url: 'getRole',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            // Không cần JSON.parse() vì response đã là đối tượng JavaScript
                            console.log("Response from server:", response);

                            if (response.status === "success") {
                                swal(response.message, {icon: "success"}).then(() => {
                                    location.reload(); // Reload lại trang sau khi cập nhật thành công
                                });
                            } else {
                                swal(response.message, {icon: "error"});
                            }
                        },
                        error: function () {
                            swal("Không thể cập nhật vai trò!", {icon: "error"});
                        }
                    });

                });
            });



            //Ham Xoa Role
            function deleteRole(roleID) {
                swal({
                    title: "Cảnh báo",
                    text: "Bạn có chắc chắn muốn xóa vai trò này?",
                    buttons: ["Hủy bỏ", "Đồng ý"],
                    dangerMode: true
                }).then((willDelete) => {
                    if (willDelete) {
                        $.ajax({
                            url: 'deleteRole', // URL servlet xử lý xóa vai trò
                            type: 'POST',
                            data: {id: roleID},
                            success: function (response) {
                                swal("Đã xóa thành công!", {
                                    icon: "success"
                                }).then(() => {
                                    location.reload(); // Reload trang để cập nhật danh sách
                                });
                            },
                            error: function () {
                                swal("Xóa thất bại!", {
                                    icon: "error"
                                });
                            }
                        });
                    }
                });
            }


        </script>
        <script>

            //Thời Gian
            function time() {
                var today = new Date();
                var weekday = new Array(7);
                weekday[0] = "Chủ Nhật";
                weekday[1] = "Thứ Hai";
                weekday[2] = "Thứ Ba";
                weekday[3] = "Thứ Tư";
                weekday[4] = "Thứ Năm";
                weekday[5] = "Thứ Sáu";
                weekday[6] = "Thứ Bảy";
                var day = weekday[today.getDay()];
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                m = checkTime(m);
                s = checkTime(s);
                nowTime = h + " giờ " + m + " phút " + s + " giây";
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }
                today = day + ', ' + dd + '/' + mm + '/' + yyyy;
                tmp = '<span class="date"> ' + today + ' - ' + nowTime +
                        '</span>';
                document.getElementById("clock").innerHTML = tmp;
                clocktime = setTimeout("time()", "1000", "Javascript");

                function checkTime(i) {
                    if (i < 10) {
                        i = "0" + i;
                    }
                    return i;
                }
            }




        </script>
    </body>

</html>