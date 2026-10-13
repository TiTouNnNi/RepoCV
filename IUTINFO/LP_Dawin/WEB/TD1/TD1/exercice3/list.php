<?php
$data = require('data.php');

function show($data)
{
    foreach ($data as $datas) {
        echo '* ' . $datas['first_name'] . ' ' . $datas['last_name'] . ' (' . $datas['age'] . ")\n";
    }
}

function minAge($data)
{
    $min = null;
    $i = 0;
    foreach ($data as $indice => $datas) {
        if ($min == null) {
            $min = $datas['age'];
            $i = $indice;
        }
        if ($datas['age'] < $min) {
            $min = $datas['age'];
            $i = $indice;
        }
    }
    echo '* ' . $data[$i]['first_name'] . ' ' . $data[$i]['last_name'] . ' (' . $data[$i]['age'] . ")\n";
}

function names($data){
    $tempTab = [];
    foreach ($data as $datas) {
        if(array_key_exists($datas['first_name'], $tempTab) === false){
            $tempTab[$datas['first_name']] = 1;
        }
        else{
            $tempTab[$datas['first_name']]++;
        }
    }
    foreach ($tempTab as $name => $number){
        echo 'Il y\'a '.$number.' personnes qui s\'appellent '.$name."\n";
    }
}