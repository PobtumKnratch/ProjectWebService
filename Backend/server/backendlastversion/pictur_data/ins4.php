<?php
include_once './Database/server.php';

$db_connection = new Data_pic();
$cont = $db_connection->dbConnect();


if (isset($_REQUEST['delete_id'])) {
    $id = $_REQUEST['delete_id'];

    $select_stm = $cont->prepare('SELECT * FROM fileupload4 WHERE id = :id');
    $select_stm->bindParam(':id', $id);
    $select_stm->execute();
    $row = $select_stm->fetch(PDO::FETCH_ASSOC);
    unlink("fileupload4/" . $row['image']);

    $delete_stm = $cont->prepare('DELETE FROM fileupload4 Where id = :id');
    $delete_stm->bindParam(':id', $id);
    $delete_stm->execute();

    header("Location: ins4.php");
}
if (isset($_GET['edit'])) {
    $edit_id = $_GET['edit'];
    $select_stm = $cont->prepare('SELECT * FROM fileupload4 WHERE id = :id');
    $select_stm->bindParam(':id', $id);
    $select_stm->execute();

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

<head>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Index</title>
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
</head>

<body>

    <?php
    ini_set('display_errors', 1);
    error_reporting(~0);

    $strKeyword = null;

    if (isset($_POST["txtKeyword"])) {
        $strKeyword = $_POST["txtKeyword"];
    }



    ?>

    <div class="row">
        <div class="col">
            <a href="upsin.php" class="btn btn-success">Add image</a>
        </div>
        <div class="col-4">
            <form name="frmSearch" method="post" action="<?php echo $_SERVER['SCRIPT_NAME']; ?>">
                <div class="input-group">
                    <input style="font-family: 'Mali', cursive;" class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" name="txtKeyword" id="txtKeyword" value="<?php echo $strKeyword; ?>" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
                </div>
            </form>
        </div>
    </div>

    <!-- id="datatablesSimple" -->
    <table class="table table-striped table-bordered table-hover mt-3">



        <thead>
            <tr style="font-family: 'Mali', cursive;">
                <th>
                    <center>Id</center>
                </th>
                <th>
                    <center>Name</center>
                </th>
                <th>
                    <center>Image</center>
                </th>
                <th>
                    <center>Tag</center>
                </th>
                <th>
                    <center>Edit</center>
                </th>
                <th>
                    <center>Delete</center>
                </th>
            </tr>
        </thead>

        <tbody>
            <?php
            $sql = "SELECT count(*) FROM fileupload4 ";
            try {
                $select_stm = $cont->prepare($sql);
                // $stm->bindParam(":userid", $id);
                $select_stm->execute();
            } catch (Exception $e) {
                $e->getMessage();
            }

            $num_rows = $select_stm->fetchColumn();

            $per_page = 5;   // Per Page
            $page  = 1;

            if (isset($_GET["Page"])) {
                $page = $_GET["Page"];
            }

            $prev_page = $page - 1;
            $next_page = $page + 1;

            $row_start = (($per_page * $page) - $per_page);
            if ($num_rows <= $per_page) {
                $num_pages = 1;
            } else if (($num_rows % $per_page) == 0) {
                $num_pages = ($num_rows / $per_page);
            } else {
                $num_pages = ($num_rows / $per_page) + 1;
                $num_pages = (int)$num_pages;
            }
            $row_end = $per_page * $page;
            if ($row_end > $num_rows) {
                $row_end = $num_rows;
            }


            // $sql = " SELECT * FROM fileupload4 where id ORDER BY id limit {$row_start},{$per_page}";
            // $select_stm = $cont->prepare($sql);
            // $select_stm->execute();

            $sql = " SELECT * FROM fileupload4 where name LIKE '%" . $strKeyword . "%' ORDER BY id limit {$row_start},{$per_page} ";
            $select_stm = $cont->prepare($sql);
            $select_stm->execute();

            while ($row = $select_stm->fetch(PDO::FETCH_ASSOC)) {
                $post_id = $row['id'];
            ?>

                <tr style="font-family: 'Mali', cursive;">
                    <form action="show_data_scenario.php?update_id=<?php echo $row['id']; ?>" method="post" name="show">

                        <input type="hidden" name="id" value="<?php echo $row['id']; ?>" />
                        <input type="hidden" name="image" value="fileupload4/<?php echo $row['image']; ?>" />
                        <input type="hidden" name="name" value="<?php echo $row['name']; ?>" />
                        <input type="hidden" name="tag" value="<?php echo $row['tag']; ?>" />

                        <td style="width: 100px; vertical-align: middle;">

                            <center> <?php echo $row['id']; ?></center>
                        </td>
                        <td style="width: 500px; vertical-align: middle;">
                            <center> <?php echo $row['name']; ?></center>
                        </td>

                        <td style=" vertical-align: middle;">
                            <!-- <a target="_blank" href="fileupload/<?php echo $row['image']; ?>">
                                <img src="fileupload/<?php echo $row['image']; ?>" alt=" Forest" style="width: 60px;">
                            </a> -->
                            <center><input type="image" name="type" value="1" src="fileupload4/<?php echo $row['image']; ?>" style="width: 100px; height: 80;" /></center>

                        </td>

                        <td style="width: 500px; vertical-align: middle;">
                            <center> <?php echo $row['tag']; ?></center>
                        </td>
                    </form>

                    <form action="edit_sin.php?update_id=<?php echo $row['id']; ?>" method="post" name="update">
                        <input type="hidden" name="id" value="<?php echo $row['id']; ?>" />
                        <input type="hidden" name="image" value="fileupload4/<?php echo $row['image']; ?>" />
                        <input type="hidden" name="name" value="<?php echo $row['name']; ?>" />
                        <input type="hidden" name="tag" value="<?php echo $row['tag']; ?>" />
                        <td style="width: 100px; vertical-align: middle;">
                            <center> <button class="btn btn-warning" type="Submit">Edit</button></center>
                        </td>
                        <td style="width: 100px; vertical-align: middle;">
                            <center>
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop<?php echo $row['id']; ?>">
                                    Delete
                                </button>
                                <!-- <a href="JavaScript:{window.location='delete_pic4.php?id=<?php echo $row['id']; ?>';}" onclick="return confirm('คุณต้องการจะลบรูปภาพใช่หรือไม่? !!!')" class="btn btn-danger">Delete</a> -->
                            </center>
                        </td>

                    </form>
                </tr>

                <form action="delete_pic2.php?id=<?php echo $row['id']; ?>" method="post" name="delete">
                    <div class="modal fade" id="staticBackdrop<?php echo $row['id']; ?>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="staticBackdropLabel">ลบข้อมูล</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    คุณต้องการจะลบรูปภาพใช่หรือไม่?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">ยกเลิก</button>
                                    <button type="submit" class="btn btn-primary">ตกลง</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            <?php
            }
            ?>

        </tbody>
    </table>
    <br>

    <nav aria-label="Page navigation example">
        <!-- Total <?php echo $num_rows; ?> Record : <?php echo $num_pages; ?> Page : -->
        <ul class="pagination" style="height: 65px;background-color: white;margin-left: 70rem;">

            <li class="page-item ">
                <?php
                if ($prev_page) {
                    echo " <a href='$_SERVER[SCRIPT_NAME]?Page=$prev_page' class='page-link'>  Back </a> ";
                } ?>
            </li>
            <li class="page-item">
                <?php
                for ($i = 1; $i <= $num_pages; $i++) {
                    if ($i != $page) {
                        echo "<li class='page-item' > <a href='$_SERVER[SCRIPT_NAME]?Page=$i ' class='page-link'>$i</a></li> ";
                    } else {
                        echo "<li class='page-item active' aria-current='page'> <b class='page-link'> $i </b></li>";
                    }
                } ?>
            </li>
            <li class="page-item">
                <?php
                if ($page != $num_pages) {

                    echo " <a href ='$_SERVER[SCRIPT_NAME]?Page=$next_page' class='page-link' > Next </a> ";
                }
                $cont = null;
                ?>
            </li>

        </ul>
    </nav>
    <!-- </div> -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="../js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
    <script src="../js/datatables-simple-demo.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>