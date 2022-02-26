<?php
require '../../classes/connect.php';
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if (!$link) {
	echo "Error: Unable to connect to MySQL." . PHP_EOL;
	echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
	echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;

	exit;
}
if (!$link->set_charset("utf8")) {
	printf("Error loading character set utf8: %s\n", $link->error);
	exit();
}
$link->set_charset("utf8");

$id = $_GET['id'];

$sql = "SELECT * FROM fileupload2 where id = '$id'";
$result = $link->query($sql);
$response = array();
if ($result->num_rows > 0) {
	while ($rowdata = $result->fetch_assoc()) {
		ini_set("memory_limit", "1024M");
		$response[] = $rowdata;
	}
}
echo json_encode($response, \JSON_UNESCAPED_UNICODE);

//อ่านข้อมูลที่ส่งมาแล้วเก็บไว้ที่ตัวแปร data
$data = file_get_contents("php://input");

//แปลงข้อมูลที่อ่านได้ เป็น array แล้วเก็บไว้ที่ตัวแปร result
$result = json_decode($data, true, 512, \JSON_UNESCAPED_UNICODE);
