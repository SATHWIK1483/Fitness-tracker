<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fitness Tracker</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .container {
        width: 50%;
        margin: 0 auto;
        text-align: center;
        margin-top: 50px;
    }
    .btn {
        background-color: #4CAF50;
        color: white;
        padding: 15px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        margin: 10px;
    }
    .btn:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Welcome to Fitness Tracker</h2>
    <form action="login.jsp">
        <button class="btn">Login</button>
    </form>
    <form action="register.jsp">
        <button class="btn">Register</button>
    </form>
</div>

</body>
</html>
