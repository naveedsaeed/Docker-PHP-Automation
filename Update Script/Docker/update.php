<?php

ini_set('display_startup_errors', 1);
ini_set('display_errors', 1);
error_reporting(-1); 

$site = "neom-community.com";

$action = $_GET['action'];
$subdomain = $_GET['subdomain']; 
$username = base64_decode($_GET['username']);
$password = base64_decode($_GET['password']);
$email = base64_decode($_GET['email']);



$output = shell_exec("sudo ./update.sh $action $site $subdomain $username $password $email> /dev/null 2>&1 &");




header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

$result = array(
    
    
    "message" => "The site has been removed successfully!"

);

echo json_encode($result);