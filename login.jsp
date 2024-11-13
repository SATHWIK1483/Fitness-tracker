<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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
    .form-group {
        margin-bottom: 20px;
    }
    label {
        display: block;
        font-weight: bold;
    }
    input[type="text"],
    input[type="password"] {
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

<div class="container">
    <h2>Login</h2>
    <%
        // Check if the user has submitted the login form
        if (request.getMethod().equals("POST")) {
            // Retrieve username and password from the form
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Perform authentication by querying the database
            boolean authenticationSuccessful = false;
            try (java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/fitness", "root", "tiger")) {
                String query = "SELECT * FROM user WHERE username = ? AND password = ?";
                try (java.sql.PreparedStatement statement = conn.prepareStatement(query)) {
                    statement.setString(1, username);
                    statement.setString(2, password);
                    try (java.sql.ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            // Authentication successful
                            authenticationSuccessful = true;
                        }
                    }
                }
            } catch (java.sql.SQLException e) {
                // Handle database errors
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            }

            if (authenticationSuccessful) {
                // Set username in the session
                session.setAttribute("username", username);
                
                // Redirect to the success page
                response.sendRedirect("success.jsp");
            } else {
                // Authentication failed, redirect back to login page with error parameter
                response.sendRedirect("login.jsp?error=1");
            }
        }
    %>
    <form action="" method="post">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Login">
        </div>
    </form>
</div>

</body>
</html>
