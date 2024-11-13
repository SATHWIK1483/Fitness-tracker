<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Goal Visualization</title>
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
            margin: 5px;
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

<h2>Goal Visualization</h2>

<form action="setGoal.jsp" method="post">
    <label for="steps_goal">Daily Steps Goal:</label><br>
    <input type="text" id="steps_goal" name="steps_goal"><br>
    <label for="calories_goal">Daily Calories Goal:</label><br>
    <input type="text" id="calories_goal" name="calories_goal"><br>
    <input type="submit" value="Set Goal">
</form>

<%
    // Get the username from the session
    String username = (String) session.getAttribute("username");

    // Ensure username exists
    if (username == null) {
        out.println("<p>Error: User not logged in.</p>");
    } else {
        // Retrieve form data
        String stepsGoalStr = request.getParameter("steps_goal");
        String caloriesGoalStr = request.getParameter("calories_goal");

        if (stepsGoalStr != null && caloriesGoalStr != null) {
            // Convert to appropriate data types
            int stepsGoal = Integer.parseInt(stepsGoalStr);
            int caloriesGoal = Integer.parseInt(caloriesGoalStr);

            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/fitness";
            String user = "root";
            String password = "tiger";

            // SQL statement to insert goals into the table
            String sql = "INSERT INTO goals (username, steps_goal, calories_goal) VALUES (?, ?, ?)";

            try {
                // Connect to the database
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                // Create prepared statement
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setInt(2, stepsGoal);
                pstmt.setInt(3, caloriesGoal);

                // Execute the statement
                pstmt.executeUpdate();

                // Close resources
                pstmt.close();
                conn.close();

                // Display confirmation message
                out.println("<p>Goals set successfully!</p>");
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>
