<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Personalized Profile</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    .container {
        width: 50%;
        margin: 0 auto;
    }
    .form-group {
        margin-bottom: 20px;
    }
    label {
        display: block;
        font-weight: bold;
    }
    input[type="text"],
    input[type="number"],
    input[type="password"],
    select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }
    input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        padding: 15px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }
    input[type="submit"]:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>

<%
    if(request.getMethod().equals("POST")) {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        double weight = Double.parseDouble(request.getParameter("weight"));
        double height = Double.parseDouble(request.getParameter("height"));
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitness", "root", "tiger");
            PreparedStatement ps = connection.prepareStatement("INSERT INTO user (user_id, username, age, gender, weight, height, password) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, userId);
            ps.setString(2, username);
            ps.setInt(3, age);
            ps.setString(4, gender);
            ps.setDouble(5, weight);
            ps.setDouble(6, height);
            ps.setString(7, password);
            ps.executeUpdate();
            connection.close();
%>
<div class="container">
    <h2>Registration Successful</h2>
    <p>Your account has been successfully registered.</p>
    <form action="Index.jsp">
        <input type="submit" value="Back to Login">
    </form>
</div>
<%
        } catch (Exception e) {
            out.println(e);
        }
    }
    else {
%>
<div class="container">
    <h2>Personalized Profile</h2>
    <form action="" method="post">
        <div class="form-group">
            <label for="userId">User ID:</label>
            <input type="text" id="userId" name="userId" required>
        </div>
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" required min="1" max="120">
        </div>
        <div class="form-group">
            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required>
                <option value="">Select Gender</option>
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>
        </div>
        <div class="form-group">
            <label for="weight">Weight (in kg):</label>
            <input type="number" id="weight" name="weight" required min="1" max="500">
        </div>
        <div class="form-group">
            <label for="height">Height (in cm):</label>
            <input type="number" id="height" name="height" required min="1" max="300">
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Submit">
        </div>
    </form>
</div>
<%
    }
%>

</body>
</html>
