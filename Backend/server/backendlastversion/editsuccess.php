<?php
session_start();
// if (!isset($_SESSION['id_admin'])) {
//     // header("location:../login_Admin.php");
// }

require __DIR__ . './Database/server.php';
$db_connection = new Data_user();
$cont = $db_connection->dbConnect();

if (isset($_POST['submit'])) {

    $sql = "UPDATE user_info SET 
    firstname = ? ,
    lastname = ? ,
    email = ?
    WHERE info_id = ? ";

    $params = array($_POST["txtfname"], $_POST["txtlname"], $_POST["txtEmail"],$_POST["info_id"]);

    $stmt = $cont->prepare($sql);
    $stmt->execute($params);


    try {
        $stmt->execute();
    } catch (Exception $e) {
    }

    if ($stmt->rowCount()) {
        echo "Record update successfully";
    }
}
$cont = null;
header("refresh: 0; url=tables.php");
