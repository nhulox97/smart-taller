<html>

<head>
    <title>phpinfo</title>
</head>

<body>
    <?php
    // Connection parameters
    $db_host = "your_host";
    $db_name = "your_db_name";
    $db_usr = "your_db_usr";
    $db_pass = "your_db_pass";
    $db_port = 5432;

    // Connection to db
    $conn_string = "host={$db_host} port={$db_port} 
    dbname={$db_name} user={$db_usr} password={$db_pass}";
    $conn = pg_connect($conn_string);

    if (!$conn) {
        echo "<h1>Ocurrió un error.</h1>";
        exit;
    }

    echo "<h1>Conexión exitosa</h1>";
    $result = pg_query($conn, "SELECT * FROM estado_registro");
    if (!$result) {
        echo "An error occurred.\n";
        exit;
    }

    while ($row = pg_fetch_row($result)) {
        echo "ID:$row[0] ESTADO:$row[1] DESC:$row[2] CORTO:$row[3]";
        echo "<br />\n";
    }
    ?>
</body>

</html>