<?php
// require __DIR__ . '/Database/server.php';


// $db_connection = new Data_user();
// $cont = $db_connection->dbConnect();



?>


<!DOCTYPE html>
<html lang="th">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Tables - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Mali:wght@300&display=swap" rel="stylesheet">
</head>

<body style="font-family: 'Mali', cursive;">

    <!-- <div id="layoutSidenav_content"> -->
    <main>



        <!-- <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            DataTable Example
                        </div> -->
        <a href="insert_user.php" class="btn btn-success mt-2" style=" width:10rem;height: 2.5rem;font-family: 'Mali', cursive;">
            <span class="fas fa-plus" aria-hidden="adduser"></span> เพิ่มข้อมูลผู้ใช้ </a>
        <div class="card-body">
            <table id="datatablesSimple" class="table table-striped table-bordered table-hover mt-3">

                <thead>
                    <tr>
                        <th style="font-family: 'Mali', cursive;">Id</th>
                        <th style="font-family: 'Mali', cursive;">Firstname</th>
                        <th style="font-family: 'Mali', cursive;">Lastname</th>
                        <th style="font-family: 'Mali', cursive;">Email</th>
                        <th style="font-family: 'Mali', cursive;">Topic Id</th>
                        <th style="font-family: 'Mali', cursive;">Edit</th>
                        <th style="font-family: 'Mali', cursive;">Delete</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th style="font-family: 'Mali', cursive;">Id</th>
                        <th style="font-family: 'Mali', cursive;">Firstname</th>
                        <th style="font-family: 'Mali', cursive;">Lastname</th>
                        <th style="font-family: 'Mali', cursive;">Email</th>
                        <th style="font-family: 'Mali', cursive;">Topic Id</th>
                        <th style="font-family: 'Mali', cursive;">Edit</th>
                        <th style="font-family: 'Mali', cursive;">Delete</th>
                    </tr>
                </tfoot>

                <tbody>
                    <?php
                    $sql = "SELECT * FROM user_info where info_id ";
                    try {
                        $stm = $cont->prepare($sql);
                        // $stm->bindParam(":userid", $id);
                        $stm->execute();
                    } catch (Exception $e) {
                        $e->getMessage();
                    }

                    while (($row = $stm->fetch(PDO::FETCH_ASSOC))) {
                        $post_id = $row['info_id'];
                        // $post_name = $row['username'];
                        $post_firstname = $row['firstname'];
                        $post_lastname = $row['lastname'];
                        $post_email = $row['email'];
                        $post_topic_id = $row['topic_id'];
                        // $post_email = $row['email'];
                    ?>
                        <tr>
                            <td style="font-family: 'Mali', cursive;"><?php echo "$post_id " ?></td>
                            <td style="font-family: 'Mali', cursive;"><?php echo "$post_firstname " ?></td>
                            <td style="font-family: 'Mali', cursive;"><?php echo "$post_lastname " ?></td>
                            <td style="font-family: 'Mali', cursive;"><?php echo "$post_email " ?></td>
                            <td style="font-family: 'Mali', cursive;"><?php echo "$post_topic_id " ?></td>
                            <td style="font-family: 'Mali', cursive;"><a href="edit_user.php?info_id=<?php echo $post_id; ?>">edit</a></td>
                            <td style="font-family: 'Mali', cursive;"><a href="JavaScript:{window.location='delete_user.php?info_id=<?php echo $post_id; ?>';}" onclick="return confirm('คุณต้องการจะลบข้อมูลของทนายใช่หรือไม่? !!!')">
                                    Delete</a></td>
                        </tr>
                    <?php } ?>

                </tbody>

            </table>
        </div>
        <!-- </div>
        </div> -->
    </main>

    <!-- </div> -->
    <!-- </div> -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script> -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>