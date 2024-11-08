<%-- 
    Document   : 404
    Created on : Nov 8, 2024, 10:55:10 AM
    Author     : ptrung
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Access Denied</title>
    <style>
        /* Reset some default browser styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        .container {
            text-align: center;
            background-color: #fff;
            padding: 60px;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-10px);
        }

        h1 {
            font-size: 100px;
            margin-bottom: 20px;
            font-weight: bold;
            color: #ff4757;
            text-shadow: 2px 2px 5px rgba(255, 71, 87, 0.2);
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
            color: #555;
        }

        .btn-home {
            padding: 15px 40px;
            background-color: #1e90ff;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            text-decoration: none;
            box-shadow: 0 5px 15px rgba(30, 144, 255, 0.3);
        }

        .btn-home:hover {
            background-color: #0073e6;
            transform: scale(1.05);
        }

        /* Responsive design */
        @media (max-width: 768px) {
            h1 {
                font-size: 72px;
            }

            p {
                font-size: 16px;
            }

            .btn-home {
                font-size: 14px;
                padding: 12px 30px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>404</h1>
        <p>Rất tiếc, bạn không có quyền truy cập vào trang này. Vui lòng quay lại trang chủ.</p>
        <a href="homepage" class="btn-home">Quay lại trang chủ</a>
    </div>
</body>
</html>
