<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <title>Inventory Report Dashboard</title>
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
  <!-- Navbar-->
  <header class="app-header">
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
      aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
      <!-- User Menu-->
      <li><a class="app-nav__item" href="/index.jsp"><i class='bx bx-log-out bx-rotate-180'></i> </a>
      </li>
    </ul>
  </header>
  <!-- Sidebar menu-->
  <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
  <aside class="app-sidebar">
    <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="/images/hay.jpg" width="50px"
        alt="User Image">
      <div>
        <p class="app-sidebar__user-name"><b>${sessionScope.user.name}</b></p>
        <p class="app-sidebar__user-designation">Welcome back</p>
      </div>
    </div>
    <hr>
    <ul class="app-menu">
      <li><a class="app-menu__item" href="index.jsp"><i class='app-menu__icon bx bx-tachometer'></i><span
            class="app-menu__label">Inventory Dashboard</span></a></li>
    </ul>
  </aside>
  <main class="app-content">
    <div class="row">
      <div class="col-md-12">
        <div class="app-title">
          <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="#"><b>Inventory Report Dashboard</b></a></li>
          </ul>
          <div id="clock"></div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6 col-lg-4">
        <div class="widget-small primary coloured-icon">
          <i class='icon bx bxs-dollar-circle fa-3x'></i>
          <div class="info">
            <h4>Total Inventory Value</h4>
            <p><b>$<fmt:formatNumber value="${totalInventoryValue}" pattern="#,##0.00"/></b></p>
          </div>
        </div>
      </div>
      <div class="col-md-6 col-lg-4">
        <div class="widget-small info coloured-icon">
          <i class='icon bx bxs-purchase-tag-alt fa-3x'></i>
          <div class="info">
            <h4>Total Product Quantity</h4>
            <p><b><fmt:formatNumber value="${totalProductQuantity}" pattern="#,##0"/> items</b></p>
          </div>
        </div>
      </div>
      <div class="col-md-6 col-lg-4">
        <div class="widget-small warning coloured-icon">
          <i class='icon fa-3x bx bxs-tag'></i>
          <div class="info">
            <h4>Unique Products</h4>
            <p><b>${uniqueProductCount} products</b></p>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="tile">
          <div>
            <h3 class="tile-title">Search</h3>
          </div>
          <div class="tile-body">
            <form action="inventory" method="get">
              <div class="row element-button">
                <div class="col-sm-12">
                  <input class="form-control" type="text" name="search" placeholder="Search by product name or warehouse">
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <div class="tile">
          <h3 class="tile-title">Inventory Value by Product</h3>
          <div class="embed-responsive embed-responsive-16by9">
            <canvas class="embed-responsive-item" id="valueChartDemo"></canvas>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="tile">
          <h3 class="tile-title">Inventory Quantity by Product</h3>
          <div class="embed-responsive embed-responsive-16by9">
            <canvas class="embed-responsive-item" id="quantityChartDemo"></canvas>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="tile">
          <div>
            <h3 class="tile-title">Inventory Details</h3>
          </div>
          <div class="tile-body">
            <table class="table table-hover table-bordered" id="sampleTable">
              <thead>
                <tr>
                  <th>Product Name</th>
                  <th>Warehouse</th>
                  <th>Quantity</th>
                  <th>Value</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="item" items="${inventoryItems}">
                  <tr>
                    <td>${item.productName}</td>
                    <td>${item.warehouse}</td>
                    <td>${item.quantity}</td>
                    <td>$<fmt:formatNumber value="${item.value}" pattern="#,##0.00"/></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <form action="generateReport" method="post">
          <button type="submit" class="btn btn-primary btn-lg btn-block">Generate Report</button>
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
  <!-- Page specific javascripts-->
  <script type="text/javascript" src="js/plugins/chart.js"></script>
  <script type="text/javascript">
    var valueData = {
      labels: [<c:forEach var="item" items="${inventoryItems}" varStatus="status">
                "${item.productName}"${!status.last ? ',' : ''}
               </c:forEach>],
      datasets: [{
        label: "Inventory Value",
        backgroundColor: "rgba(255, 99, 132, 0.2)",
        borderColor: "rgb(255, 99, 132)",
        borderWidth: 1,
        data: [<c:forEach var="item" items="${inventoryItems}" varStatus="status">
                ${item.value}${!status.last ? ',' : ''}
               </c:forEach>]
      }]
    };

    var quantityData = {
      labels: [<c:forEach var="item" items="${inventoryItems}" varStatus="status">
                "${item.productName}"${!status.last ? ',' : ''}
               </c:forEach>],
      datasets: [{
        label: "Inventory Quantity",
        backgroundColor: "rgba(54, 162, 235, 0.2)",
        borderColor: "rgb(54, 162, 235)",
        borderWidth: 1,
        data: [<c:forEach var="item" items="${inventoryItems}" varStatus="status">
                ${item.quantity}${!status.last ? ',' : ''}
               </c:forEach>]
      }]
    };

    var ctxv = $("#valueChartDemo").get(0).getContext("2d");
    var valueChart = new Chart(ctxv).Bar(valueData);

    var ctxq = $("#quantityChartDemo").get(0).getContext("2d");
    var quantityChart = new Chart(ctxq).Bar(quantityData);
  </script>
</body>

</html>