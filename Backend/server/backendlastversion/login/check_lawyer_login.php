<?php 
session_start(); 
if (isset($_POST['username'])) {
    include_once('../../Database/connect_database.php');
    // รับค่า User Password ก่อน
    $username = $_POST['username'];
    $password = $_POST['password'];

    // ทำการตรวจเช็ค UserPassword ใน Database เลย 
    $sql = "SELECT * FROM admin WHERE username = '" . $username . "' AND password = '" . $password . "' ";

    $result = mysqli_query($conn,$sql);

    if($result->num_rows > 0 && $_POST['submit'] ){ 
        //fetch_assoc() คือการดึงข้อมูลออกมา 
        $row = $result->fetch_assoc();
        $_SESSION['lawyer_id'] = $row['lawyer_id'];
        $_SESSION['lawyer_name'] = $row['lawyer_name'];
        $_SESSION['lawyer_email'] = $row['lawyer_email'];
        
        header('location: ../Dashboard/home.php');

    }else {
        echo "<script type='text/javascript'>alert('Login Faild!');</script>";
        header('Refresh:0 url=admin_login.php');
    }

}
?>

