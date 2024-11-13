<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Activity Tracking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        form {
            margin-top: 50px;
        }
        input[type="text"] {
            padding: 10px;
            margin: 5px;
            width: 200px;
        }
        input[type="submit"] {
            padding: 10px 20px;
            margin-top: 10px;
            background-color: #4CAF50;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<h2>Activity Tracking</h2>

<%
    // Retrieve username from session
    String username = (String) session.getAttribute("username");

    if (request.getMethod().equals("POST")) {
        // Retrieve user input from the form
        String steps = request.getParameter("steps");
        String distance = request.getParameter("distance");

        // JDBC Connection parameters
        String url = "jdbc:mysql://localhost:3306/fitness";
        String dbUsername = "root";
        String dbPassword = "tiger";

        // JDBC Connection and PreparedStatement
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection(url, dbUsername, dbPassword)) {
            // Check if the username already has activity data
            String checkSql = "SELECT * FROM activity_data WHERE username = ?";
            try (PreparedStatement checkStatement = conn.prepareStatement(checkSql)) {
                checkStatement.setString(1, username);
                ResultSet resultSet = checkStatement.executeQuery();
                if (resultSet.next()) {
                    // If activity data exists for the username, update the existing record
                    String updateSql = "UPDATE activity_data SET steps = ?, distance = ? WHERE username = ?";
                    try (PreparedStatement updateStatement = conn.prepareStatement(updateSql)) {
                        updateStatement.setString(1, steps);
                        updateStatement.setString(2, distance);
                        updateStatement.setString(3, username);
                        updateStatement.executeUpdate();
                    }
                } else {
                    // If no activity data exists, insert a new record
                    String insertSql = "INSERT INTO activity_data (username, steps, distance) VALUES (?, ?, ?)";
                    try (PreparedStatement insertStatement = conn.prepareStatement(insertSql)) {
                        insertStatement.setString(1, username);
                        insertStatement.setString(2, steps);
                        insertStatement.setString(3, distance);
                        insertStatement.executeUpdate();
                    }
                }
            }

            // Confirmation message
            out.println("<html><body>");
            out.println("<h2>Activity Data Saved Successfully</h2>");
            out.println("<p>Username: " + username + "</p>");
            out.println("<p>Steps: " + steps + "</p>");
            out.println("<p>Distance: " + distance + " km</p>");
            out.println("<a href=\"success.jsp\">Back to Home</a>");
            out.println("</body></html>");
        } catch (java.sql.SQLException e) {
            // Handle SQL exceptions
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
%>

<form action="" method="post">
    <label for="steps">Number of Steps Taken:</label><br>
    <input type="text" id="steps" name="steps"><br>
    <label for="distance">Distance Covered (in km):</label><br>
    <input type="text" id="distance" name="distance"><br>
    <input type="submit" value="Submit">
</form>

</body>
</html>
