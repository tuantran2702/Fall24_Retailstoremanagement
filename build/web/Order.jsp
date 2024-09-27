<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Warehouse List | Order Sản Phẩm</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            /* Input field styling */
            input[type="text"] {
                padding: 5px;
                border: 1px solid #007bff;
                border-radius: 5px 5px 5px 5px;
                outline: none;
                width: 250px;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus {
                border-color: #0056b3;
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
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.User.getEmail()}</b></p>
                    <p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
                </div>
            </div>

            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item haha" href="homepage"><i class='app-menu__icon bx bx-cart-alt'></i>
                        <span class="app-menu__label">POS Bán Hàng</span></a></li>
                <li><a class="app-menu__item" href="homepage"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item " href="employee"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Quản lý nhân viên</span></a></li>
                <li><a class="app-menu__item" href="product"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>
                <li><a class="app-menu__item active" href="order"><i class='app-menu__icon bx bx-task'></i>Order</a></li>
                <li><a class="app-menu__item" href="category"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý danh mục</span></a>
                </li>        

                <li><a class="app-menu__item" href="warehouse"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý kho</span></a></li>

                <li><a class="app-menu__item" href="inventory"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý  tồn kho</span></a></li>


                <li><a class="app-menu__item" href="import"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý nhập hàng </span></a>
                </li> 

                <li><a class="app-menu__item" href="warehouseList.jsp"><i class='app-menu__icon bx bx-run'></i><span
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
                    <li class="breadcrumb-item">Danh sách mặt hàng
                    </li>
                </ul>

                <form action="order" method="get">
                    <input type="text" name="key" placeholder="Mã hoặc Tên sản phẩm..." />
                    <button type="submit" class="btn btn-primary" onclick="return validateSearch()">Tìm kiếm</button>
                </form>

                <a href="cart" class="btn btn-primary" style="float: right; margin-right: 10px;">
                    <i class="fa fa-shopping-cart"></i> ${sessionScope.size}
                </a>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title"><a href="order"><i class="fa fa-home"></i> Danh sách mặt hàng</a></h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Mã Sản Phẩm</th>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Mô Tả</th>
                                    <th>Giá Tiền</th>
                                    <th>Số Lượng Tồn Kho</th>
                                    <th>Order</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Loop through the listProduct -->
                                <c:forEach var="product" items="${listProduct}">
                                    <tr>
                                         <td>${product.productCode}</td>
                                        <td>${product.productName}</td> <!-- Make sure productName is available -->
                                        <td>${product.description}</td>
                                        <td>${product.price}</td>
                                        <td>${product.quantity}</td>
                                        <td>
                                            <form action="cart" method="post"> <!-- Update the action URL -->
                                                <input type="hidden" name="id" value="${product.productID}"/> 
                                                <button type="submit" title="Order" name="addtocart">
                                                    <i class="bx bx-plus"></i> 
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


        </main>

        <!-- Essential javascripts for application to work -->
        <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
        <script>
                        function validateSearch() {
                            var keyInput = document.getElementsByName('key')[0];
                            var key = keyInput.value.trim();
                            if (key === '') {
                                alert('Vui lòng nhập Mã hoặc Tên sản phẩm!');
                                event.preventDefault();
                            }
                        }
        </script>
    </body>
</html>
