<?php

ini_set('display_errors', 1);
error_reporting(~0);

require __DIR__ . '/Database/server.php';

$db_connection = new Data_user();
$cont = $db_connection->dbConnect();

// require_once('./Database/save.php');




	$sql = "DELETE FROM user_info
			WHERE info_id = ? ";

	$params = array($_GET["info_id"]);

	$stmt = $cont->prepare($sql);
	$stmt->execute($params);

	if( $stmt->rowCount() ) {
	 echo "Record delete successfully";
	}

	$cont = null;
    header('refresh:0;tables.php');
?>
