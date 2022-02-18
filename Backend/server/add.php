<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

function msg($success,$status,$message,$extra = []){
    return array_merge([
        'success' => $success,
        'status' => $status,
        'message' => $message
    ],$extra);
}

// INCLUDING DATABASE AND MAKING OBJECT
require __DIR__.'/classes/Database.php';
$db_connection = new Database();
$conn = $db_connection->dbConnection();

$val = isset($_POST["namepicture"]) && isset($_POST["tag"])
&& isset($_POST["description"]) ;

if($val){
//checking if there is POST data

$namepicture = $_POST["namepicture"]; //grabing the data from headers
$tag = $_POST["tag"];
$image_description = $_POST["image_description"];


//validation name if there is no error before
if($return["error"] == false && strlen($namepicture) < 3){
  $return["error"] = true;
  $return["message"] = "Enter name up to 3 characters.";
}

//add more validations here

//if there is no any error then ready for database write
if($return["error"] == false){
   $name = mysqli_real_escape_string($link, $namepicture);
   $address = mysqli_real_escape_string($link, $tag);
   $class = mysqli_real_escape_string($link, $image_description);
//    $rollno = mysqli_real_escape_string($link, $rollno);
   //escape inverted comma query conflict from string

   $sql = "INSERT INTO fileupload2 SET
                       namepicture = '$namepicture',
                       tag = '$tag',
                       image_description = '$image_description'";
   //student_id is with AUTO_INCREMENT, so its value will increase automatically

   $res = mysqli_query($link, $sql);
   if($res){
       //write success
   }else{
       $return["error"] = true;
       $return["message"] = "Database error";
   }
}
}else{
$return["error"] = true;
$return["message"] = 'Send all parameters.';
}

// mysqli_close($link); //close mysqli

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string
?>