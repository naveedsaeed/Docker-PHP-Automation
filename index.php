<?php

$site = "creativecamp.site";

$subdomain = $_GET['subdomain'];
$folder_path = "/home/forge/$subdomain.$site";


$username = $_GET['username'];
$password = $_GET['password'];
$email = $_GET['email'];

//$grupoPassword = hash('ripemd128', (crc32(crc32("S1L8SY8VxEx73R" . "$password"))));

if($subdomain == null){

    exit("Please provide a valid subdomain!");
    
}

if (file_exists($folder_path))  
{ 
    exit("The domain '$subdomain.$site' already exist! Please choose another one.");
}

if($username == null){

    exit("Please provide a username!");
    
}
if($password == null){

    exit("Password cannot be blank!");
    
}

if($email == null){

    exit("Please provide a valid email address!");
    
}



function getRandomName($n,$type) {
    if($type == 1){

        $characters = 'abcdefghijklmnopqrstuvwxyz';
    }
    else{

        $characters = '!@#$%^&*+=123456789abcdefghijklmnopqrstuvwxyz';
    }
    
    $randomString = ''; 
  
    for ($i = 0; $i < $n; $i++) { 
        $index = rand(0, strlen($characters) - 1); 
        $randomString .= $characters[$index]; 
    } 
  
    return $randomString; 
} 


$randomName = $subdomain.getRandomName(4,1);
$randomPass = getRandomName(7,2);
 

$output = shell_exec("sudo ./script.sh $site $subdomain $randomName $randomPass> /dev/null 2>&1 &");

$curl = curl_init();

$query = http_build_query([
    'subdomain' => "'$subdomain'",
    'username' => "'$username'",
    'password' => "'$password'",
    'email' => "'$email'"
   ]);
   
$url = "http://neom-community.com/?".$query;

curl_setopt_array($curl, [
    CURLOPT_RETURNTRANSFER => 1,
    CURLOPT_URL => $url,
    CURLOPT_USERAGENT => 'Neom ERP Script'
]);

$resp = curl_exec($curl);
curl_close($curl);


sleep(10);



header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

$result = array(
    "erp_url" => "http://${subdomain}.${site}",
    "whiteboard_url" => "http://${subdomain}whiteboard.${site}",
    "nextcloud_url" => "http://${subdomain}cloud.${site}",
    "jitsi_url" => "http://${subdomain}jitsi.${site}",
    "chat_url" => "http://${subdomain}chat.${site}",
    "email" => "$email",
    "username" => "$username",
    "password" => "$password"

);

echo json_encode($result);