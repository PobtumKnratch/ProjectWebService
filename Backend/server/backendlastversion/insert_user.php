<?php
session_start();
// if (!isset($_SESSION['id_admin'])) {
//   // header('Refresh:0 url=../login_Admin.php');
// }

require __DIR__ . '/Database/server.php';
$db_connection = new Data_user();
$cont = $db_connection->dbConnect();

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>lawyer_dashboard</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../node_modules/bootstrap/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Mali:wght@300&display=swap" rel="stylesheet">
  <!-- Main CSS-->
  <link href="../css/theme.css" rel="stylesheet" media="all">
  <!-- Modal CSS-->
  <link href="../css/lawyer_modal.css" rel="stylesheet" media="all">

</head>



<body class="sb-nav-fixed">
  <nav class="sb-topnav navbar navbar-expand-xl navbar-dark bg-dark">
    <?php include('headerbar.php') ?>
  </nav>
  <div id="layoutSidenav">
    <div id="layoutSidenav_nav">
      <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <?php
        include_once('leftbar.php');
        ?>
      </nav>
    </div>
  </div>
  <br>
  <div class="col-9 mt-5" style="margin-left:25rem; ">
    <br>
    <center>
      <p style="font-family: 'Mali', cursive; font-size: 30px;">เพิ่มข้อมูลผู้ใช้</p>
    </center>
    <div class="row">
      <div class="col-6">
      </div>
      <div class="col-6 d-flex justify-content-end">
      </div>
    </div>

    <div class="rom mt-3">
      <div class="card">
        <div class="card-body">
          <!--This is some text within a card body.-->



          <main class="page-main">
            <div class="content-main">
              <div class="content-name">


                <form action="add_user.php" method="get" enctype="multipart/form-data" name="upload" id="upload">
                  <div class="main">

                    <div class="content">

                      <div class="col-mt-3">
                        <label for="inputfname" style="font-family: 'Mali', cursive; font-size: 18px;">ชื่อ</label>
                        <input type="text" class="form-control" id="firstname" name="firstname" style="margin-top: 0.5rem;font-family: 'Mali', cursive; font-size: 18px;">
                      </div>
                      <div class="col-mt-3">
                        <label for="inputlanme" style="margin-top: 1rem; font-family: 'Mali', cursive; font-size: 18px;">นามสกุล</label>
                        <input type="text" class="form-control" id="lastname" name="lastname" style="margin-top: 0.5rem; font-family: 'Mali', cursive; font-size: 18px;">
                      </div>
                      <!-- <div class="col-mt-3">
                            <label for="inputusername" style="margin-top: 1rem;">ชื่อผู้ใช้</label>
                            <input type="text" class="form-control" id="username" name="username" style="margin-top: 0.5rem;">
                          </div>
                          <div class="col-mt-3">
                            <label for="inputpassword" style="margin-top: 1rem;">รหัสผ่าน</label>
                            <input type="password" class="form-control" id="password" name="password" style="margin-top: 0.5rem;">
                          </div> -->
                      <div class="col-mt-3">
                        <label for="inputEmail" style="margin-top: 1rem; font-family: 'Mali', cursive; font-size: 18px;">อีเมล</label>
                        <input type="email" class="form-control" id="email" name="email" style="margin-top: 0.5rem; font-family: 'Mali', cursive; font-size: 18px;">
                      </div>

                      <center>
                        <br>
                        <button type="submit" class="btn btn-success" name="submit" value="update" style="font-family: 'Mali', cursive;">บันทึก</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="cancel" class="btn btn-danger" style="font-family: 'Mali', cursive; ">ยกเลิก</button>
                      </center>
                    </div>

                </form>
              </div>
            </div>
          </main>
        </div>

      </div>
    </div>

  </div>
  </div>





  <script src="filename.js"></script>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>

</body>

</html>