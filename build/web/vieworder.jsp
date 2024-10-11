<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Warehouse List | Quản lý kho</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .quantity-input {
                width: 50px;
                padding: 5px;
                font-size: 14px; /* Font size */
                border: 1px solid #ccc; /* Border styling */
                border-radius: 4px; /* Rounded corners */
                text-align: center; /* Center the text */
                margin: 0 5px; /* Space between the buttons and the input */
            }
            .payment-button-container {
                margin-right: 5%;
                text-align: right; /* Align the button container to the right */
                margin-top: 20px; /* Space above the button */
            }

            .payment-button {
                display: inline-block; /* Make it an inline block element */
                padding: 12px 30px; /* Padding for the button */
                background-color: #28a745; /* Green background */
                color: white; /* White text color */
                font-size: 16px; /* Font size */
                border: none; /* No border */
                border-radius: 5px; /* Rounded corners */
                text-decoration: none; /* Remove underline */
                transition: background-color 0.3s, transform 0.3s; /* Animation for hover effect */
            }

            .payment-button:hover {
                background-color: #218838; /* Darker green on hover */
                transform: scale(1.05); /* Slightly scale up */
            }

            .payment-button:active {
                transform: scale(0.95); /* Scale down when pressed */
            }

            .payment-method-container {
                margin-bottom: 20px; /* Space below the combo box */
            }

            .payment-method-label {
                font-size: 14px; /* Font size for label */
                margin-bottom: 5px; /* Space below the label */
                display: block; /* Make label a block element */
            }

            .payment-method-select {
                width: 100%; /* Full width */
                padding: 10px; /* Padding inside the combo box */
                font-size: 14px; /* Font size */
                border: 1px solid #ccc; /* Border styling */
                border-radius: 4px; /* Rounded corners */
                background-color: #fff; /* Background color */
                appearance: none; /* Remove default arrow for a custom look */
                background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20"><polygon points="0,0 20,0 10,10" fill="%23999"/></svg>'); /* Custom arrow */
                background-repeat: no-repeat; /* Prevent background image repetition */
                background-position: right 10px center; /* Position the arrow */
                background-size: 12px; /* Size of the arrow */
                cursor: pointer; /* Change cursor to pointer */
            }

            /* Optional: Change border color on focus */
            .payment-method-select:focus {
                border-color: #28a745; /* Change to a green color */
                outline: none; /* Remove outline */
            }

            .total-amount-container {
                margin-bottom: 20px; /* Khoảng cách giữa tổng tiền và biểu mẫu */
                font-weight: bold; /* Đậm cho tổng tiền */
            }

            .total-amount-label {
                margin-right: 1%; /* Khoảng cách giữa nhãn và giá trị */
            }

            .total-amount-value {
                color: #ff5722; /* Màu sắc cho tổng tiền */
            }

            .discount-code-container {
                margin-top: 50px;
                margin-bottom: 20px; /* Khoảng cách dưới */
            }

            .discount-code-label {
                font-size: 14px; /* Kích thước chữ cho nhãn */
                margin-bottom: 5px; /* Khoảng cách dưới của nhãn */
                display: block; /* Chuyển nhãn thành phần khối */
                color: #333; /* Màu chữ cho nhãn */
            }

            .discount-code-input {
                width: 100%; /* Độ rộng đầy đủ */
                padding: 10px; /* Padding bên trong */
                font-size: 14px; /* Kích thước chữ */
                border: 1px solid #ccc; /* Đường viền */
                border-radius: 4px; /* Góc bo tròn */
                background-color: #fff; /* Màu nền */
                transition: border-color 0.3s; /* Hiệu ứng chuyển tiếp cho màu viền */
            }

            .discount-code-input:focus {
                border-color: #28a745; /* Đổi màu viền khi focus */
                outline: none; /* Bỏ đường viền ngoài */
            }


        </style>
    </head>

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
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px"
                                                alt="User Image">      <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getFirstName()} ${sessionScope.User.getLastName()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>

            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item haha" href="homepage"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                <li><a class="app-menu__item " href="homepage"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item active" href="order"><i class='app-menu__icon bx bx-task'></i>Order</a></li>

                <li><a class="app-menu__item " href="userManage"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Quản lý nhân viên</span></a></li>


                <li><a class="app-menu__item" href="product"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>

                <li><a class="app-menu__item " href="customer"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Quản lý khách hàng </span></a></li>











                <li><a class="app-menu__item" href="inventory"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý   kho</span></a></li>

                <li><a class="app-menu__item" href="settingController"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Thay đổi mật khẩu </span></a></li>




            </ul>


        </aside>

        <main class="app-content">
            <div class="app-title">

                <a href="order" class="btn btn-primary" style="float: left; margin-right: 10px;">
                    <i class="fa fa-arrow-left"></i> Quay Lại Danh Sách Order
                </a>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Hóa Đơn Mua Hàng</h3>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Hóa Đơn</th>
                                    <th>Ngày</th>
                                    <th>Trạng Thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orderList}" var="order">
                                    <tr>
                                        <td>
                                            <a href="orderhistory?orderid=${order.orderID}" style="color: blue; text-decoration: underline">Mã Hóa Đơn: ${order.orderID}</a>
                                        </td>
                                        <td>${order.orderDate}</td>
                                        <td>
                                            <c:if test="${order.status == 'Pending'}">
                                                <button class="btn btn-warning" data-toggle="modal" data-target="#statusModal${order.orderID}"
                                                        data-id="${order.orderID}" data-status="${order.status}">
                                                    Pending
                                                </button>
                                                <!-- Modal Structure -->
                                                <div id="statusModal${order.orderID}" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="statusModalLabel${order.orderID}" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="statusModalLabel${order.orderID}">Chỉnh Sửa Trạng Thái</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="statusForm" action="vieworderhistory" method="post">
                                                                    <input type="hidden" name="orderId" value="${order.orderID}" />
                                                                    <input type="hidden" name="cp" value="${sessionScope.page.getCurrentPage()}" />
                                                                    <div class="form-group">
                                                                        <label for="status">Trạng Thái Giao Hàng</label>
                                                                        <select id="status" name="status" class="form-control">
                                                                            <option value="Pending">Pending</option>
                                                                            <option value="Completed">Completed</option>
                                                                            <option value="Cancelled">Cancelled</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                                                        <button type="submit" class="btn btn-primary" id="saveStatus">Lưu Trạng Thái</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${order.status == 'Completed'}">
                                                <button class="btn btn-success">
                                                    Completed
                                                </button>
                                            </c:if>
                                            <c:if test="${order.status == 'Cancelled'}">
                                                <button class="btn btn-danger">
                                                    Cancelled
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                        <%@include file="pagination_1.jsp" %>
                    </div>
                </div>
            </div>
        </main>

        <!-- Essential javascripts for application to work -->
        <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
    </body>
</html>