<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


function msg(
    $status,
    $message,
    $extra = []
) {
    return array_merge(
        [
            'status' => $status,
            'message' => $message
        ],
        $extra,
    );
}

require __DIR__ . '/classes/Database.php';
require __DIR__ . '/classes/JwtHandler.php';
require __DIR__ . '/classes/msg.php';

$db_connection = new Database();
$conn = $db_connection->dbConnection();

$data = json_decode(file_get_contents("php://input"));
//แปลงข้อมูลที่อ่านได้ เป็น array แล้วเก็บไว้ที่ตัวแปร result
// $query_stmt = json_decode($data, true, 512, \JSON_UNESCAPED_UNICODE);
$returnData = [];

// IF REQUEST METHOD IS NOT EQUAL TO POST
if ($_SERVER["REQUEST_METHOD"] != "POST") :
    $returnData = msg(0, 401, 'Bad Request');
    http_response_code(401);

// CHECKING EMPTY FIELDS
elseif (
    !isset($data->username)
    || !isset($data->password)
    || empty(trim($data->username))
    || empty(trim($data->password))
) :

    $fields = ['fields' => ['username', 'password']];
    $returnData = msg(401, 'Unprocessable Entity', $fields);
    http_response_code(401);

// IF THERE ARE NO EMPTY FIELDS THEN-
else :
    $username = trim($data->username);
    $password = trim($data->password);

    // CHECKING THE EMAIL FORMAT (IF INVALID FORMAT)
    // if(!filter_var($email, FILTER_VALIDATE_EMAIL)):
    //     $returnData = msg(0,422,'Invalid Email Address!');

    // IF PASSWORD IS LESS THAN 8 THE SHOW THE ERROR
    if (strlen($password) < 8) :
        $returnData = msg(401, 'Unprocessable Entity');
        http_response_code(401);

    // THE USER IS ABLE TO PERFORM THE LOGIN ACTION
    else :
        try {

            $fetch_user_by_username = "SELECT * FROM datausers WHERE `username`= :username";
            $query_stmt = $conn->prepare($fetch_user_by_username);
            $query_stmt->bindValue(':username', $username, PDO::PARAM_STR);
            $query_stmt->execute();

            // IF THE USER IS FOUNDED BY USERNAME
            if ($query_stmt->rowCount()) :
                $row = $query_stmt->fetch(PDO::FETCH_ASSOC);
                $check_password = password_verify($password, $row['password']);
                // return $fetch_user_by_user_email;
                // return $check_user_password;

                $update_previous_login = "UPDATE datausers SET previous_login = current_login WHERE `username`=:username";
                $update_sql = $conn->prepare($update_previous_login);
                $update_sql->bindValue(':username', $username, PDO::PARAM_STR);
                $update_sql->execute();

                $update_current_login = "UPDATE datausers SET current_login =" . time() . " WHERE `username`=:username";
                $update_sql = $conn->prepare($update_current_login);
                $update_sql->bindValue(':username', $username, PDO::PARAM_STR);
                $update_sql->execute();

                $update_token_login = "UPDATE datausers SET token = " . time() . " WHERE `username`=:username";
                $update_sql = $conn->prepare($update_token_login);
                $update_sql->bindValue(':username', $username, PDO::PARAM_STR);
                $update_sql->execute();

                // VERIFYING THE PASSWORD (IS CORRECT OR NOT?)
                // IF PASSWORD IS CORRECT THEN SEND THE LOGIN TOKEN
                if ($check_password) :

                    $jwt = new JwtHandler();
                    $token = $jwt->_jwt_encode_data(
                        'http://localhost/php_auth_api/',
                        array(
                            "user_id" => $row['user_id'],
                            'topic_id' => $row['topic_id'],
                            'username' => $row['username'],
                            'password' => $row['password'],
                            'firstname' => $row['firstname'],
                            'lastname' => $row['lastname'],
                            'email' => $row['email'],
                            'user_status' => $row['user_status'],
                            // 'token' => $row['token'],
                        ),
                        // while ($row = mysqli_fetch_assoc($check_password)) {
                        // $returnData[] = $row;
                        // }
                    );
                    // while ($row = mysqli_fetch_assoc($check_password)) {
                    //     $returnData[] = $row;
                    // }
                    // if ($fetch_user_by_username) {
                    //     while ($row = mysqli_fetch_assoc($query_stmt)) {
                    //         $returnData[] = $row;
                    //     }
                    // }
                    // echo json_encode($output);
                    $returnData = [
                        // 'status' => msg(200, 'login success'),
                        // // http_response_code(200),
                        'success' => 1,
                        'msg' => 'Login success',
                        'chk' => $row['user_status'],
                        'token' => $token,
                        'user_id' => $row['user_id'],
                        'topic_id' => $row['topic_id'],
                        'username' => $row['username'],
                        'password' => $row['password'],
                        'firstname' => $row['firstname'],
                        'lastname' => $row['lastname'],
                        'email' => $row['email'],
                        'user_status' => $row['user_status'],
                        // 'token' => $row['token'],


                    ];
                // $data = json_decode(file_get_contents("php://input"));
                // echo json_encode($data);
                //แปลงข้อมูลที่อ่านได้ เป็น array แล้วเก็บไว้ที่ตัวแปร result
                // $query_stmt = json_decode($data, true, 512, \JSON_UNESCAPED_UNICODE);
                // echo json_encode($returnData, \JSON_UNESCAPED_UNICODE);

                // IF INVALID PASSWORD
                else :
                    $returnData = msg(401, 'Invalid Password!');
                    http_response_code(401);
                endif;

            // IF THE USER IS NOT FOUNDED BY USERNAME THEN SHOW THE FOLLOWING ERROR
            else :
                $returnData = msg(401, 'Invalid Username Address!');
                http_response_code(401);
            endif;
        } catch (PDOException $e) {
            $returnData = msg(401, $e->getMessage());
            http_response_code(401);
        }

    endif;

endif;

echo json_encode($returnData, \JSON_UNESCAPED_UNICODE);
