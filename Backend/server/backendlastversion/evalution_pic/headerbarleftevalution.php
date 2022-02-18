<?php $name = basename($_SERVER['SCRIPT_FILENAME'], ".php"); ?>
<?php
// session_start();
// if (!isset($_SESSION['user_id'])) {
//   header('Refresh:0 url=login_Admin');
// }
// require_once('../../../Database/connect_database.php');
// ?>

<!-- Font Awe Some -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="../css/tem.css">
<link rel="stylesheet" href="../css/theme.css">
<link href="https://fonts.googleapis.com/css2?family=Kanit:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../node_modules/bootstrap/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<script src="https://kit.fontawesome.com/b99e675b6e.js"></script>

<!-- <nav class="navbar">
    <a class="navbar-brand mx-2" href="../home.php?id1=&act=add" style="color: white;margin-left: 1rem;">
        <img src="../picture/navvanurak_color.png" width="40" height="50" alt="logo" loading="lazy">Dashboard</a>
    <span class="navbar-text" style="color: white;">

    </span>
</nav> -->

<div class="row">
    <div class="col-3">
        <div class="wrapper">
            <div class="sidebar">
                <img src="../picture/navvanurak_color.png" style="margin-top: 2rem;margin-bottom: 2rem;margin-left: 4rem;" width="120" height="150" alt="logo" loading="lazy">
                <h2><?php //echo $_SESSION['firstname'] ?></h2>
                <ul>
                    <li><a href="../user/user_dashboard.php" style="font-size: 18px;"><i class="fas fa-user mx-2"></i>จัดการข้อมูลผู้ใช้</a></li>
                    <li><a href="../pictur_data/pic_dashboard.php" style="font-size: 18px;"><i class="far fa-file-image mx-2"></i> จัดการข้อมูลรูปภาพ</a></li>
                    <li><a href="evalution_dashboard.php" style="font-size: 18px;"><i class="fas fa-file-signature mx-2"></i>ประเมินรูปภาพ</a></li>
                    <li><a href="../logout.php" style="font-size: 18px;"><i class="fas fa-sign-out-alt mx-2"></i>ออกจากระบบ</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Script FontAwesome -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<!-- END MENU SIDEBAR-->