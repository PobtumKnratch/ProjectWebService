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

<?php
require_once('../Database/connect_database.php');

$data_lawyer = "SELECT * FROM fileupload4 WHERE id ";
$query_data = mysqli_query($conn, $data_lawyer);

include('./checksession.php');

?>

<body class="sb-nav-fixed" style="font-family: 'Mali', cursive;">
    
        <?php include('headerbar.php') ?>
    
    <div id="layoutSidenav">
        <?php
        include_once('leftbar.php');
        ?>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">

                    <table class="table table-striped table-bordered table-hover mt-3" id="datatablesSimple">

                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Edit</th>
                                <!-- <th>Delete</th> -->
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Name</th>
                                <th>Image</th>
                                <th>Edit</th>
                                <!-- <th>Delete</th> -->
                            </tr>
                        </tfoot>
                        <tbody>
                            <?php while ($row = mysqli_fetch_array($query_data)) {
                                $post_id = $row['id'];
                                $post_picture = $row['image'];
                                $post_name = $row['name'];
                                $post_date = $row['date'];
                                // $post_tel = $row['lawyer_tel'];
                                // $post_email = $row['lawyer_email'];
                                // $post_experience = $row['lawyer_experience'];
                            ?>

                                <tr>
                                    <td><label class="card-text">ชื่อรูปภาพ: <?php echo $post_name ?> </label>
                                        <label class="card-text">วันที่ทำการอัปโหลด: <?php echo $post_date ?></label>
                                    </td>
                                    <td>
                                        <img src="../pictur_data/fileupload4/<?php echo $post_picture ?>" class="align-self-center mr-3" width="90" height="90" alt="image_food">
                                    </td>
                                    <td>
                                        <a href="evalution_data_scenario.php?edit=<?php echo $post_id; ?>" class="btn btn-success"> Checking </a>

                                    <!-- </td>
                                    <td><a href="delete_lawyer.php?delete=<?php echo $post_id; ?>" onclick="return confirm('คุณต้องการจะลบข้อมูลใช่หรือไม่? !!!')" class="btn btn-danger">Delete</a>
                                    </td> -->
                                </tr>

                            <?php } ?>

                        </tbody>
                    </table>


                </div>

        </div>
        </main>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="../js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
    <script src="../js/datatables-simple-demo.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>