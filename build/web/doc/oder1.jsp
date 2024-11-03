<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        </style>
    </head>

    <body onload="time()" class="app sidebar-mini rtl">
        <main class="app app-ban-hang">
            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><b>POS bán hàng</b></a></li>
                        </ul>
                        <div id="clock"></div>
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
                                            <tr>
                                                <td>P001</td>
                                                <td>Sản phẩm A</td>
                                                <td><img src="${pageContext.request.contextPath}/img-sanpham/banan.jpg" alt="Sản phẩm A" width="50px;"></td>
                                                <td>100.000 VNĐ</td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <button class="btn btn-primary btn-sm add-to-cart" type="button" title="Thêm vào giỏ hàng">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>P002</td>
                                                <td>Sản phẩm B</td>
                                                <td><img src="${pageContext.request.contextPath}/img-sanpham/cera.jpg" alt="Sản phẩm B" width="50px;"></td>
                                                <td>200.000 VNĐ</td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <button class="btn btn-primary btn-sm add-to-cart" type="button" title="Thêm vào giỏ hàng">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>P003</td>
                                                <td>Sản phẩm C</td>
                                                <td><img src="${pageContext.request.contextPath}/img-sanpham/dolas.jpg" alt="Sản phẩm C" width="50px;"></td>
                                                <td>300.000 VNĐ</td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <button class="btn btn-primary btn-sm add-to-cart" type="button" title="Thêm vào giỏ hàng">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>P004</td>
                                                <td>Sản phẩm D</td>
                                                <td><img src="${pageContext.request.contextPath}/img-sanpham/sanphamD.jpg" alt="Sản phẩm D" width="50px;"></td>
                                                <td>150.000 VNĐ</td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <button class="btn btn-primary btn-sm add-to-cart" type="button" title="Thêm vào giỏ hàng">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>P005</td>
                                                <td>Sản phẩm E</td>
                                                <td><img src="${pageContext.request.contextPath}/img-sanpham/sanphamE.jpg" alt="Sản phẩm E" width="50px;"></td>
                                                <td>400.000 VNĐ</td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <button class="btn btn-primary btn-sm add-to-cart" type="button" title="Thêm vào giỏ hàng">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>P006</td>
                                                <td>Sản phẩm F</td>
                                                <td><img src="${pageContext.request.contextPath}/img-sanpham/sanphamF.jpg" alt="Sản phẩm F" width="50px;"></td>
                                                <td>250.000 VNĐ</td>
                                                <td style="text-align: center; vertical-align: middle;">
                                                    <button class="btn btn-primary btn-sm add-to-cart" type="button" title="Thêm vào giỏ hàng">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </td>
                                            </tr>
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
                                        <tbody id="selectedProductsList">
                                            <!-- Danh sách sản phẩm đã chọn sẽ được thêm vào đây -->
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
                                <label class="control-label">ID Hóa đơn: </label>
                                <p>HD123456</p>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Nhân viên bán hàng: </label>
                                <p>Nguyễn Văn A</p>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Khách hàng: </label>
                                <p>Trần Thị B</p>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Thời gian: <span id="currentTime"></span></label>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Hình thức thanh toán</label>
                                <select class="form-control" id="exampleSelect2" required>
                                    <option>Thanh toán chuyển khoản</option>
                                    <option>Trả tiền mặt tại quầy</option>
                                </select>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Tổng tiền hàng:</label>
                                <p class="control-all-money-tamtinh">= 600.000 VNĐ</p>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Giảm giá:</label>
                                <input class="form-control" type="number" value="0">
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Tổng cộng thanh toán:</label>
                                <p class="control-all-money-total">= 600.000 VNĐ</p>
                            </div>
                            <div class="tile-footer col-md-12">
                                <button class="btn btn-primary luu-san-pham" type="button"> Yêu cầu thanh toán </button>
                                <button class="btn btn-primary luu-va-in" type="button">Lưu và in hóa đơn</button>
                            </div>
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
