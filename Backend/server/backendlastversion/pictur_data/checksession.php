<?php
// include("../../Database/server.php");
// require __DIR__ . '../../Database/server.php';

// $db_connection = new Data();
// $cont = $db_connection->dbConnect();

session_start();
if($_SESSION['user_status'] == "")    {
    // echo "Please Login!";
    Header("Location: ../login/admin_login.php");
    exit();
}
if($_SESSION['user_status'] != "AD"){
    echo "This page for Admin only!";
    exit();
}

?>
