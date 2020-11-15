<?php

    try{
        $connection = new PDO('mysql:host=localhost,dbname=id15005299_teverage_mobile,id15005299_seun,Solution2dworld.');
        $connection -> setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
        echo "yes connected";
    }
    catch(PDOException $exc){
        echo $exc -> getMessage();
        die('could not connect');
    }

?>