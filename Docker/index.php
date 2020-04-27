<?php
 
$subdomain = $_GET['subdomain'];
$username = base64_decode($_GET['username']);
$password = base64_decode($_GET['password']);
$email = base64_decode($_GET['email']);

$grupoPassword = hash('ripemd128', (crc32(crc32("S1L8SY8VxEx73R" . "$password"))));

// if($subdomain == null){

//     exit("Please provide a valid subdomain!");
    
// }

// if($username == null){

//     exit("Please provide a username!");
    
// }
// if($password == null){

//     exit("Password cannot be blank!");
    
// }

// if($email == null){

//     exit("Please provide a valid email address!");
    
// }

sleep(5);


$output = shell_exec("sudo ./script.sh $subdomain $username $password $grupoPassword $email> /dev/null 2>&1 &");



// sleep(10);

// header('Access-Control-Allow-Origin: *');
// header('Content-type: application/json');

// $result = array(

//     "whiteboard_url" => "http://${subdomain}whiteboard.${site}",
//     "nextcloud_url" => "http://${subdomain}cloud.${site}",
//     "jitsi_url" => "http://${subdomain}jitsi.${site}",
//     "chat_url" => "http://${subdomain}chat.${site}",
//     "email" => "$email",
//     "username" => "$username",
//     "password" => "$password"

// );

// echo json_encode($result);
