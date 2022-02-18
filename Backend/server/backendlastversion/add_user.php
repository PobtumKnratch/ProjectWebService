<?php

// require_once('/Database/save.php');

header("Access-Control-Allow-Origin: *");

header("Content-Type: application/json; charset=UTF-8");

header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");

header("Access-Control-Max-Age: 3600");

header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


// session_start();
//1. เชื่อมต่อ database: 
require __DIR__ . '/Database/server.php';  //ไฟล์เชื่อมต่อกับ database ที่เราได้สร้างไว้ก่อนหน้านี้
$db_connection = new Data_user();
$cont = $db_connection->dbConnect();



$link = mysqli_connect('localhost', 'root', '', 'nectecpro');

$requestMethod = $_SERVER["REQUEST_METHOD"];

$data = file_get_contents("php://input");
$result = json_decode($data, true);



$requestMethod == 'GET';

    $testId = filter_input(INPUT_GET, "info_id", FILTER_VALIDATE_INT);
    $testFname = filter_input(INPUT_GET, "firstname", FILTER_SANITIZE_STRING);
    $testLname = filter_input(INPUT_GET, "lastname", FILTER_SANITIZE_STRING);
    // $testUName = filter_input(INPUT_GET, "username", FILTER_SANITIZE_STRING);
    // $testPass = filter_input(INPUT_GET, "password", FILTER_SANITIZE_STRING);
    $testEmail = filter_input(INPUT_GET, "email", FILTER_SANITIZE_STRING);



    $insert  = "INSERT INTO user_info (info_id,firstname,lastname,email) VALUES (:id,:fnm,:lnm,:em) ";


    $stm = $cont->prepare($insert);
    $stm->bindParam(":id", $testId);
    $stm->bindParam(":fnm", $testFname);
    $stm->bindParam(":lnm", $testLname);
    // $stm->bindParam(":unm", $testUName);
    // $stm->bindParam(":pas", $testPass);
    $stm->bindParam(":em", $testEmail);
    
    

    
    try {
        $stm->execute();
    } catch (Exception $e) {
    }


    $result = mysqli_query($link, $insert);


    echo $result;

    if ($stm->rowCount()) {
        echo json_encode(['status' => 'ok', 'message' => 'Insert Data Complete']);
    } 
    else {
        echo json_encode(['status' => 'error', 'message' => 'Error']);
    }
    header("refresh: 0; url=tables.php");