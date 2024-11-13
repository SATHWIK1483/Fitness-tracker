<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Progress Visualization</title>
    <!-- Include necessary libraries for visualization -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        // Load the Visualization API and the corechart package.
        google.charts.load('current', {'packages':['corechart']});

        // Set a callback to run when the Google Visualization API is loaded.
        google.charts.setOnLoadCallback(drawCharts);

        // Function to draw the charts
        function drawCharts() {
            // Dummy data for demonstration
            var data = google.visualization.arrayToDataTable([
                ['Date', 'Steps', 'Distance (km)', 'Calories Burned'],
                ['2024-03-01', 5000, 3.5, 200],
                ['2024-03-02', 6000, 4.2, 230],
                ['2024-03-03', 7000, 4.9, 250],
                // Add more data as needed
            ]);

            // Define options for the charts
            var options = {
                title: 'Daily Progress',
                curveType: 'function',
                legend: { position: 'bottom' }
            };

            // Instantiate and draw the steps chart
            var stepsChart = new google.visualization.LineChart(document.getElementById('steps_chart'));
            stepsChart.draw(data, options);

            // Instantiate and draw the distance chart
            var distanceChart = new google.visualization.LineChart(document.getElementById('distance_chart'));
            distanceChart.draw(data, options);

            // Instantiate and draw the calories burned chart
            var caloriesChart = new google.visualization.LineChart(document.getElementById('calories_chart'));
            caloriesChart.draw(data, options);
        }
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        #charts_container {
            display: flex;
            justify-content: space-around;
            margin-top: 50px;
        }
        .chart {
            width: 400px;
            height: 300px;
        }
    </style>
</head>
<body>

<h2>Progress Visualization</h2>

<div id="charts_container">
    <div id="steps_chart" class="chart"></div>
    <div id="distance_chart" class="chart"></div>
    <div id="calories_chart" class="chart"></div>
</div>

</body>
</html>
