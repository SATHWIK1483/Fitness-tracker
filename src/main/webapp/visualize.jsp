<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Remaining Goals Calculation</title>
</head>
<body>

<h2>Remaining Goals Calculation</h2>

<%
    // Retrieve username from session
    String username = (String) session.getAttribute("username");

    // Check if username is not null
    if (username != null) {
        try {
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/fitness";
            String user = "root";
            String password = "tiger";

            // Create a connection to the database
            Connection conn = DriverManager.getConnection(url, user, password);

            // Retrieve total calories burned from the 'calories' table
            PreparedStatement caloriesStatement = conn.prepareStatement("SELECT SUM(calories_burned) AS total_calories FROM calories WHERE username = ?");
            caloriesStatement.setString(1, username);
            ResultSet caloriesResult = caloriesStatement.executeQuery();

            int totalCalories = 0;

            // Retrieve total calories burned from the result set
            if (caloriesResult.next()) {
                totalCalories = caloriesResult.getInt("total_calories");
            }

            // Retrieve goals from the 'goals' table
            PreparedStatement goalsStatement = conn.prepareStatement("SELECT calories_goal, steps_goal FROM goals WHERE username = ?");
            goalsStatement.setString(1, username);
            ResultSet goalsResult = goalsStatement.executeQuery();

            int caloriesGoal = 0;
            int stepsGoal = 0;

            // Retrieve goals from the result set
            if (goalsResult.next()) {
                caloriesGoal = goalsResult.getInt("calories_goal");
                stepsGoal = goalsResult.getInt("steps_goal");
            }

            // Calculate remaining goals
            int remainingCalories = caloriesGoal - totalCalories;

            // Retrieve total steps from the 'activity_data' table
            PreparedStatement stepsStatement = conn.prepareStatement("SELECT SUM(steps) AS total_steps FROM activity_data WHERE username = ?");
            stepsStatement.setString(1, username);
            ResultSet stepsResult = stepsStatement.executeQuery();

            int totalSteps = 0;

            // Retrieve total steps from the result set
            if (stepsResult.next()) {
                totalSteps = stepsResult.getInt("total_steps");
            }

            // Calculate remaining steps
            int remainingSteps = stepsGoal - totalSteps;

            // Display remaining goals
            out.println("<p>Remaining Calories Goal: " + remainingCalories + "</p>");
            out.println("<p>Remaining Steps Goal: " + remainingSteps + "</p>");

            // Close resources
            caloriesResult.close();
            caloriesStatement.close();
            goalsResult.close();
            goalsStatement.close();
            stepsResult.close();
            stepsStatement.close();
            conn.close();

        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    } else {
        out.println("<p>Error: User not logged in.</p>");
    }
%>

</body>
</html>
