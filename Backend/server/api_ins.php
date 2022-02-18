<?php

require '../server/classes/connect.php';
header("Access-Control-Allow-Origin: *");

date_default_timezone_set('Asia/Bangkok');
$date = date("Ymd");
$numrand = (mt_rand());

$user_id = $_POST['user_id'];
$image = $_FILES['image']['name'];
$namepicture = $_POST['namepicture'];
$tag = $_POST['tag'];
$image_description = $_POST['image_description'];
//   $producttype = $_POST['producttype'];

$imagePath = "/Backend/server/Data/fileupload2/" . $image;

move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);
$conn->query("INSERT INTO fileupload2 (id,user_id,namepicture, tag, image_description,image,date) VALUES ('" . null . "','" . $user_id . "','" . $namepicture . "','" . $tag . "','" . $image_description . "','" . $image . "','" . $date . "',)");
$connect->query("INSERT INTO fileupload2 (namepicture,image) VALUES ('" . $namepicture . "','" . $image . "')");
