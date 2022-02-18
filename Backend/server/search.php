<?php
require '../server/classes/connect.php';

if (!$link) {
	echo "Error: Unable to connect to MySQL." . PHP_EOL;
	echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
	echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;

	exit;
}

$search = $_POST['name'];

$list = array();
$result = $conn->query("SELECT * FROM fileupload2 WHERE name Like'%".$search."%'");
if ($result) {
	while ($row = $result->fetch_assoc()) {
		$list[] = $row;
	}
	echo json_encode($list);
}
