<?php
error_reporting(E_ERROR | E_PARSE);

// Response object structure
$response = new stdClass;
$response->status = null;
$response->message = null;

// Uploading file
$imagePath = "/Backend/server/Data/fileupload2/";
$base_filename = basename($_FILES["file"]["name"]);
// $target_file = $imagePath . $base_filename;

if(!$_FILES["file"]["error"])
{
if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
$response->status = true;
$response->message = "File uploaded successfully";

} else {

$response->status = false;
$response->message = "File uploading failed";
}
}
else
{
$response->status = false;
$response->message = "File uploading failed";
}

header('Content-Type: application/json');
echo json_encode($response);
?>
<?php
// header("Access-Control-Allow-Origin: *");
// header("Access-Control-Allow-Headers: access");
// header("Access-Control-Allow-Methods: POST");
// header("Content-Type: application/json; charset=UTF-8");
// header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// require __DIR__ . '/classes/Database.php';
// require __DIR__ . '/classes/JwtHandler.php';
// require __DIR__ . '/classes/msg.php';

// $db_connection = new Database();
// $conn = $db_connection->dbConnection();

// date_default_timezone_set('Asia/Bangkok');
// $date = date("Ymd");
// $numrand = (mt_rand());

// $image = $_FILES['image']['name'];
// $namepicture = $_POST['namepicture'];
// $tag = $_POST['tag'];
// $image_description = $_POST['image_description'];


// $imagePath = "/Backend/server/Data/fileupload2/" . $image;
// $tmp_name = $_FILES['image']['temp'];

// move_uploaded_file($tmp_name, $imagePath);
// $insert = $conn->query("INSERT INTO fileupload2(namepicture,image_description,image,tag)VALUES('" . $namepicture . "','" . $image_description . "','" . $image . "','" . $tag . "')");

// if ($stmt->execute()) {
//     $insertMsg = "File Uploaded Successfully...";
//     // header('refresh:0;travel.php');
// }
?>