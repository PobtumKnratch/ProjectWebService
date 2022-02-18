<head>

    <style>
        html,
        body {
            width: 100%;
            height: 100%;
            margin: 0;
        }

        canvas {

            display: contents;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 100%;
            height: 100%;
        }
    </style>

    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@latest"> </script>
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow-models/coco-ssd"> </script>
    <script src="../evalution_pic/model/coco-ssd.js"></script>

    <script>
        window.onload = function() {
            var canvas = document.getElementById("canvas");
            var img = document.getElementById("canvasimg");
            const outp = document.getElementById('output');

            var context = canvas.getContext('2d');
            context.drawImage(img, 0, 0);

            cocoSsd.load().then(model => {
                model.detect(img).then(predictions => {
                    console.log(predictions);
                    for (var i = 0; i < predictions.length; i++) {
                        bbox = predictions[i].bbox
                        context.beginPath();
                        context.rect(bbox[0], bbox[1], bbox[2], bbox[3]);
                        context.lineWidth = 3;
                        context.strokeStyle = 'green';
                        context.stroke();
                        context.fillStyle = "green";
                        context.fillText(predictions[i].class, bbox[0] + 4, bbox[1] + 12);
                        outp.innerHTML += "<br/>" + predictions[i].class + " : Score = " + predictions[i].score + " : bbox = " + bbox;
                    }
                });
            });

        }
    </script>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Tables - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="../css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>


</head>
<?php
//กำหนดค่า Access-Control-Allow-Origin ให้ เครื่อง อื่น ๆ สามารถเรียกใช้งานหน้านี้ได้

// header("Access-Control-Allow-Origin: *");

// header("Content-Type: application/json; charset=UTF-8");

// header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");

// header("Access-Control-Max-Age: 3600");

// header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

//ตั้งค่าการเชื่อมต่อฐานข้อมูล
include_once('./Database/server.php');


$db_connection = new Data_pic();
$cont = $db_connection->dbConnect();



$requestMethod = $_SERVER["REQUEST_METHOD"];

if (isset($_GET['edit'])) {
    $edit_id = $_GET['edit'];
    $select_stm = $cont->prepare('SELECT * FROM fileupload4 WHERE id = :id');
    $select_stm->bindParam(':id', $id);
    $select_stm->execute();

    while ($row = $select_stm->fetch(PDO::FETCH_ASSOC)) {
        $post_id = $row['id'];
        $post_picture = $row['image'];
        $post_name = $row['name'];
        $post_date = $row['date'];
        //   $post_username = $row['lawyer_username'];
        //   $post_password = $row['lawyer_password'];
        //   $post_tel = $row['lawyer_tel'];
        //   $post_email = $row['lawyer_email'];
        //   $post_education = $row['lawyer_education'];
        //   $post_experience = $row['lawyer_experience'];
    }
}


// $strCustomerID = null;
// if (isset($_GET["id"])) {
//   $strCustomerID = $_GET["id"];
// }

// $sql = "SELECT * FROM fileupload4 WHERE id =?";
// $params = array($strCustomerID);

// $stmt = $cont->prepare($sql);
// $stmt->execute($params);

// $result = $stmt->fetch(PDO::FETCH_ASSOC);

// function meta_show()
// {
//     global $cont;

//     if (!filter_input(INPUT_GET, "metadata", FILTER_VALIDATE_INT)) {
//     }

//     if (isset($_REQUEST['metadata'])) {
//         $id = $_REQUEST['metadata'];

//         $select_stm = $cont->prepare('SELECT * FROM fileupload4 WHERE id = :id');
//         $select_stm->bindParam(':id', $id);
//         $select_stm->execute();
//         $row = $select_stm->fetch(PDO::FETCH_ASSOC);

//         unlink("fileupload4/" . $row['image']);
//     }
// }

// $mtdbtn =echo ($_GET.['metadata'].'<br>');
// if(!empty($result)){

// $mtdimg = $result["image"];
$image_name = exif_read_data($mtdimg);


?>
<canvas id="canvas" width="300px" height="300px" display:block style="top:50;border:0px solid;"></canvas>
<img id="canvasimg" src="../pictur_data/fileupload4/<?php echo $post_picture ?> " style="display: flex; width: 300px;height: 300px;" />   
<?php
// echo "<img src=" . $mtdimg . " while=''100px' height='100px' alt=''/>";
?>
<?php
// echo meta_data($image_name);

?>

<?php

function meta_data($image_name)
{

    foreach ($image_name as $key => $value) {
        if (is_array($value)) {
            echo $key . '<br />';
            foreach ($value as $key1 => $value1) {
                echo $key1 . ':' . $value1 . '<br />';
            }
        } else {
            echo $key . ':' . $value . '<br />';
        }
    }
}

// return $image_name;
// }

// $result = mysqli_query($link, $sql);

// if ($result) {
//     echo json_encode(['status' => 'ok', 'message' => 'Update Data Complete']);
// } else {
//     echo json_encode(['status' => 'error', 'message' => 'Error']);
// }

?>