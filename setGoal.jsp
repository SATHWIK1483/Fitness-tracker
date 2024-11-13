<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Set Goal</title>
</head>
<body>

<%
    // Retrieve parameters from the request
    String stepsGoalStr = request.getParameter("steps_goal");
    String caloriesGoalStr = request.getParameter("calories_goal");

    // Retrieve username from the session
    String username = (String) session.getAttribute("username");

    // Ensure that both parameters and username are not null
    if (stepsGoalStr != null && caloriesGoalStr != null && username != null) {
        try {
            // Convert parameters to appropriate data types
            int stepsGoal = Integer.parseInt(stepsGoalStr);
            int caloriesGoal = Integer.parseInt(caloriesGoalStr);

            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/fitness";
            String user = "root";
            String password = "tiger";

            // Create a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);

            // Check if a goal already exists for the user
            PreparedStatement checkStatement = conn.prepareStatement("SELECT * FROM goals WHERE username = ?");
            checkStatement.setString(1, username);
            ResultSet checkResult = checkStatement.executeQuery();

            if (checkResult.next()) {
                // If a goal already exists, update it
                String updateSql = "UPDATE goals SET steps_goal = ?, calories_goal = ? WHERE username = ?";
                PreparedStatement updateStatement = conn.prepareStatement(updateSql);
                updateStatement.setInt(1, stepsGoal);
                updateStatement.setInt(2, caloriesGoal);
                updateStatement.setString(3, username);
                updateStatement.executeUpdate();
                updateStatement.close();
            } else {
                // If no goal exists, insert a new one
                String insertSql = "INSERT INTO goals (username, steps_goal, calories_goal) VALUES (?, ?, ?)";
                PreparedStatement insertStatement = conn.prepareStatement(insertSql);
                insertStatement.setString(1, username);
                insertStatement.setInt(2, stepsGoal);
                insertStatement.setInt(3, caloriesGoal);
                insertStatement.executeUpdate();
                insertStatement.close();
            }

            // Close resources
            checkResult.close();
            checkStatement.close();
            conn.close();

            // Display success message
            out.println("<p>Goals set successfully!</p>");
        } catch (NumberFormatException e) {
            // Handle invalid number format
            out.println("<p>Error: Please enter valid numbers for goals.</p>");
            e.printStackTrace();
        } catch (Exception e) {
            // Handle other exceptions
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    } else {
        // Handle missing parameters or username
        out.println("<p>Error: Parameters missing or user not logged in.</p>");
    }
%>

<form action="visualize.jsp" method="post">
    <input type="submit" value="Visualize">
</form>

</body>
</html>
