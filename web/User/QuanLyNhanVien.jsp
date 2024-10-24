<%-- 
    Document   : QuanLyNhanVien
    Created on : 19 Sep 2024, 11:13:20 am
    Author     : ptrung
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dao.RoleDAO" %>
<%
    RoleDAO roleDAO = new RoleDAO(); // Khởi tạo đối tượng RoleDAO
%>
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
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách nhân viên</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">

                            <div class="row element-button">
                                <div class="col-sm-2">

                                    <a class="btn btn-add btn-sm" href="addUser" title="Thêm"><i class="fas fa-plus"></i>
                                        Tạo mới nhân viên</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm nhap-tu-file" type="button" title="Nhập" onclick="myFunction(this)"><i
                                            class="fas fa-file-upload"></i> Tải từ file</a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()"><i
                                            class="fas fa-print"></i> In dữ liệu</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file js-textareacopybtn" type="button" title="Sao chép"><i
                                            class="fas fa-copy"></i> Sao chép</a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-excel btn-sm" href="" title="In"><i class="fas fa-file-excel"></i> Xuất Excel</a>
                                </div>
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm pdf-file" type="button" title="In" onclick="xuatPDF()">
                                        <i class="fas fa-file-pdf"></i> Xuất PDF
                                    </a>
                                </div>

                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm" type="button" title="Xóa" onclick="myFunction(this)"><i
                                            class="fas fa-trash-alt"></i> Xóa tất cả </a>
                                </div>
                            </div>

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>
                                        <th width="10"><input type="checkbox" id="all"></th>
                                        <th>Img</th>
                                        <th>ID nhân viên</th>
                                        <th width="150">Họ và tên</th>
                                        <th width="170">Email</th>
                                        <th width="170">Địa chỉ</th>
                                        <th>Số điện thoại</th>
                                        <th>Chức vụ</th>
                                        <th width="100">Tính năng</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="user" items="${requestScope.userList}">
                                        <tr>
                                            <td width="10"><input type="checkbox"></td>
                                            <td><img src="${user.img}" alt="User Image" style="width:100px;height:100px;"></td>
                                            <td>${user.userID}</td>
                                            <td>${user.firstName} ${user.lastName}</td>
                                            <td>${user.email}</td>
                                            <td>${user.address}</td>
                                            <td>${user.phoneNumber}</td>
                                            <td>${roleMap[user.roleID]}</td>
                                            <td>
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" 
                                                        onclick="window.location.href = 'updateUser?userID=${user.userID}'">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"
                                                        onclick="deleteUser(${user.userID})"><i class="fas fa-trash-alt"></i></button>
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



        <!-- Essential javascripts for application to work-->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
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
            function xuatPDF() {
                const {jsPDF} = window.jspdf;
                const doc = new jsPDF();

                // Tiêu đề PDF
                doc.setFontSize(18);
                doc.text("Danh sách nhân viên", 14, 20);

                // Tạo dữ liệu cho bảng
                const rows = [];
                const tableHeader = ['ID', 'Tên', 'Email', 'Địa chỉ', 'Số điện thoại', 'Vai trò'];

                const tableRows = document.querySelectorAll("tbody tr");
                tableRows.forEach((row) => {
                    const userID = row.cells[2].innerText; // userID
                    const fullName = row.cells[3].innerText; // Tên đầy đủ
                    const email = row.cells[4].innerText; // Email
                    const address = row.cells[5].innerText; // Địa chỉ
                    const phoneNumber = row.cells[6].innerText; // Số điện thoại
                    const roleID = row.cells[7].innerText; // Vai trò

                    // Thêm thông tin vào hàng bảng
                    rows.push([userID, fullName, email, address, phoneNumber, roleID]);
                });

                // Sử dụng autoTable để tạo bảng
                doc.autoTable({
                    head: [tableHeader],
                    body: rows,
                    startY: 30, // Vị trí bắt đầu
                    theme: 'grid', // Chủ đề của bảng
                    headStyles: {fillColor: [22, 160, 133]}, // Màu nền tiêu đề
                    styles: {cellWidth: 'auto', halign: 'left'}, // Định dạng các ô
                    margin: {top: 30}
                });

                // Tải xuống tệp PDF
                doc.save('danh_sach_nhan_vien.pdf');
            }
        </script>


        <script>
            $('#saveChangesBtn').on('click', function () {
                var user = {
                    userID: $('#ModalUP input[name="userID"]').val(),
                    firstName: $('#ModalUP input[name="firstName"]').val(),
                    lastName: $('#ModalUP input[name="lastName"]').val(),
                    phoneNumber: $('#ModalUP input[name="phoneNumber"]').val(),
                    email: $('#ModalUP input[name="email"]').val(),
                    roleID: $('#ModalUP select[name="roleID"]').val()
                };

                $.ajax({
                    url: 'updateUser', // URL của servlet để cập nhật thông tin
                    type: 'POST',
                    data: user,
                    success: function (response) {
                        swal("Đã cập nhật thành công!", {
                            icon: "success"
                        }).then(() => {
                            location.reload(); // Reload trang sau khi cập nhật
                        });
                    },
                    error: function () {
                        swal("Cập nhật thất bại!", {
                            icon: "error"
                        });
                    }
                });
            });

        </script>
        <script>
            function loadUserData(userID) {
                $.ajax({
                    url: 'getUser', // URL của servlet lấy thông tin người dùng
                    type: 'GET',
                    data: {id: userID},
                    success: function (user) {
                        // Hiển thị dữ liệu vào modal
                        $('#ModalUP input[name="userID"]').val(user.userID);
                        $('#ModalUP input[name="firstName"]').val(user.firstName);
                        $('#ModalUP input[name="lastName"]').val(user.lastName);
                        $('#ModalUP input[name="phoneNumber"]').val(user.phoneNumber);
                        $('#ModalUP input[name="email"]').val(user.email);
                        $('#ModalUP select[name="roleID"]').val(user.roleID);
                    },
                    error: function () {
                        swal("Không thể tải dữ liệu người dùng!", {
                            icon: "error"
                        });
                    }
                });
            }
        </script>
        <script>
            function deleteUser(userID) {
                swal({
                    title: "Cảnh báo",
                    text: "Bạn có chắc chắn muốn xóa nhân viên này?",
                    buttons: ["Hủy bỏ", "Đồng ý"]
                }).then((willDelete) => {
                    if (willDelete) {
                        $.ajax({
                            url: 'deleteUser', // URL của servlet xử lý xóa người dùng
                            type: 'POST',
                            data: {id: userID},
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
            function deleteRow(r) {
                var i = r.parentNode.parentNode.rowIndex;
                document.getElementById("myTable").deleteRow(i);
            }
            jQuery(function () {
                jQuery(".trash").click(function () {
                    swal({
                        title: "Cảnh báo",

                        text: "Bạn có chắc chắn là muốn xóa nhân viên này?",
                        buttons: ["Hủy bỏ", "Đồng ý"],
                    })
                            .then((willDelete) => {
                                if (willDelete) {
                                    swal("Đã xóa thành công.!", {

                                    });
                                }
                            });
                });
            });
            oTable = $('#sampleTable').dataTable();
            $('#all').click(function (e) {
                $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
                e.stopImmediatePropagation();
            });

            //EXCEL
            // $(document).ready(function () {
            //   $('#').DataTable({

            //     dom: 'Bfrtip',
            //     "buttons": [
            //       'excel'
            //     ]
            //   });
            // });


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
            //In dữ liệu
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('sampleTable');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }
            //     //Sao chép dữ liệu
            //     var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

            // copyTextareaBtn.addEventListener('click', function(event) {
            //   var copyTextarea = document.querySelector('.js-copytextarea');
            //   copyTextarea.focus();
            //   copyTextarea.select();

            //   try {
            //     var successful = document.execCommand('copy');
            //     var msg = successful ? 'successful' : 'unsuccessful';
            //     console.log('Copying text command was ' + msg);
            //   } catch (err) {
            //     console.log('Oops, unable to copy');
            //   }
            // });



        </script>
    </body>

</html>