<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require __DIR__ . '/classes/Database.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $returnData = msg(0, 401, 'Bad Request');
    http_response_code(401);
} elseif (
    !isset($data->username)
    || !isset($data->password)
    || empty(trim($data->username))
    || empty(trim($data->password))
) {
    $fields = ['fields' => ['username', 'password']];
    $returnData = msg(401, 'Unprocessable Entity', $fields);
    http_response_code(401);
} elseif (empty($username)) {
    $errorMsg[] = "Please enter username";
} elseif (strlen($password) < 8) {
    $errorMsg = msg(401, 'Unprocessable Entity');
    http_response_code(401);
} elseif (empty($password)) {
    $errorMsg[] = "Please enter password";
} else {
    try {
        $select_stmt = $conn->prepare("SELECT*FROM datausers WHERE username=:username OR password=:password");
        $select_stmt->execute(array(':username' => $username, ':password' => $password));
        $row = $select_stmt->fetch(PDO::FETCH_ASSOC);

        if ($select_stmt->rowCount() > 0) {
            if (password_verify($password, $row["password"])) {
                $_SERVER['REQUEST_METHOD'] = $row["user_id"];
                $update_previous_login = "UPDATE datausers SET previous_login = current_login WHERE `username`=:username";
                $update_sql = $conn->prepare($update_previous_login);
                $update_sql->bindValue(':username', $username, PDO::PARAM_STR);
                $update_sql->execute();

                $update_current_login = "UPDATE datausers SET current_login =" . time() . " WHERE `username`=:username";
                $update_sql = $conn->prepare($update_current_login);
                $update_sql->bindValue(':username', $username, PDO::PARAM_STR);
                $update_sql->execute();

                $update_token_login = "UPDATE datausers SET token = token WHERE `username`=:username";
                $update_sql = $conn->prepare($update_token_login);
                $update_sql->bindValue(':username', $username, PDO::PARAM_STR);
                $update_sql->execute();

                $returnData = [
                    'status' => msg(200, 'login success'),
                    // http_response_code(200),
                    'user_id' => $row['user_id'],
                    'topic_id' => $row['topic_id'],
                    'firstname' => $row['firstname'],
                    'lastname' => $row['lastname'],
                    'email' => $row['email'],
                    'user_status' => $row['user_status'],
                    'token' => $row['token'],
                ];
                echo json_encode($returnData);
            } else {
                $returnData = msg(401, 'Invalid Password!');
                http_response_code(401);
            }
        } else {
            $returnData = msg(401, 'Invalid Username Address!');
            http_response_code(401);
        }
    } catch (PDOException $e) {
        $e->getMessage();
    }
}
