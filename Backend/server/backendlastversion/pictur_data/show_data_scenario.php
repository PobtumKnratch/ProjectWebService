<?php
include_once './Database/server.php';

$db_connection = new Data_pic();
$cont = $db_connection->dbConnect();

include('./checksession.php');

$getid = filter_input(INPUT_POST, "id", FILTER_VALIDATE_INT);
$getname = filter_input(INPUT_POST, "name", FILTER_SANITIZE_STRING);
$getimage = filter_input(INPUT_POST, "image", FILTER_SANITIZE_STRING);
$gettag = filter_input(INPUT_POST, "tag", FILTER_SANITIZE_STRING);

if (isset($_REQUEST['update_id'])) {
    try {

        $id = $_REQUEST['update_id'];
        $select_stmt = $cont->prepare('SELECT *  FROM fileupload4 WHERE id=:id ');
        $select_stmt->bindParam(':id', $id);
        $select_stmt->execute();
        $row = $select_stmt->fetch(PDO::FETCH_ASSOC);
        extract($row);
    } catch (PDOException $e) {
        $e->getMessage();
    }
}

if (isset($_REQUEST['btn_update'])) {
    try {
        $name = $_REQUEST['text_name'];
        $tag = $_REQUEST['text_tag'];
        $img_file = $_FILES['text_file']['name'];
        $type = $_FILES['text_file']['type'];
        $size = $_FILES['text_file']['size'];
        $temp = $_FILES['text_file']['tmp_name'];

        $path = "fileupload4/" . $img_file;
        $directory = "fileupload4/";



        if ($img_file) {
            if ($type == "image/jpg" || $type == 'image/jpeg' || $type == "image/png" || $type == "image/gif") {
                if (!file_exists($path)) {
                    if ($size < 5000000) {
                        unlink($directory . $row['image']);
                        move_uploaded_file($temp, "fileupload4/" . $img_file);
                    } else {
                        $errorMsg = "Your file too large please upload again";
                    }
                } else {
                    $errorMsg = "File already exists";
                }
            } else {
                $errorMsg = "Upload JPG,JPEG,PNG & GIF ";
            }
        } else {
            $img_file = $row['image'];
        }
        if (!isset($errorMsg)) {
            $update_stmt = $cont->prepare("UPDATE fileupload4 SET name=:name_up,image=:file_up ,tag=:tag Where id=:id ");
            $update_stmt->bindParam(':name_up', $name);
            $update_stmt->bindParam(':file_up', $img_file);
            $update_stmt->bindParam(':tag', $tag);
            $update_stmt->bindParam(':id', $id);

            if ($update_stmt->execute()) {
                $updateMsg = "Update Successfully...";
                header("refresh:1;scenario.php");
            }
        }
    } catch (PDOException $e) {
        $e->getMessage();
    }
}



?>

<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Edit</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="../css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Mali:wght@300&display=swap" rel="stylesheet">
</head>

<body class="sb-nav-fixed">
    
        <?php include('headerbar.php') ?>
    
    <div id="layoutSidenav">
        <?php
        include_once('leftbar.php');
        ?>

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">


                    <div class="container text-center">
                        <?php
                        if (isset($errorMsg)) {

                        ?>
                            <div class="alert alert-danger">
                                <strong><?php echo $errorMsg; ?></strong>
                            </div>
                        <?php
                        }
                        ?>


                        <?php
                        if (isset($insertMsg)) {

                        ?>
                            <div class="alert alert-success">
                                <strong><?php echo $insertMsg; ?></strong>
                            </div>
                        <?php
                        }
                        // var_dump($row ['name']);
                        // var_dump($row ['image']);
                        // var_dump($getimage);

                        ?>
                        <br>
                        <div class="card" style="font-family: 'Mali', cursive;">
                            <form action="" method="post" class="form-horizontal" enctype="multipart/form-data">
                                <p><img src="<?php echo $getimage; ?>" while="300" height="300px" alt=""></p>

                                <div class="form-group">
                                    <label for="name" class="col-sm-3 control-rabel"><?php echo $getname; ?></label>
                                    <div class="col-sm-11">
                                        <!-- <input type="text" name="text_name" class="form-control" value=""> -->
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="name" class="col-sm-3 control-rabel"><?php echo $row['image']; ?></label>
                                    <!-- <div class="col-sm-11">
                                        <input type="file" name="text_file" class="form-control" value="" />
                                    </div> -->
                                </div>

                                <div class="form-group">
                                    <label for="name" class="col-sm-3 control-rabel"><?php echo $gettag ?></label>
                                    <!-- <div class="col-sm-11">
                                        <input type="text" name="text_tag" class="form-control" value="<?php echo $gettag; ?>">
                                    </div> -->
                                </div>


                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <!-- <input type="submit" name="btn_update" class="btn btn-primary" value="Update"> -->
                                        &nbsp;
                                        <a href="scenario.php" class="btn btn-danger">Back</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>

        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>
</body>
<?php //} 
?>