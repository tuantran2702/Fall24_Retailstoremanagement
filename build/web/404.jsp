<%-- 
    Document   : 404
    Created on : Oct 25, 2024, 2:15:46 PM
    Author     : ptrung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied</title>
    <style>
        /* Reset mặc định */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        /* Body styles */
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            color: #333;
        }
        /* Container styles */
        .access-denied-container {
            text-align: center;
            padding: 40px;
            max-width: 600px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }
        /* Title and message */
        h1 {
            font-size: 24px;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 30px;
        }
        /* Back button */
        .back-button {
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #3498db;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .back-button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="access-denied-container">
        <h1>Access Denied</h1>
        <p>You do not have permission to access this page.</p>
        <a href="homepage" class="back-button">Go to Home Page</a>
    </div>
</body>
</html>
