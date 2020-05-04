<?php
 
$subdomain = $_GET['subdomain'];
$username = base64_decode($_GET['username']);
$password = base64_decode($_GET['password']);
$email = base64_decode($_GET['email']);


// if($subdomain == '' || $username == '' || $password == '' || $email == ''){


//     header("Location: http://neom-community.com/welcome.php");
//     exit;
// }


$dbname = $_GET['db_name'];
$dbusername = $_GET['db_username'];
$dbpass = $_GET['db_pass'];

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






$output = shell_exec("sudo ./script.sh $subdomain $username $password $grupoPassword $email> /dev/null 2>&1 &");



// sleep(10);

header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

$result = array(
    
    "erp_url" => "http://${subdomain}.neom-erp.com",
    "whiteboard_url" => "http://${subdomain}whiteboard.neom-community.com",
    "nextcloud_url" => "http://${subdomain}cloud.neom-community.com",
    "jitsi_url" => "http://${subdomain}jitsi.neom-community.com",
    "chat_url" => "http://${subdomain}chat.neom-community.com",
    "email" => "$email",
    "username" => "$username",
    "password" => "$password",
    'db_name' => "$dbname",
    'db_username' => "$dbusername",
    'db_pass' => "$dbpass",
    "message" => "Script has been installed successfully!",

);

echo json_encode($result);
