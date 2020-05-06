<?php

ini_set('display_startup_errors', 1);
ini_set('display_errors', 1);
error_reporting(-1); 

$site = "";

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

$erpuser = base64_decode($username);
$erppass = sha1(base64_decode($password));
$erpmail = base64_decode($email);

$output = shell_exec("sudo ./script.sh $site $subdomain $randomName $randomPass $erpuser $erppass $erpmail> /dev/null 2>&1 &");
 

$url = 'http://172.105.75.43';

    $data = array (
        'subdomain' => $subdomain,
        'username' => $username,
        'password' => $password,
        'email' => $email,
        'db_name' => $randomName,
        'db_username' => $randomName,
        'db_pass' => $randomPass
        );
        
    $params = '';
    foreach($data as $key=>$value)
                $params .= $key.'='.$value.'&';
         
        $params = trim($params, '&');

    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, $url.'?'.$params ); //Url together with parameters
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //Return data instead printing directly in Browser
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT , 7); //Timeout after 7 seconds
    curl_setopt($ch, CURLOPT_USERAGENT , "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1)");
    curl_setopt($ch, CURLOPT_HEADER, 0);
    
    $result = curl_exec($ch);

    if(curl_errno($ch))  //catch if curl error exists and show it
    echo 'Curl error: ' . curl_error($ch);
  else
    echo $result;

    curl_close($ch);

 
// header('Access-Control-Allow-Origin: *');
// header('Content-type: application/json');

// $result = array(
//     "erp_url" => "http://${subdomain}.${site}",
//     "whiteboard_url" => "http://${subdomain}whiteboard.${site}",
//     "nextcloud_url" => "http://${subdomain}cloud.${site}",
//     "jitsi_url" => "http://${subdomain}jitsi.${site}",
//     "chat_url" => "http://${subdomain}chat.${site}",
//     "email" => "$email",
//     "username" => "$username",
//     "password" => "$password"

// );

// echo json_encode($result);