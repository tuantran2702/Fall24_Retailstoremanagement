<%-- 
    Document   : Permissions
    Created on : 16 Oct 2024, 12:56:53 am
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
                    <li class="breadcrumb-item active"><a href="roles"><b>Permissions List</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">

                            <div class="row element-button">
                                <div class="col-sm-2">

                                    <a class="btn btn-add btn-sm" href="addPermission" title="Thêm"><i class="fas fa-plus"></i>
                                        Tạo mới phân quyền</a>
                                </div>
                            </div>

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th width="10">ID phân quyền</th>
                                        <th width="180">Tên phân quyền</th>
                                        <th width="100">Tính năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Sử dụng JSTL để lặp qua danh sách quyền hạn -->
                                    <c:forEach var="permission" items="${permissionList}">
                                        <tr>
                                            <td>${permission.id}</td>
                                            <td>${permission.permissionName}</td>
                                            <td>
                                                <!-- Nút Sửa -->
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" 
                                                        onclick="loadPermissionData('${permission.id}'); $('#updatePermissionModal').modal('show');">
                                                    <i class="fas fa-edit"></i>
                                                </button>

                                                <!-- Nút Xóa -->
                                                <button class="btn btn-danger btn-sm trash" type="button" title="Xóa"
                                                        onclick="deletePermission(${permission.id})">
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
        <div class="modal fade" id="updatePermissionModal" tabindex="-1" role="dialog" aria-labelledby="updatePermissionModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updatePermissionModalLabel">Update Permission</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <!-- Form cập nhật quyền -->
                    <form id="updatePermissionForm" method="POST">
                        <div class="modal-body">
                            <!-- ID quyền -->
                            <input type="hidden" name="permissionID" id="permissionID">

                            <!-- Tên quyền -->
                            <div class="form-group">
                                <label for="permissionName">Permission Name</label>
                                <input type="text" class="form-control" id="permissionName" name="permissionName" required>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>




        <!-- Essential javascripts for application to work-->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
        <script src="js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
        
        <!-- Font Awesome cho biểu tượng -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script type="text/javascript">$('#sampleTable').DataTable();</script>





        <script>
            // Hàm tải dữ liệu quyền vào modal
            function loadPermissionData(permissionID) {
                $.ajax({
                    url: 'getPermission', // URL của servlet
                    type: 'GET',
                    data: {
                        action: 'getPermission', // Thêm action để servlet nhận diện
                        id: permissionID
                    },
                    success: function (permission) {
                        if (permission) {
                            // Đẩy dữ liệu vào các trường trong form
                            $('#updatePermissionForm #permissionID').val(permission.id);
                            $('#updatePermissionForm #permissionName').val(permission.permissionName);
                        }
                    },
                    error: function () {
                        swal("Không thể tải dữ liệu quyền!", {icon: "error"});
                    }
                });
            }

            // Hàm cập nhật quyền
            $(document).ready(function () {
                $('#updatePermissionForm').submit(function (e) {
                    e.preventDefault(); // Ngăn submit mặc định

                    var formData = $(this).serialize() + '&action=updatePermission'; // Thêm action vào dữ liệu

                    $.ajax({
                        url: 'getPermission',
                        type: 'POST',
                        data: formData,
                        success: function (response) {
                            if (response.status === "success") {
                                swal(response.message, {icon: "success"}).then(() => {
                                    location.reload(); // Reload lại trang sau khi cập nhật thành công
                                });
                            } else {
                                swal(response.message, {icon: "error"});
                            }
                        },
                        error: function () {
                            swal("Không thể cập nhật quyền!", {icon: "error"});
                        }
                    });
                });
            });

            // Hàm xóa quyền
            function deletePermission(permissionID) {
                swal({
                    title: "Cảnh báo",
                    text: "Bạn có chắc chắn muốn xóa quyền này?",
                    buttons: ["Hủy bỏ", "Đồng ý"],
                    dangerMode: true
                }).then((willDelete) => {
                    if (willDelete) {
                        $.ajax({
                            url: 'getPermission',
                            type: 'POST',
                            data: {
                                action: 'deletePermission', // Thêm action để xác định xóa quyền
                                id: permissionID
                            },
                            success: function (response) {
                                if (response.status === "success") {
                                    swal("Đã xóa thành công!", {icon: "success"}).then(() => {
                                        location.reload(); // Reload trang để cập nhật danh sách
                                    });
                                } else {
                                    swal(response.message, {icon: "error"});
                                }
                            },
                            error: function () {
                                swal("Xóa thất bại!", {icon: "error"});
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