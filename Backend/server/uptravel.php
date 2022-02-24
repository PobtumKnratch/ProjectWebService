<?php
require __DIR__ . '/classes/Database.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET ");
header("Access-Control-Allow-Headers: Authorization, Content-Type");

$db_connection = new Database();
$conn = $db_connection->dbConnection();

date_default_timezone_set('Asia/Bangkok');
$date = date("Ymd");
$numrand = (mt_rand());

if (isset($_POST)) {
    $destination_dir = "Data/fileupload2/";
    if (isset($_GET)) {
        $destination_dir = "Data/fileupload2/" . $_GET['file'] . "/";
    }
    try {
        $user_id = $_POST['user_id'];
        $name = $_POST['name'];
        $tag = $_POST['tag'];
        $description = $_POST['description'];
        $file_name = $_FILES['file']['name'];
        $file_size = $_FILES['file']['size'];
        $file_tmp = $_FILES['file']['tmp_name'];
        $file_type = $_FILES['file']['type'];
        $file_ext = strtolower(end(explode('.', $_FILES['file']['name'])));

        echo 'User_ID ==>' . $user_id;
        echo 'Name ==>' . $name;
        echo 'TAG' . $tag;
        echo 'description' . $description;


        $extensions = array("jpeg", "jpg", "png");

        if (in_array($file_ext, $extensions) === false) {
            $errors[] = "extension not allowed, please choose a JPEG or PNG file.";
        }

        if ($file_size > 2097152) {
            $errors[] = 'File size must be excately 2 MB';
        }

        if (empty($errors) == true) {
            move_uploaded_file($file_tmp, "Data/fileupload2/" . $file_name);
            echo "Success";
        } else {
            print_r($errors);
        }
        if (!isset($errorMsg)) {
            $stmt = $conn->prepare('INSERT INTO fileupload2 (user_id,name,description,image,tag) VALUE(:user_id,:fname,:description,:fimage,:tag) ');
            $stmt->bindParam(':user_id', $user_id);
            $stmt->bindParam(':fname', $name);
            $stmt->bindParam(':fimage', $newnametodb);
            $stmt->bindParam(':description', $description);
            $stmt->bindParam(':tag', $tag);
            if ($stmt->execute()) {
                $insertMsg = "File Uploaded Successfully...";
                // header('refresh:0;travel.php');
            }
        }
    } catch (PDOException $e) {
        $e->getMessage();
    }
} else echo "Welcome to connect Database";
