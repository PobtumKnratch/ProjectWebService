<?php

// require __DIR__ . '/serverc.php';
// $db_connection = new Data_user();
// $cont = $db_connection->dbConnect();
//คิวรี่ข้อมูลหาผมรวมยอดขายโดยใช้ SQL SUM $stmt = $conn->prepare("SELECT product_type, SUM(amount) as total FROM tbl_sales GROUP BY product_type");
$stmt = $cont->prepare("SELECT topic.topic_id , count(image_integrity_check_v3.log_id) as log_id , topic.topic_name
From  image_integrity_check_v3 
INNER JOIN topic
ON topic.topic_id = image_integrity_check_v3.topic_id 
Group by topic.topic_name
");
$stmt->execute();
$result = $stmt->fetchAll();

$picData = array();
foreach ($result as $k) {

    $picData[] = "['" . $k['topic_name'] . "'" . ", " . $k['log_id'] . "]";
    // $saleData[] = "[" . ", " . $k['topic_id'] . "," . "," . ", " . $k['log_id'] . "," . "]";
}
//ตัด commar อันสุดท้ายโดยใช้ implode เพื่อให้โครงสร้างข้อมูลถูกต้องก่อนจะนำไปแสดงบนกราฟ
$picData = implode(",", $picData);
?>

<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--bootstrap5-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <!-- เรียก js มาใช้งาน -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
        google.charts.load("current", {
            packages: ["corechart"],

        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Task', 'Summary per topic_id'],

                <?php
                //เรียกใช้งานตัวแปรจากบรรทัดที่ 19
                echo $picData;

                ?>


            ]);


            var options = {
                title: 'Image Report', //ชื่อกราฟ
                // pieHole: 0.4,
                is3D: true,
                pieSliceTextStyle: {
                    color: 'black',
                },
                slices: {
                    0: {
                        color: '#2baf2b' //ตามป้าย
                    },
                    1: {
                        color: '#e84e40'//ตามโจทย์
                    },
                    2: {
                        color: '#5677fc' //รีวิวอาหาร
                    },
                    3: {
                        color: '#ffd54f' //วัฒนธรรมและชุมชน
                    }
                }
            };

            // var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
            chart.draw(data, options);
        }
    </script>


</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-10"> <br>
                <!-- <h4>PHP PDO & Donut Chart : ออกรายงานในรูปแบบกราฟวงกลม หรือ โดนัทกราฟ</h4> -->
                <?php
                //แสดงข้อมูลก่อนนำไปแสดงบนกราฟ
                // echo 'ข้อมูลที่นำไปแสดงบนกราฟ ' . $saleData; //ถ้าอยากเอาออก ก็ใส่ double slash ข้างหน้าครับ 
                ?>
                <!-- ส่วนของการแสดงผลและกำหนดขนาดของกราฟ -->
                <!-- <div id="donutchart" style="width: 900px; height: 500px; "></div> -->
                <div id="piechart_3d" style="width: 900px; height: 500px; "></div>
                <br>
                <!-- คู่มือ (docs) : https://developers.google.com/chart/interactive/docs/gallery/piechart#donut -->
            </div>
        </div>
    </div>
</body>

</html>