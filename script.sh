#bin/bash

ipaddr="172.104.227.87"
mysqlPass="SqlAdmin12345"
LINODE_TOKEN="9fbb0118c8c58ce3d4c9b0d6432f2f9fce21e6e50c6cc9a09a1bf512bb32ae3e"
domain_id="1357240"

echo "Installing Required Dependencies..."
apt install unzip gpw

site=$1
subdomain=$2
randomName=$3
randomPass=$4

#read -p "Enter subdomain name e.g(project or organization name):" subdomain

#while true; do
 #   read -p "The Domain will be hosted as: ${subdomain}.${site}. Do you wish to continue?" yn
  #  case $yn in
   #     [Yy]* ) break;;
    #    [Nn]* ) exit;;
     #   * ) echo "Please answer yes or no.";;
    #esac
#done

#DIR="/home/forge/${subdomain}.${site}"
#if [ -d "$DIR" ]; then
 # echo "Error: ${subdomain}.${site} already exist. Can not continue."
  #exit 1
#fi


echo "\n Creating DNS Record in Linode"

curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $LINODE_TOKEN" \
    -X POST -d '{
      "type": "A",
      "name": "'$subdomain'",
      "target": "'$ipaddr'"
    }' \
    https://api.linode.com/v4/domains/$domain_id/records

#sleep 5

echo "\n Cloning Neom Website Directory"

cp -R /home/forge/neom-erp.com/ /home/forge/$subdomain.$site/

#sleep 5
echo "\n Creating Sub Domain and Nginx Configuration"
uri='$uri'
cat > /etc/nginx/sites-available/$subdomain.$site << EOF
server {
        listen       80;
        server_name  $subdomain.$site;
        root   /home/forge/$subdomain.$site/;
        autoindex on;
        index index.php;

        location / {

            try_files $uri $uri/ /index.php;
        }

	      location = /favicon.ico { access_log off; log_not_found off; }
        location = /robots.txt  { access_log off; log_not_found off; }

        access_log off;
      	error_page 404 /index.php;

        location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
       }

        location ~ /\.(?!well-known).* {
           deny all;
        }

}
EOF

#sleep 5
echo "\n Enabling Sub Domain"
ln -s /etc/nginx/sites-available/$subdomain.$site /etc/nginx/sites-enabled/

#sleep 5
echo "\n Restarting Nginx"
sudo service nginx restart



#randomPassGen(){

 # openssl rand -base64 4

#}

#randomNameGen(){

 # gpw 1 4

#}

#randomPass=$(randomPassGen)
#randomName=${subdomain}$(randomNameGen)

#sleep 5
echo "Creating Database..."
mysql -u root --password="'$mysqlPass'" -e "CREATE DATABASE ${randomName}"
echo "Restoring Database..."
mysql -u root --password="'$mysqlPass'" $randomName < database.sql

#sleep 5
echo "Creating User and assigning to database..."
mysql -u root --password="'$mysqlPass'" -e "CREATE USER '${randomName}'@'%' IDENTIFIED BY '${randomPass}';"
mysql -u root --password="'$mysqlPass'" -e "USE ${randomName};"
mysql -u root --password="'$mysqlPass'" -e "GRANT ALL PRIVILEGES ON ${randomName}.* TO '${randomName}'@'%';"
mysql -u root --password="'$mysqlPass'" -e "FLUSH PRIVILEGES;"

echo "\n Restoring Database File"
rm /home/forge/$subdomain.$site/application/config/database.php
php='$php'
active_group='$active_group'
query_builder='$query_builder'
db='$db'
cat > /home/forge/$subdomain.$site/application/config/database.php << EOF
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;

$db['default'] = array(
	'dsn'	=> '',
	'hostname' => 'localhost',
	'username' => '${randomName}',
	'password' => '${randomPass}',
	'database' => '${randomName}',
	'dbdriver' => 'mysqli',
	'dbprefix' => '',
	'pconnect' => FALSE,
	'db_debug' => (ENVIRONMENT !== 'production'),
	'cache_on' => FALSE,
	'cachedir' => '',
	'char_set' => 'utf8',
	'dbcollat' => 'utf8_general_ci',
	'swap_pre' => '',
	'encrypt' => FALSE,
	'compress' => FALSE,
	'stricton' => FALSE,
	'failover' => array(),
	'save_queries' => TRUE
);
EOF

#sleep 5
#echo "\n ****************************************"
#echo "\n Script has been installed successfully!"
#echo "\n ****************************************"
#echo "\n Domain URL: http://${subdomain}.${site}"
#echo "\n Database Name: ${randomName}"
#echo "\n Database User: ${randomName}"
#echo "\n Database User Password: ${randomPass}"
#echo "\n ****************************************"
