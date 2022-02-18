<?php
session_start();
if (isset($_POST['username'])) {
    include_once('../Database/connect_database.php');
    // รับค่า User Password ก่อน
    $username = $_POST['username'];
    $password = $_POST['password'];
    // echo $username;
    // echo $password;

    // ทำการตรวจเช็ค UserPassword ใน Database เลย 
    $sql = "SELECT * FROM datausers WHERE username = '" . $username
        . "' AND password = '" . $password . "' ";

    $query = mysqli_query($conn, $sql);
    $result = mysqli_fetch_array($query, MYSQLI_ASSOC);
    
    if (!$result) {
        echo "<script alert('Login Faild!');</script>";
        header('Refresh:0 url=admin_login.php');
    } else {
        
        $_SESSION['userid'] = $result['userid'];
        $_SESSION['firstname'] = $result['firstname'];
        $_SESSION['user_status'] = $result['user_status'];
        $_SESSION['email'] = $result['email'];
        session_write_close();
    }
    // echo $result;
    if ($result["user_status"] == "US") {
        // echo "<script type='text/javascript'>alert('Login Faild!');</script>";
        header('location: ../index.php');
    } else {
        // echo "<script type='text/javascript'>alert('Login Faild!');</script>";
        header('location: ../index.php');

    }
}

