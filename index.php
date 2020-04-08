<?php


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

$subdomain = "artist";
$randomName = $subdomain.getRandomName(4,1);
$randomPass = getRandomName(7,2);
echo $randomPass; 
 

$output = shell_exec("sudo ./script.sh $subdomain $randomName $randomPass> /dev/null 2>&1 &");
echo "<pre>$output</pre>";
 