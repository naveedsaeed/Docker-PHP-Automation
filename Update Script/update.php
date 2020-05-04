<?php

ini_set('display_startup_errors', 1);
ini_set('display_errors', 1);
error_reporting(-1); 

$site = "neom-erp.com";

$action = $_GET['action'];
$username = $_GET['username'];
$password = $_GET['password'];
$email = $_GET['email'];
$subdomain = $_GET['subdomain'];
$folder_path = "/home/forge/$subdomain.$site";


if(empty($action)){


    exit("Please provide a valid action!");
}

if($subdomain == null){

    exit("Please provide a valid subdomain!");
    
}
 


if (file_exists($folder_path))  
    {  
        $output = shell_exec("sudo ./update.sh $action $site $subdomain> /dev/null 2>&1 &");



        $url = 'http://172.104.229.227/Docker/update.php';
        
            $data = array (
                'action' => $action,
                'subdomain' => $subdomain,
                'username' => $username,
                'password' => $password,
                'email' => $email
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
    
    }

    else{

        exit("This site does not exist!");
    }

   