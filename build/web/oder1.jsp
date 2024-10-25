<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>POS Bán Hàng</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/doc/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <style>
            .product-list, .selected-products {
                height: 400px;
                overflow-y: auto;
            }
            /* Thêm CSS mới để điều chỉnh sidebar */
            .app-sidebar {
                width: 250px;
                position: fixed;
                left: 0;
                top: 0;
                bottom: 0;
                z-index: 1000;
                overflow-y: auto;
            }
            .app-content {
                margin-left: 250px;
            }
            @media (max-width: 768px) {
                .app-sidebar {
                    left: -250px;
                }
                .app-content {
                    margin-left: 0;
                }
                .app-sidebar.show {
                    left: 0;
                }
            }
        </style>
    </head>
    <body onload="time()" class="app sidebar-mini rtl">
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <jsp:include page="/menu.jsp" />
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="logout"><i class='bx bx-log-out bx-rotate-180'></i></a></li>
            </ul>
        </header>
        <main class="app-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><b>POS bán hàng</b></a></li>
                        </ul>
                        <div class="app-title" style="margin-bottom: 0px">
                            <a href="vieworderhistory">View Order History</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="tile">
                                <h3 class="tile-title">Danh sách sản phẩm</h3>




                                <div class="product-list">
                                    <table class="table table-hover table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="so--luong">Mã hàng</th>
                                                <th class="so--luong">Tên sản phẩm</th>
                                                <th class="so--luong">Ảnh</th>
                                                <th class="so--luong">Giá bán</th>
                                                <th class="so--luong text-center"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${listProduct}">
                                                <tr>
                                                    <td>${product.productCode}</td>
                                                    <td>${product.productName}</td>
                                                    <td><img src="${pageContext.request.contextPath}/img-sanpham/${product.image}" alt="${product.productName}" width="50px;"></td>
                                                    <td>${product.price} VNĐ</td>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <form action="order" method="post">
                                                            <input type="hidden" name="id" value="${product.productID}"/> 
                                                            <button class="btn btn-primary btn-sm add-to-cart" type="submit" title="Order" name="addtocart">
                                                                <i class="fas fa-plus"></i>
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="tile">
                                <h3 class="tile-title">Sản phẩm đã chọn</h3>
                                <div class="selected-products">
                                    <table class="table table-hover table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="so--luong">Tên sản phẩm</th>
                                                <th class="so--luong">Số lượng</th>
                                                <th class="so--luong">Giá bán</th>
                                                <th class="so--luong text-center"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="o" value="${sessionScope.cart}"></c:set>
                                            <c:if test="${not empty o.items}"> 
                                                <c:forEach items="${o.items}" var="i">
                                                    <tr>
                                                        <td>${i.product.productName}</td>
                                                        <td style="text-align: center">
                                                            <a href="process?num=-1&productID=${i.product.productID}">-</a>
                                                            <input type="number" readonly value="${i.getQuantity()}" max="${i.product.quantity}" class="quantity-input" style="width: 30%;padding-left: 5%;
                                                                   text-align: center;"/>
                                                            <a href="process?num=1&productID=${i.product.productID}">+</a>
                                                        </td>
                                                        <td>${i.product.price}</td>
                                                        <c:if test="${not empty o.items}">
                                                            <td>
                                                                <form action="process" method="post">
                                                                    <input type="hidden" name="id" value="${i.product.productID}">
                                                                    <button type="submit" style="background: none; border: none">
                                                                        <i class='bx bx-trash'></i>
                                                                    </button>
                                                                </form>
                                                            </td>
                                                        </c:if>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="tile">
                        <h3 class="tile-title">Thông tin thanh toán</h3>
                        <div class="row">
                            <div class="form-group col-md-12">
                                <label class="control-label">Nhân viên bán hàng: </label>
                                <p>${sessionScope.User.firstName} ${sessionScope.User.lastName}</p>
                            </div>
                            <form action="checkout" method="post" id="checkoutForm">
                                <div class="form-group col-md-12">
                                    <label class="control-label">Khách hàng: </label>
                                    <div class="input-group">
                                        <input class="form-control" list="datalistOptions" name="customerName" id="customerName" placeholder="Type to search...">
                                        <datalist id="datalistOptions">
                                            <c:forEach var="customer" items="${listCustomer}">
                                                <option value="${customer.firstName} ${customer.lastName}" data-customer-id="${customer.customerID}"></option>
                                            </c:forEach>
                                        </datalist>
                                        <input type="hidden" name="customerId" id="customerId" value="" />

                                        <!-- New Customer Icon -->
                                        <a href="customer?action=create" style="margin-left: 5%" class="btn btn-outline-secondary" title="Tạo mới khách hàng">
                                            <i class="fas fa-plus"></i>
                                        </a>
                                    </div>
                                </div>

                                <div class="form-group col-md-12">
                                    <label class="control-label">Thời gian: <span id="currentTime"></span></label>
                                </div>
                                <div class="form-group col-md-12">
                                    <label class="control-label">Hình thức thanh toán</label>
                                    <select class="form-control" name="paymentMethod" id="exampleSelect2" required>
                                        <option value="">-- Chọn Phương Thức --</option>
                                        <c:forEach var="method" items="${paymentMethods}">
                                            <option value="${method.paymentMethodID}">${method.methodName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group col-md-12">
                                    <label class="control-label">Tổng tiền hàng:</label>
                                    <p class="control-all-money-tamtinh" id="totalAmountDisplay">= <fmt:formatNumber pattern="#,##0.00" value="${total}"/> VNĐ</p>
                                </div>
                                <div class="form-group col-md-12">
                                    <label class="control-label">Giảm giá:</label>
                                    <input class="form-control" type="number" value="0" id="discount">
                                </div>
                                <div class="form-group col-md-12">
                                    <label class="control-label">Tổng cộng thanh toán:</label>
                                    <p class="control-all-money-total" id="totalAmountTotal">= ${total} VNĐ</p>
                                    <input type="hidden" name="total" value="${total}" id="totalAmountInput"/>
                                </div>
                                <button class="btn btn-primary luu-san-pham" type="submit" style="width: 129%">Yêu cầu thanh toán</button>
                                <button class="btn btn-primary luu-va-in" type="button" style="width: 129%">Lưu và in hóa đơn</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="${pageContext.request.contextPath}/doc/js/jquery-3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/doc/js/main.js"></script>
        <script>
        const customerInput = document.getElementById('customerName');
        const customerIdInput = document.getElementById('customerId');

        customerInput.addEventListener('input', function () {
            const options = document.querySelectorAll('#datalistOptions option');
            let selectedCustomerId = null;

            options.forEach(option => {
                if (option.value === customerInput.value) {
                    selectedCustomerId = option.getAttribute('data-customer-id');
                }
            });

            customerIdInput.value = selectedCustomerId || ''; // Set to null if no customer is selected
        });

        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("checkoutForm").onsubmit = function (event) {
                var totalAmount = parseFloat(document.getElementById("totalAmountInput").value); // Get the total amount from the hidden input

                // Check if total is 0
                if (totalAmount <= 0) {
                    event.preventDefault(); // Prevent the form from submitting
                    alert("Vui lòng chọn sản phẩm để thanh toán!"); // Display an alert message
                }
            };
        });

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
            var d = today.getDate();
            var m = today.getMonth();
            var y = today.getFullYear();
            document.getElementById('currentTime').innerHTML = today.getHours() + ":" + today.getMinutes() + " " + weekday[today.getDay()] + ", " + d + "/" + (m + 1) + "/" + y;
        }

        $(document).ready(function () {
            let totalAmount = 0;

            $('.add-to-cart').click(function () {
                const row = $(this).closest('tr');
                const productName = row.find('td:eq(1)').text();
                const productPrice = parseInt(row.find('td:eq(3)').text().replace(/[^0-9]/g, ''));

                // Add product to selected products list
                const selectedProductRow = `
                        <tr>
                            <td>${productName}</td>
<td><input type="number" class="form-control product-quantity" value="1" min="1"></td>
<td>${productPrice.toLocaleString()} VNĐ</td>
<td style="text-align: center; vertical-align: middle;">
    <button class="btn btn-danger btn-sm remove-product" type="button" title="Xóa sản phẩm">
        <i class="fas fa-trash"></i>
    </button>
</td>
</tr>
`;
                $('#selectedProductsList').append(selectedProductRow);

// Update total amount
                totalAmount += productPrice;
                $('.control-all-money-tamtinh').text(`= ${totalAmount.toLocaleString()} VNĐ`);
                $('.control-all-money-total').text(`= ${totalAmount.toLocaleString()} VNĐ`);

// Remove product
                $('.remove-product').off('click').on('click', function () {
                    const quantity = $(this).closest('tr').find('.product-quantity').val();
                    totalAmount -= productPrice * quantity;
                    $(this).closest('tr').remove();
                    $('.control-all-money-tamtinh').text(`= ${totalAmount.toLocaleString()} VNĐ`);
                    $('.control-all-money-total').text(`= ${totalAmount.toLocaleString()} VNĐ`);
                });
            });
        });
        </script>
    </body>
</html>
