<?php
require_once('../Database/connect_database.php');

if (isset($_GET['edit'])) {
    $edit_id = $_GET['edit'];
    $sql = "SELECT * FROM fileupload WHERE id = $edit_id";
    $query = mysqli_query($conn, $sql);

    $getid = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);
    $getname = filter_input(INPUT_POST, "name", FILTER_SANITIZE_STRING);
    $getimage = filter_input(INPUT_POST, "image", FILTER_SANITIZE_STRING);
    $gettag = filter_input(INPUT_POST, "tag", FILTER_SANITIZE_STRING);
    while ($row = mysqli_fetch_array($query)) {
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

?>
<html>

<head>

    <title>Object Detection (coco-ssd)</title>
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
    <script src="../evalution_pic/model/coco-ssd copy.js"></script>

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

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Mali:wght@300&display=swap" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@latest"> </script>
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow-models/coco-ssd"> </script>


</head>

<body class="sb-nav-fixed" style="font-family: 'Mali', cursive;">
    
        <?php include('headerbar.php') ?>
    
    <div id="layoutSidenav">
        <?php
        include_once('leftbar.php');

        ?>

        <div id="layoutSidenav_content">

            <main>
                <div class="container-fluid px-4">
                    <!-- <div class="row"> -->
                    <!-- <div class="col-6"> -->
                    <h1>Object Detection (coco-ssd)</h1>
                    <form action="evalution_success.php?edit_form=<?php echo $post_id ?>" method="post" enctype="multipart/form-data" name="update" id="update_profile">
                        <canvas id="canvas" width="300px" height="300px" display:block style="top:50;border:0px solid;"></canvas>
                        <img id="canvasimg" src="../pictur_data/fileupload/<?php echo $post_picture ?>" style="display: flex; width: 300px;height: 300px;" />
                        <div class="mt-3">
                            <label>ชื่อรูปภาพ: <?php echo $post_name ?></label><br>
                            <label>วันที่อัพโหลด: <?php echo $post_date ?></label>

                            <div class="mt-1" id="output" style="position:absolute;top:510px; font-family:courier;font-size:18px;height:300px">Result</div>

                        </div>



                    </form>
                    <!-- </div> -->
                    <!-- </div> -->

                </div>

            </main>
            <form action="evalution_food.php">
                <div>
                    <button type="submit" class="btn btn-danger">ย้อนกลับ</button>
                </div>
            </form>
        </div>
    </div>
</body>

</html>