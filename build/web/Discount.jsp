<%-- 
    Document   : QuanLyNhanVien
    Created on : 19 Sep 2024, 11:13:20 am
    Author     : ptrung
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="com.google.gson.Gson" %>




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

                                    <a class="btn btn-add btn-sm" href="addDiscount" title="Thêm"><i class="fas fa-plus"></i>
                                        Add Discount</a>
                                </div>
                            </div>

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>
                                        <th width="auto">Discount ID</th>
                                        <th width="180">Discount Name</th>
                                        <th>Product</th>
                                        <th>Discount Percent</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Description</th>
                                        <th width="100">Tính năng</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="d" items="${requestScope.discountList}">
                                        <tr>
                                            <td>${d.discountID}</td>
                                            <td>${d.discountName}</td>
                                            <td>${productMap[d.productID]}</td>
                                            <td>${d.discountPercent}</td>
                                            <td>${d.startDate}</td>
                                            <td>${d.endDate}</td>
                                            <td>${d.description}</td>
                                            <td>
                                                <!-- Edit Button -->
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Edit" 
                                                        onclick="loadDiscountData('${d.discountID}'); $('#updateDiscountModal').modal('show');">
                                                    <i class="fas fa-edit"></i>
                                                </button>

                                                <!-- Delete Button -->
                                                <button class="btn btn-danger btn-sm trash" type="button" title="Delete"
                                                        onclick="deleteDiscount(${d.discountID})">
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


        <!-- Update Discount Modal -->
        <div class="modal fade" id="updateDiscountModal" tabindex="-1" role="dialog" aria-labelledby="updateDiscountModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <h3 class="tile-title">Update Discount</h3>

                    <!-- Update Discount Form -->
                    <form id="updateDiscountForm" method="POST">
                        <div class="modal-body">
                            <!-- Hidden field to hold discountID -->
                            <input name="discountID" value="" type="hidden"> 

                            <!-- Discount Name -->
                            <div class="form-group">
                                <label for="discountName">Discount Name</label>
                                <input type="text" class="form-control" id="discountName" name="discountName" value="" required>
                            </div>

                            <!-- Product -->
                            <div class="form-group">
                                <label for="productID">Product</label>
                                <select class="form-control" id="productID" name="productID" required>
                                    <!-- Options populated dynamically with JavaScript or backend data -->
                                </select>
                            </div>

                            <!-- Discount Percent -->
                            <div class="form-group">
                                <label for="discountPercent">Discount Percent</label>
                                <input type="number" class="form-control" id="discountPercent" name="discountPercent" value="" min="0" max="100" required>
                            </div>

                            <!-- Start Date -->
                            <div class="form-group">
                                <label for="startDate">Start Date</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" value="" required>
                            </div>

                            <!-- End Date -->
                            <div class="form-group">
                                <label for="endDate">End Date</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" value="" required>
                            </div>

                            <!-- Description -->
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
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

        <%
            // Lấy dữ liệu từ database và gắn vào attribute request
            Map<Integer, String> productMapFromDB = new ProductDAO().getProductMapFromDB();
            request.setAttribute("productMap", productMapFromDB);
        %>

        <script>
            // Giả sử productMap có sẵn dưới dạng một đối tượng JavaScript (có thể được đưa từ JSP hoặc qua API)
            let productMap = <%= new Gson().toJson(request.getAttribute("productMap")) %>;

// Hàm để nạp danh sách sản phẩm vào dropdown
            function populateProductDropdown() {
                let productSelect = $('#productID');
                productSelect.empty(); // Xóa các lựa chọn hiện có
                $.each(productMap, function (productID, productName) {
                    productSelect.append(new Option(productName, productID));
                });
            }

            // Load discount data into the modal
            // Trước tiên, nạp danh sách sản phẩm
            populateProductDropdown();
            // Hàm chuyển đổi định dạng ngày từ DD/MM/YYYY sang YYYY-MM-DD
            function formatDateToMMDDYYYY(dateStr) {
                if (dateStr.includes("/")) {
                    // Giả sử ngày đang ở dạng yyyy/mm/dd
                    let parts = dateStr.split("/");
                    return `${parts[1]}/${parts[2]}/${parts[0]}`; // Định dạng lại thành mm/dd/yyyy
                            }
                            return dateStr; // Trả về chuỗi ban đầu nếu không ở định dạng yyyy/mm/dd
                        }

                        function loadDiscountData(discountID) {
                            $.ajax({
                                url: 'getDiscount',
                                type: 'GET',
                                data: {action: 'getDiscount', discountID: discountID},
                                success: function (response) {
                                    $('#updateDiscountModal').find('input[name="discountID"]').val(response.discountID);
                                    $('#updateDiscountModal').find('input[name="discountName"]').val(response.discountName);
                                    $('#updateDiscountModal').find('select[name="productID"]').val(response.productID);
                                    $('#updateDiscountModal').find('input[name="discountPercent"]').val(response.discountPercent);

                                    // Định dạng ngày thành YYYY-MM-DD
                                    let startDate = formatDateToMMDDYYYY("2023/11/12");
                                    let endDate = formatDateToMMDDYYYY(response.endDate);

                                    $('#updateDiscountModal').find('input[name="startDate"]').val("08/11/2003");
                                    $('#updateDiscountModal').find('input[name="endDate"]').val(endDate);

                                    $('#updateDiscountModal').find('textarea[name="description"]').val(response.description);
                                },
                                error: function (error) {
                                    console.error('Error loading discount data:', error);
                                    alert('Failed to load discount data.');
                                }
                            });
                        }


                        // Delete discount function
                        function deleteDiscount(discountID) {
                            if (confirm("Are you sure you want to delete this discount?")) {
                                $.ajax({
                                    url: 'DiscountServlet',
                                    type: 'POST',
                                    data: {action: 'deleteDiscount', discountID: discountID},
                                    success: function (response) {
                                        if (response.success) {
                                            alert('Discount deleted successfully.');
                                            location.reload(); // Reload page to reflect changes
                                        } else {
                                            alert('Failed to delete discount.');
                                        }
                                    },
                                    error: function (error) {
                                        console.error('Error deleting discount:', error);
                                        alert('Failed to delete discount.');
                                    }
                                });
                            }
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