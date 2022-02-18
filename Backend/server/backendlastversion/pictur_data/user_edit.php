<?php session_start();
require __DIR__ . "/Database/server.php";

$db_connection = new Data();
$cont = $db_connection->dbConnect();

?>

<html>

<head>
    <meta charset="UTF-8">
    <title>Beta Test Data</title>
</head>

<body>
    <?php

    $stmt = $cont->query("SELECT * FROM nametest ");
    foreach ($stmt as $row) {
        echo $row["id1"] . "  " . $row["name1"] . "  " . $row["tel1"];
        echo "<br>";
    }
    $queryRows = $cont->query("SELECT * FROM nametest ")->fetchAll();
    echo "Number of Rows : " . count($queryRows);
    ?>
    <form action="into.php" method="GET">
        <input type="text" name="id1" />
        <input type="text" name="name1" />
        <input type="text" name="tel1" />
        <input type="submit" value="Submit" naem="submit" />
    </form>



    <form action="add_upload.php" method="post" enctype="multipart/form-data" name="upfile" id="upfile">
        <input type="file" name="fileupload" id="fileupload" require="required" />
        <input type="submit" name="button" id="button" value="Upload" />

    </form>
</body>

</html>