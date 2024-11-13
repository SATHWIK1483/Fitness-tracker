<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Success Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        h2 {
            margin-top: 50px;
        }
        .button-container {
            margin-top: 30px;
        }
        .button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<h2>Welcome to Fitness Tracker</h2>

<div class="button-container">
    <button class="button" onclick="window.location.href='activitytracking.jsp'">Activity Tracking</button>
    <button class="button" onclick="window.location.href='caloriesBurnedCalculation.jsp'">Calories Burned Calculation</button>
    <button class="button" onclick="window.location.href='progressVisualization.jsp'">Progress Visualization</button>
    <button class="button" onclick="window.location.href='goalVisualization.jsp'">Goal Visualization</button>
</div>

</body>
</html>
