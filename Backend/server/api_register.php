<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

function msg($success, $status, $message, $extra = [])
{
    return array_merge([
        'success' => $success,
        'status' => $status,
        'message' => $message
    ], $extra);
}

// INCLUDING DATABASE AND MAKING OBJECT
require __DIR__ . '/classes/Database.php';
$db_connection = new Database();
$conn = $db_connection->dbConnection();

// GET DATA FORM REQUEST
$data = json_decode(file_get_contents("php://input"));
$returnData = [];

// IF REQUEST METHOD IS NOT POST
if ($_SERVER["REQUEST_METHOD"] != "POST") :
    $returnData = msg(0, 404, 'Page Not Found!');

// CHECKING EMPTY FIELDS
elseif (
    !isset($data->username)
    || !isset($data->password)
    || !isset($data->topic_id)
    || !isset($data->firstname)
    || !isset($data->lastname)
    || !isset($data->email)
    || !isset($data->user_status)
    || empty(trim($data->username))
    || empty(trim($data->password))
    || empty(trim($data->topic_id))
    || empty(trim($data->firstname))
    || empty(trim($data->lastname))
    || empty(trim($data->email))
    || empty(trim($data->user_status))

) :

    $fields = ['fields' => ['username', 'password', 'topic_id', 'firstname', 'lastname', 'email', 'user_status']];
    $returnData = msg(0, 422, 'Please Fill in all Required Fields!', $fields);

// IF THERE ARE NO EMPTY FIELDS THEN-
else :

    $username = trim($data->username);
    $password = trim($data->password);
    $topic_id = trim($data->topic_id);
    $firstname = trim($data->firstname);
    $lastname = trim($data->lastname);
    $email = trim($data->email);
    $user_status = trim($data->user_status);


    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) :
        $returnData = msg(0, 422, 'Invalid Email Address!');

    elseif (strlen($password) < 8) :
        $returnData = msg(0, 422, 'Your password must be at least 8 characters long!');

    elseif (strlen($username) < 3) :
        $returnData = msg(0, 422, 'Your username must be at least 3 characters long!');
        
    else :
        try {

            $check_username = "SELECT `username` FROM `datausers` WHERE `username`=':username'";
            $check_email_stmt = $conn->prepare($check_username);
            $check_email_stmt->bindValue(':username', $username, PDO::PARAM_STR);
            $check_email_stmt->execute();


            if ($check_email_stmt->rowCount()) :
                $returnData = msg(0, 422, 'This username already in use!');

            else :
                $insert_query = "INSERT INTO `datausers`(`username`,`password`,`topic_id`,`firstname`,`lastname`,`email`,`user_status`) VALUES(:username,:password,:topic_id,:firstname,:lastname,:email,:user_status)";

                $insert_stmt = $conn->prepare($insert_query);

                // DATA BINDING
                $insert_stmt->bindValue(':username', htmlspecialchars(strip_tags($username)), PDO::PARAM_STR);
                $insert_stmt->bindValue(':password', password_hash($passwords, PASSWORD_DEFAULT), PDO::PARAM_STR);
                $insert_stmt->bindValue('topic_id',  htmlspecialchars(strip_tags($topic_id)), PDO::PARAM_STR);
                $insert_stmt->bindValue('firstname',  htmlspecialchars(strip_tags($firstname)), PDO::PARAM_STR);
                $insert_stmt->bindValue('lastname',  htmlspecialchars(strip_tags($lastname)), PDO::PARAM_STR);
                $insert_stmt->bindValue(':email', $email, PDO::PARAM_STR);
                $insert_stmt->bindValue('user_status',  $user_status, PDO::PARAM_STR);

                $insert_stmt->execute();

                $returnData = msg(1, 201, 'You have successfully registered.');

            endif;
        } catch (PDOException $e) {
            $returnData = msg(0, 500, $e->getMessage());
        }
    endif;

endif;

echo json_encode($returnData);
