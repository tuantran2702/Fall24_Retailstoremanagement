<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>POS Bán Hàng</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Main CSS-->
  <link rel="stylesheet" type="text/css" href="css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
  <!-- Font-icon css-->
  <link rel="stylesheet" type="text/css"
    href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
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
        <div class="tile">
          <h3 class="tile-title">Danh sách sản phẩm</h3>
          <div class="du--lieu-san-pham">
            <table class="table table-hover table-bordered">
              <thead>
                <tr>
                  <th class="so--luong">Mã hàng</th>
                  <th class="so--luong">Tên sản phẩm</th>
                  <th class="so--luong">Ảnh</th>
                  <th class="so--luong" width="10">Số lượng</th>
                  <th class="so--luong">Giá bán</th>
                  <th class="so--luong text-center" style="text-align: center; vertical-align: middle;"></th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${products}" var="product">
                  <tr>
                    <td>${product.code}</td>
                    <td>${product.name}</td>
                    <td><img src="${product.imageUrl}" alt="" width="50px;"></td>
                    <td><input class="so--luong1" type="number" value="1"></td>
                    <td>${product.price}</td>
                    <td style="text-align: center; vertical-align: middle;">
                      <button class="btn btn-primary btn-sm trash" type="button" title="Xóa"><i class="fas fa-trash-alt"></i></button>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="tile">
          <h3 class="tile-title">Thông tin thanh toán</h3>
          <div class="row">
            <div class="form-group col-md-12">
              <label class="control-label">ID Hóa đơn: </label>
            </div>
            <div class="form-group col-md-12">
              <label class="control-label">Nhân viên bán hàng: </label>
            </div>
            <div class="form-group col-md-12">
              <label class="control-label">Khách hàng : </label>
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
              <p class="control-all-money-tamtinh">= ${totalAmount} VNĐ</p>
            </div>
            <div class="form-group col-md-12">
              <label class="control-label">Giảm giá:</label>
              <input class="form-control" type="number" value="0">
            </div>
            <div class="form-group col-md-12">
              <label class="control-label">Tổng cộng thanh toán:</label>
              <p class="control-all-money-total">= ${finalAmount} VNĐ</p>
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

  <!-- Essential javascripts for application to work-->
  <script src="js/jquery-3.2.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
  <!-- The javascript plugin to display page loading on top-->
  <script src="js/plugins/pace.min.js"></script>
  <!-- Page specific javascripts-->
  <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
  <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
  <script type="text/javascript">$('#sampleTable').DataTable();</script>
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
      tmp = '<span class="date"> <i class="bx bxs-calendar" ></i> ' + today + ' | <i class="fa fa-clock-o" aria-hidden="true"></i>  : ' + nowTime +
        '</span>';
      document.getElementById("clock").innerHTML = tmp;
      document.getElementById("currentTime").innerHTML = nowTime;
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