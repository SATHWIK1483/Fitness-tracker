<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Process</title>
</head>
<body>

<%
    // Retrieve username and password from the request parameters
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // JDBC URL, username, and password for your database connection
    String jdbcUrl = "jdbc:mysql://localhost:3306/fitness";
    String dbUsername = "root";
    String dbPassword = "tiger";

    // JDBC variables
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Load and register the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the database connection
        connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

        // Prepare the SQL query to fetch user information based on the provided username and password
        String query = "SELECT * FROM user WHERE username = ? AND password = ?";
        preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);

        // Execute the query
        resultSet = preparedStatement.executeQuery();

        // Check if the result set contains any rows
        if (resultSet.next()) {
            // If the result set contains rows, the username and password are valid
            // Redirect the user to a success page
            response.sendRedirect("success.jsp");
        } else {
            // If the result set is empty, the username or password is invalid
            // Redirect the user to a failure page
            response.sendRedirect("failure.jsp");
        }
    } catch (SQLException e) {
        // Handle any SQL exceptions
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        // Handle class not found exception
        e.printStackTrace();
    } finally {
        // Close JDBC objects in finally block to ensure they are closed even if an exception occurs
        try {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            // Handle any SQL exceptions during closing of resources
            e.printStackTrace();
        }
    }
%>

</body>
</html>
