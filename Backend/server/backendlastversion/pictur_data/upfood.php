<?php
require __DIR__ . '/Database/server.php';

$db_connection = new Data_pic();
$cont = $db_connection->dbConnect();

include('./checksession.php');

date_default_timezone_set('Asia/Bangkok');
$date = date("Ymd");
$numrand = (mt_rand());

if (isset($_REQUEST['btn_insert'])) {
    try {
        $name = $_REQUEST['text_name'];
        $tag = $_REQUEST['text_tag'];
        $img_file = $_FILES['text_file']['name'];
        $type = $_FILES['text_file']['type'];
        $size = $_FILES['text_file']['size'];
        $temp = $_FILES['text_file']['tmp_name'];

        $snewname = $date . $numrand;

        $path = "fileupload/" . $snewname . $img_file;
        $path2 = $snewname . $img_file;


        $Rename = $_FILES['text_file']['name'];
        $Rename = preg_replace('/\\.[^.\\s]{3,4}$/', '', $img_file);
        $ext = pathinfo($_FILES['text_file']['name'], PATHINFO_EXTENSION);

        $newname = "fileupload/" . $snewname . "." . $ext;
        $newnametodb = $date . $numrand . "." . $ext;


        if (empty($name)) {
            $errorMsg = "Please Enter name";
        } else if (empty($img_file)) {
            $errorMsg = "Please Select Image";
        } else if ($type == "image/jpg" || $type == 'image/jpeg' || $type == "image/png" || $type == "image/gif") {
            if (!file_exists($path)) {
                if ($size < 5000000) {
                    move_uploaded_file($temp,  $newname);
                } else {
                    $errorMsg = "Your file too large please upload";
                }
            } else {
                $errorMsg = "File already exists";
            }
        } else {
            $errorMsg = "Upload JPG,JPEG,PNG & GIF ";
        }

        if (!isset($errorMsg)) {
            $stmt = $cont->prepare('INSERT INTO fileupload (name,image,tag) VALUE(:fname,:fimage,:tag) ');
            $stmt->bindParam(':fname', $name);
            $stmt->bindParam(':fimage', $newnametodb);
            $stmt->bindParam(':tag', $tag);
            if ($stmt->execute()) {
                $insertMsg = "File Uploaded Successfully...";
                header('refresh:0;food.php');
            }
        }
    } catch (PDOException $e) {
        $e->getMessage();
    }
}

?>

<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Upload</title>


    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="../css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>

</head>

<body class="sb-nav-fixed" style="font-family: 'Mali', cursive;">
    
        <?php include('headerbar.php') ?>
    
    <div id="layoutSidenav">
        <?php
        include_once('leftbar.php');
        ?>



<div class="col-9 mt-5" style="margin-left:20rem;">

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


?>


<div class="col-9 mt-5" style="margin-left:20rem;">
    <div class="row">
        <div class="col-6">
            <h4 style="margin-top: 1rem; margin-left:2rem;" ;></i>เพิ่มรูปภาพ </h4>
        </div>

    </div>

    <div class="rom mt-3">
        <div class="card" style=" width:65rem;">
            <div class="card-body">

                <form action="" method="post" class="form-horizontal" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-rabel">Name</label>
                        <div class="col-sm-6">
                            <input type="text" name="text_name" class="form-control" placeholder="Enter Name" style="width:60rem;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-rabel">File</label>
                        <div class="col-sm-6">
                            <input type="file" name="text_file" class="form-control" style="width:60rem;" />
                        </div>
                    </div>
                    <label for="name" class="col-sm-3 control-rabel">Tag</label>
                        <div class="col-sm-6">
                            <textarea type="text" name="text_tag" class="form-control" placeholder="Enter Tag" style="width:60rem; height: 150px ;"></textarea>
                            <!-- <input type="text" name="text_tag" class="form-control" placeholder="Enter Tag" style="width:60rem;"> -->
                        </div>
                    </div>
                    <br>
                    <div class="form-group">
                        <center>
                            <div class="col-sm-12">
                                <input type="submit" name="btn_insert" class="btn btn-success" value="Insert">
                                <a href="food.php" class="btn btn-danger">Cancel</a>
                            </div>
                        </center>
                    </div>

                </form>

            </div>
        </div>
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