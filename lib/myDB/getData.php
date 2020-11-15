<?php
    require('connection.php');

    $makeQuery = "SELECT * FROM register";

    $statement = $connection->prepare($makeQuery);

    $statement->execute();

    $myarray = array();

    while ($resultFrom = $statement ->fetch()){

        array_push(
            $myarray,array(
                "id"=>$resultFrom['id'],
                "name"=>$resultFrom['name'],
                "email"=>$resultFrom['email'],
                "pnumber"=>$resultFrom['pnumber'],
                "password"=>$resultFrom['password'],
            )
        );
    }

    echo json_encode($myarray);



?>