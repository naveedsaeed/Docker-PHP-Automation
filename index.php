<?php

$site = "creativecamp.site";
$subdomain = $_GET['subdomain'];
$folder_path = "/home/forge/$subdomain.$site";

if($subdomain == null){

    exit("Please provide a valid subdomain!");
    
}

if (file_exists($folder_path))  
{ 
    exit("This Domain already exist! Please choose another one.");
} 

sleep(15);

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




echo "<table>";
echo "<tr>";
echo "<td>****************************************</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Script has been installed successfully!</td>";
echo "</tr>";
echo "<tr>";
echo "<td>****************************************</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Domain URL: http://${subdomain}.${site}</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Database Name: ${randomName}</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Database User: ${randomName}</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Database User Password: ${randomPass}</td>";
echo "</tr>";
echo "<tr>";
echo "<td>****************************************</td>";
echo "</tr>";
echo "</table>";