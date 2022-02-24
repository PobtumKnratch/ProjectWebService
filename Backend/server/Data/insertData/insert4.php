<?php
require '../../classes/connect.php';
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET ");
header("Access-Control-Allow-Headers: Authorization, Content-Type");
date_default_timezone_set('Asia/Bangkok');


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
if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
		$user_id = $_GET['user_id'];
		$name = $_GET['name'];
		$description = $_GET['description'];
		$tag = $_GET['tag'];
		$date = date('Y-m-d h:i:s');
		$image = $_GET['image'];
		$sql = "INSERT INTO `fileupload4`(`id`, `user_id`, `name`, `description`, `image`, `date`, `tag`) VALUES (Null,'$user_id','$name','$description','$image','$date','$tag')";
		$result = mysqli_query($link, $sql);
		if ($result) {
			echo "true";
		} else {
			echo "false";
		}
	} else echo "Welcome to connect Database";
}
mysqli_close($link);
