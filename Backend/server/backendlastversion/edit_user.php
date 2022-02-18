<?php
session_start();
if (!isset($_SESSION['id_admin'])) {
  // header('Refresh:0 url=../login_Admin.php');
}
require __DIR__ . '/Database/server.php';

$db_connection = new Data_user();
$cont = $db_connection->dbConnect();

$strCustomerID = null;
if (isset($_GET["info_id"])) {
  $strCustomerID = $_GET["info_id"];
}

$sql = "SELECT * FROM user_info WHERE info_id =?";
$params = array($strCustomerID);

$stmt = $cont->prepare($sql);
$stmt->execute($params);

$result = $stmt->fetch(PDO::FETCH_ASSOC);

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

</head>

<body class="sb-nav-fixed">
  <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <?php include('./headerbar.php') ?>
  </nav>
  <div id="layoutSidenav">
    <div id="layoutSidenav_nav">
      <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <?php
        include_once('./leftbar.php');
        ?>

      </nav>
    </div>

    <div class="col-9 mt-5" style="margin-left:25rem; ">
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


                  <form action="editsuccess.php?edit_form=<?php echo $result['info_id'] ?>" method="post" name="update">

                    <div class="main-content">
                      <div class="main">
                        <center>
                          <div class="drop-zone">
                            <span class="drop-zone__prompt"></span>
                            <label style="font-size: 30px; color: white;font-family: 'Mali', cursive; ">ข้อมูล</label>
                          </div>
                        </center>
                        <div class="content">

                          <div class="col">
                            <label for="exampleInputname"style="font-family: 'Mali', cursive;">ลำดับที่ :</label>
                            <td width="238"><input type="hidden" name="info_id" value="<?php echo $result["info_id"];  ?>" style="margin-top: 0.5rem;font-family: 'Mali', cursive; font-size: 18px;">
                              <?php echo $result["info_id"]; ?></td>
                          </div>
                          <div class="col">
                            <label for="exampleInputname" style="margin-top: 1rem;font-family: 'Mali', cursive; font-size: 18px;">ชื่อ</label>
                            <input type="text" class="form-control" name="txtfname" value="<?php echo $result["firstname"]; ?>" style="margin-top: 0.5rem;font-family: 'Mali', cursive; font-size: 18px;">
                          </div>
                          <div class="col">
                            <label for="exampleInputname" style="margin-top: 1rem;font-family: 'Mali', cursive; font-size: 18px;">นามสกุล</label>
                            <input type="text" class="form-control" name="txtlname" value="<?php echo $result["lastname"]; ?>" style="margin-top: 0.5rem;font-family: 'Mali', cursive; font-size: 18px;">
                          </div>


                          <div class="col">
                            <label for="exampleInputphonr" style="margin-top: 1rem;font-family: 'Mali', cursive; font-size: 18px;">อีเมล</label>
                            <input type="text" class="form-control" name="txtEmail" value="<?php echo $result["email"]; ?>" style="margin-top: 0.5rem;font-family: 'Mali', cursive; font-size: 18px;">
                          </div>



                          <center>
                            <br>
                            <!-- <input type="hidden" name="law_picture2" value="<?php echo $post_picture ?>"> -->
                            <button type="submit" class="btn btn-success" name="submit" value="update" style="font-family: 'Mali', cursive; ">บันทึก</button>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button type="cancel" class="btn btn-danger"style="font-family: 'Mali', cursive; ">ยกเลิก</button>
                          </center>
                        </div>
                      </div>
                  </form>
                </div>
              </div>
          </div>
          </main>


        </div>
      </div>
    </div>

  </div>


  <div class="row1">
    <div class="row" style="width: fit-content;">




      <script src="filename.js"></script>
      <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
</body>

</html>