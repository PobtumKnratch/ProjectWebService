<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


require __DIR__ . '/classes/Database.php';

$db_connection = new Database();
$conn = $db_connection->dbConnection();

$data = json_decode(file_get_contents("php://input"));

if ($_SERVER['REQUEST_METHOD'] !== 'POST') :
    http_response_code(405);
    echo json_encode([
        'success' => 0,
        'message' => 'Invalid Request Method. HTTP method should be POST',
    ]);
    exit;
endif;

if (!isset($data->user_id) || !isset($data->namepicture) || !isset($data->tag) || !isset($data->image_description) || !isset($data->image) || !isset($data->date)) :

    echo json_encode([
        'success' => 0,
        'message' => 'Please fill all the fields | user_id, namepicture, tag , image_description , image , date.',
    ]);
    exit;

elseif (empty(trim($data->user_id)) || empty(trim($data->namepicture)) || empty(trim($data->tag)) || empty(trim($data->image_description)) || empty(trim($data->image)) || empty(trim($data->date))) :

    echo json_encode([
        'success' => 0,
        'message' => 'Oops! empty field detected. Please fill all the fields.',
    ]);
    exit;

endif;

try {
    // $user_id = $_POST['user_id'];
    // $image = $_FILES['image']['name'];
    // $name = $_POST['namepicture'];
    // $tag = $_POST['tag'];
    // $image_description = $_POST['image_description'];
    // $date = date('Y-m-d h:i:s');
    // $imagePath = "/Backend/server/Data/fileupload2/" . $image;
    // $base_filename = basename($_FILES["file"]["name"]);
    // $target_file = $imagePath . $base_filename;
    // if (!$_FILES["file"]["error"]) {
    //     if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
    //         $response->status = true;
    //         $response->message = "File uploaded successfully";
    //     } else {

    //         $response->status = false;
    //         $response->message = "File uploading failed";
    //     }
    // } else {
    //     $response->status = false;
    //     $response->message = "File uploading failed";
    // }

    // $namepicture = htmlspecialchars(trim($data->namepicture));
    // $tag = htmlspecialchars(trim($data->tag));
    // $image_description = htmlspecialchars(trim($data->image_description));

    $query = "INSERT INTO fileupload2(id, user_id, namepicture, image_description, image, date, tag) VALUES(:NUll,:user_id,:namepicture,:tag,:image_description,:image,:date)";

    $stmt = $conn->prepare($query);
    $stmt->bindParam(':user_id', $user_id);
    $stmt->bindParam(':namepicture', $namepicture);
    $stmt->bindParam(':tag', $tag);
    $stmt->bindParam(':image_description', $image_description);
    $stmt->bindParam(':image', $image);
    $stmt->bindParam(':date', $date);

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
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => 0,
        'message' => $e->getMessage()
    ]);
    exit;
}
