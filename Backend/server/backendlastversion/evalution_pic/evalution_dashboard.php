<?php

include_once('./checksession.php');
?>

<!DOCTYPE html>
<html lang="en">

<head>
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

<body class="sb-nav-fixed">
  
    <?php include('headerbar.php') ?>
 
  <div id="layoutSidenav">
    <?php
    include_once('leftbar.php');
    ?>
    <div id="layoutSidenav_content">
      <!-- <main> -->
      <div class="container-fluid px-4">

        <div class="col-9 mt-5" style="margin-left:20rem;">
          <div class="row">
            <div class="col-6">
              <h4 style="margin-top: 1rem; margin-left:2rem;" ;><i class="fas fa-user mx-3"></i>ข้อมูลการตรวจสอบรูปภาพ </h4>
            </div>
          </div>
          <div class="rom mt-3">

            <form method="post">
              <input type="submit" class="btn btn-outline-secondary btn-lg" name="but1" value="Food" />
              <input type="submit" class="btn btn-outline-secondary btn-lg" name="but2" value="Travel" style="margin-left: 1rem;" />
              <input type="submit" class="btn btn-outline-secondary btn-lg" name="but3" value="SignBoard" style="margin-left: 1rem;" />
              <input type="submit" class="btn btn-outline-secondary btn-lg" name="but4" value="Scenario" style="margin-left: 1rem;" />
            </form>

          </div>
          <div class="main-content mt-3">
            <div class="card-content">
              <?php
              //include_once('evalution_food.php'); 
              if (isset($_POST['but1'])) {
                echo include_once('evalution_food.php');
              }
              if (isset($_POST['but2'])) {
                echo include_once('evalution_travel.php');
              }
              if (isset($_POST['but3'])) {
                echo include_once('evalution_signboard.php');
              }
              if (isset($_POST['but4'])) {
                echo include_once('evalution_scenario.php');
              }
              ?>
            </div>
          </div>
        </div>

        <!-- </main> -->
      </div>


      <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
      <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
      <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>