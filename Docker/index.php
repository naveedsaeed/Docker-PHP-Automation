<?php

$site="creativecamp.site";

$subdomain = $_GET['subdomain'];
$username = $_GET['username'];
$password = $_GET['password'];
$email = $_GET['email'];

if($subdomain == null){

    exit("Please provide a valid subdomain!");
    
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

sleep(5);


$output = shell_exec("sudo ./script.sh $subdomain $username $password $email> /dev/null 2>&1 &");



sleep(10);

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
echo "<td>Whiteboard</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Domain URL: http://${subdomain}whiteboard.${site}</td>";
echo "</tr>";
echo "<tr>";
echo "<td>NextCloud</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Domain URL: http://${subdomain}cloud.${site}</td>";
echo "</tr>";
echo "<tr>";
echo "<td>****************************************</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Username: $username</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Email: $email</td>";
echo "</tr>";
echo "<tr>";
echo "<td>Password: $password</td>";
echo "</tr>";
echo "<tr>";
echo "<td>****************************************</td>";
echo "</tr>";
echo "</table>";