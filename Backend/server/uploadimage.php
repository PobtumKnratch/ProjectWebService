<?php
require '../server/classes/connect.php';
header("Access-Control-Allow-Origin: *");
date_default_timezone_set('Asia/Bangkok');

$return["error"] = false;
$return["msg"] = "";
//array to return

if (isset($_GET["image"])) {
    $user_id = $_GET['user_id'];
    $name = $_GET['name'];
    $description = $_GET['description'];
    $tag = $_GET['tag'];
    $date = date('Y-m-d h:i:s');
    $base64_string = $_GET["image"];
    $outputfile = "/Data/fileupload2/.$base64_string";
    //save as image.jpg in uploads/ folder

    $filehandler = fopen($outputfile, 'wb');
    //file open with "w" mode treat as text file
    //file open with "wb" mode treat as binary file

    fwrite($filehandler, base64_decode($base64_string));
    // we could add validation here with ensuring count($data)>1

    // clean up the file resource
    fclose($filehandler);
    $sql = "INSERT INTO `fileupload2`(`id`, `user_id`, `name`, `description`, `image`, `date`, `tag`) VALUES (Null,'$user_id','$namepicture','$image_description','$image','$date','$tag')";

    $result = mysqli_query($link, $sql);

    if ($result) {
        echo "true";
    } else {
        echo "false";
    }
} else {
    $return["error"] = true;
    $return["msg"] =  "No image is submited.";
}

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string