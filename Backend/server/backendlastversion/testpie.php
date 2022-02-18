<?php
require __DIR__ . './Database/server.php';
$db_connection = new Data_user();
$cont = $db_connection->dbConnect();
//คิวรี่ข้อมูลหาผมรวมยอดขายโดยใช้ SQL SUM $stmt = $conn->prepare("SELECT product_type, SUM(amount) as total FROM tbl_sales GROUP BY product_type");
$stmt = $cont->prepare("SELECT topic.topic_id , count(image_integrity_check_v3.log_id) as log_id , topic.topic_name
 From  image_integrity_check_v3 
 INNER JOIN topic
 ON topic.topic_id = image_integrity_check_v3.topic_id 
 Group by topic.topic_name
 ");
$stmt->execute();
$result = $stmt->fetchAll();


$dataPoints = array();
foreach ($result as $k) {

    $dataPoints[] = "['" . $k['topic_name'] . "'" . ", " . $k['log_id'] . "]";
};


?>
<!DOCTYPE HTML>
<html>

<head>
    <script>
        window.onload = function() {

            var chart = new CanvasJS.Chart("chartContainer", {
                theme: "light2",
                animationEnabled: true,
                title: {
                    text: "Average Composition of Magma"
                },
                data: [{
                    type: "doughnut",
                    indexLabel: "{symbol} - {y}",
                    yValueFormatString: "#,##0.0\"%\"",
                    showInLegend: true,
                    legendText: "{label} : {y}",
                    dataPoints: <?php echo json_encode($dataPoints, JSON_NUMERIC_CHECK); ?>
                }]
            });
            chart.render();

        }
    </script>
</head>

<body>
    <div id="chartContainer" style="height: 370px; width: 100%;"></div>
    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>

</html>