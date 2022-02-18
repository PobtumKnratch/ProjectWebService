<?php

require __DIR__ . '/classes/Database.php';
require __DIR__ . '/classes/JwtHandler.php';
require __DIR__ . '/classes/msg.php';

$db_connection = new Database();
$conn = $db_connection->dbConnection();

date_default_timezone_set('Asia/Bangkok');
$date = date("Ymd");
$numrand = (mt_rand());

$return["error"] = false;
$return["msg"] = "";
$return["success"] = false;
//array to return

if (isset($_FILES["image"])) {
    //directory to upload file
    $target_dir = "Backend/server/Data/fileupload2/"; //create folder files/ to save file
    $image = $_FILES["image"]["name"];
    $namepicture = $_POST['namepicture'];
    $tag = $_POST['tag'];
    $image_description = $_POST['image_description'];
    //name of file
    //$_FILES["file"]["size"] get the size of file
    //you can validate here extension and size to upload file.

    echo $namepicture;
    echo $image;
    echo $tag;

    $savefile = "$target_dir/$image";
    //complete path to save file

    if (move_uploaded_file($_FILES["image"]["tmp_name"], $savefile)) {
        $return["error"] = false;
        //upload successful
    } else {
        $return["error"] = true;
        $return["msg"] =  "Error during saving file.";
    }
} else {
    $return["error"] = true;
    $return["msg"] =  "No file is sublitted.";
}

$query = "INSERT INTO `fileupload2`(namepicture,tag,image_description,image) VALUES(:namepicture,:tag,:image_description,:image)";

$stmt = $conn->prepare($query);

$stmt->bindParam(':namepicture', $namepicture, PDO::PARAM_STR);
$stmt->bindParam(':tag', $tag, PDO::PARAM_STR);
$stmt->bindParam(':image_description', $image_description, PDO::PARAM_STR);

if ($stmt->execute()) {

    http_response_code(201);
    echo json_encode([
        'success' => 1,
        'message' => 'Data Inserted Successfully.'
    ]);
    exit;
}

echo json_encode([
    'success' => 0,
    'message' => 'Data not Inserted.'
]);
exit;

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string
