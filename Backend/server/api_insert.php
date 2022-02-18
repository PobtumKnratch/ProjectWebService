
<?php

require __DIR__ . '/Database/server.php';

$db_connection = new Database();
$conn = $db_connection->dbConnection();

date_default_timezone_set('Asia/Bangkok');
$date = date("Ymd");
$numrand = (mt_rand());

if ($_SERVER["REQUEST_METHOD"] != "POST") {
    $returnData = msg(0, 401, 'Bad Request');
    http_response_code(401);
    try {
        $name = $_POST['name'];
        $tag = $_POST['tag'];
        $description = $_POST['description'];
        $image = $_FILES['text_file']['name'];
        $type = $_FILES['text_file']['type'];
        $size = $_FILES['text_file']['size'];
        $temp = $_FILES['text_file']['tmp_name'];

        $snewname = $date . $numrand;

        $path = "/Backend/server/Data/fileupload2/" . $snewname . $img_file;
        $path2 = $snewname . $img_file;


        $Rename = $_FILES['text_file']['name'];
        $Rename = preg_replace('/\\.[^.\\s]{3,4}$/', '', $img_file);
        $ext = pathinfo($_FILES['text_file']['name'], PATHINFO_EXTENSION);

        $newname = "/Backend/server/Data/fileupload2/" . $snewname . "." . $ext;
        $newnametodb = $date . $numrand . "." . $ext;


        if (empty($namepicture)) {
            $errorMsg = "Please Enter name";
        } else if (empty($img_file)) {
            $errorMsg = "Please Select Image";
        } else if ($type == "image/jpg" || $type == 'image/jpeg' || $type == "image/png" || $type == "image/gif") {
            if (!file_exists($path)) {
                if ($size < 5000000) {
                    move_uploaded_file($temp,  $newname);
                } else {
                    $errorMsg = "Your file too large please upload";
                }
            } else {
                $errorMsg = "File already exists";
            }
        } else {
            $errorMsg = "Upload JPG,JPEG,PNG & GIF ";
        }

        if (!isset($errorMsg)) {
            $stmt = $conn->prepare('INSERT INTO fileupload2 (name,description,image,tag) VALUE(:name,:description,:image,:tag) ');
            $stmt->bindParam(':name', $name);
            $stmt->bindParam(':description', $description);
            $stmt->bindParam(':image', $newnametodb);
            $stmt->bindParam(':tag', $tag);
            if ($stmt->execute()) {
                $insertMsg = "File Uploaded Successfully...";
                // header('refresh:0;travel.php');
            }
        }
    } catch (PDOException $e) {
        $e->getMessage();
    }
}
?>
