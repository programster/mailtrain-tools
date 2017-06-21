<?php

require_once(__DIR__ . '/vendor/autoload.php');
require_once(__DIR__ . '/settings.php');

function main($subscriptionID)
{
    $username = DB_USER;
    $password = DB_PASSWORD;
    $hostname = DB_HOST;
    $dbName = DB_NAME;

    $tableName = 'subscription__' . $subscriptionID;

    $query = "SELECT * FROM `" . $tableName . "`";
    $db = new mysqli($hostname, $username, $password, $dbName);
    $result = $db->query($query);

    $filename = __DIR__ . '/list-' . $subscriptionID . '.csv';
    iRAP\CoreLibs\MysqliLib::convertResultToCsv($result, $filename, $outputHeaders=true);
}

if (!isset($argv[1]))
{
    die("ERROR - You need to provide the ID of the subscription list." . PHP_EOL);
}

$subscriptionID = $argv[1];
main($subscriptionID);
