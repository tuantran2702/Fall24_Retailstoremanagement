<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.ReportInventory" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Report Dashboard</title>
    <link rel="stylesheet" href="path/to/bootstrap.min.css">
    <script src="path/to/chart.js"></script>
</head>
<body>
    <div class="container">
        <h1 class="my-4">Inventory Report Dashboard</h1>

        <!-- Overview Cards -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card text-white bg-primary">
                    <div class="card-body">
                        <h5 class="card-title">Total Inventory Value</h5>
                        <p class="card-text">${totalInventoryValue}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success">
                    <div class="card-body">
                        <h5 class="card-title">Total Product Quantity</h5>
                        <p class="card-text">${totalProductQuantity}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-info">
                    <div class="card-body">
                        <h5 class="card-title">Unique Products</h5>
                        <p class="card-text">${uniqueProductCount}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search Form -->
        <form method="get" class="mb-4">
            <div class="input-group">
                <input type="text" name="search" class="form-control" placeholder="Search by product name or warehouse..." />
                <button class="btn btn-outline-secondary" type="submit">Search</button>
            </div>
        </form>

        <!-- Charts -->
        <div class="row mb-4">
            <div class="col-md-6">
                <canvas id="inventoryValueChart"></canvas>
            </div>
            <div class="col-md-6">
                <canvas id="inventoryQuantityChart"></canvas>
            </div>
        </div>

        <!-- Detailed Table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Warehouse</th>
                    <th>Quantity</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<ReportInventory> inventoryItems = (List<ReportInventory>) request.getAttribute("inventoryItems");
                    for (ReportInventory item : inventoryItems) {
                %>
                <tr>
                    <td><%= item.getProductName() %></td>
                    <td><%= item.getWarehouseName() %></td>
                    <td><%= item.getTotalQuantity() %></td>
                    <td>${item.getTotalStockValue()}</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <!-- Generate Report Button -->
        <form method="post" class="mb-4">
            <input type="hidden" name="action" value="generateReport" />
            <button type="submit" class="btn btn-primary">Generate Report</button>
        </form>
    </div>

    <script>
        // Prepare data for charts
        var chartLabels = ${chartLabels};
        var chartValues = ${chartValues};
        var chartQuantities = ${chartQuantities};

        // Chart for Inventory Value
        var ctxValue = document.getElementById('inventoryValueChart').getContext('2d');
        var inventoryValueChart = new Chart(ctxValue, {
            type: 'bar',
            data: {
                labels: chartLabels,
                datasets: [{
                    label: 'Inventory Value',
                    data: chartValues,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Chart for Inventory Quantity
        var ctxQuantity = document.getElementById('inventoryQuantityChart').getContext('2d');
        var inventoryQuantityChart = new Chart(ctxQuantity, {
            type: 'bar',
            data: {
                labels: chartLabels,
                datasets: [{
                    label: 'Inventory Quantity',
                    data: chartQuantities,
                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                    borderColor: 'rgba(153, 102, 255, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
