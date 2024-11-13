<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calories Burned Calculation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        form {
            margin-top: 50px;
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
        .calories-result {
            margin-top: 20px;
            font-size: 18px;
        }
    </style>
</head>
<body>

<h2>Calories Burned Calculation</h2>

<%
    // Retrieve username from session
    String username = (String) session.getAttribute("username");

    // Check if username is not null
    if (username != null) {
        // Initialize variables
        double weight = 0;
        int steps = 0;
        double distance = 0;
        double caloriesBurned = 0;

        try {
            // Retrieve weight based on username from the 'user' table
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitness", "root", "tiger");
            PreparedStatement weightStatement = conn.prepareStatement("SELECT weight FROM user WHERE username = ?");
            weightStatement.setString(1, username);
            ResultSet weightResult = weightStatement.executeQuery();
            if (weightResult.next()) {
                weight = weightResult.getDouble("weight");
            }

            // Retrieve steps and distance from the 'activity_data' table
            PreparedStatement activityDataStatement = conn.prepareStatement("SELECT steps, distance FROM activity_data WHERE username = ?");
            activityDataStatement.setString(1, username);
            ResultSet activityDataResult = activityDataStatement.executeQuery();
            if (activityDataResult.next()) {
                steps = activityDataResult.getInt("steps");
                distance = activityDataResult.getDouble("distance");
            }

            // Calculate calories burned
            caloriesBurned = 0.04 * steps + 0.04 * weight * distance; // 0.04 calories per step and distance in kilometers

            // Try to insert the calculated calories into the 'calories' table
            try {
                PreparedStatement insertStatement = conn.prepareStatement("INSERT INTO calories (username, calories_burned) VALUES (?, ?)");
                insertStatement.setString(1, username);
                insertStatement.setDouble(2, caloriesBurned);
                insertStatement.executeUpdate();
            } catch (SQLIntegrityConstraintViolationException duplicateException) {
                // If a duplicate entry exists, update the existing entry
                PreparedStatement updateStatement = conn.prepareStatement("UPDATE calories SET calories_burned = ? WHERE username = ?");
                updateStatement.setDouble(1, caloriesBurned);
                updateStatement.setString(2, username);
                updateStatement.executeUpdate();
            }

            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    %>

<div class="calories-result">
    <p>Calories Burned: <%= caloriesBurned %> kcal</p>
</div>

<%
    } else {
        // If username is null, redirect to login page or handle as appropriate
        response.sendRedirect("login.jsp");
    }
%>

<form action="success.jsp">
    <input type="submit" value="Back">
</form>

</body>
</html>
