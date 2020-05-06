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

$grupoPassword = hash('ripemd128', (crc32(crc32("S1L8SY8VxEx73R" . "$password"))));

$output = shell_exec("sudo ./update.sh $action $site $subdomain $username $password $grupoPassword $email> /dev/null 2>&1 &");


if($action == 'removeSite'){


    header('Access-Control-Allow-Origin: *');
    header('Content-type: application/json');
    
    $result = array(
        
        "message" => "The site has been removed successfully!"
    
    );
    
    echo json_encode($result);

}
else if($action == 'addUser'){

    header('Access-Control-Allow-Origin: *');
    header('Content-type: application/json');
    
    $result = array(
        
        "username" => "$username",
        "password" => "$password",
        "email" => "$email",
        "message" => "The user has been added successfully!"
    
    );
    
    echo json_encode($result);

}

else if($action == 'removeUser'){

    header('Access-Control-Allow-Origin: *');
    header('Content-type: application/json');
    
    $result = array(
        
        "username" => "$username",
        "password" => "$password",
        "email" => "$email",
        "message" => "The user has been deleted successfully!"
    
    );
    
    echo json_encode($result);

}

else{

    header('Access-Control-Allow-Origin: *');
    header('Content-type: application/json');
    
    $result = array(
         
        "message" => "Please provide a valid action!"
    
    );
    
    echo json_encode($result);
 

}

