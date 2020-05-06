#!/bin/bash


action=$1

site=$2
subdomain=$3
erpuser=$4
erpmail=$5
erppass=$6

mysqlPass="SqlAdmin12345"


addUser(){

echo "Adding user in erp..."
mysql -u root --password="'$mysqlPass'" -e "INSERT into ${subdomain}.users( name, email, password, role, school_id ) select '$erpuser', '$erpmail', '$erppass', role, school_id from ${subdomain}.users where id = 1;"

}


removeSite(){

echo "\n Removing Sub Domain...."
rm -rf /home/forge/$subdomain.$site


echo "\n Removing Nginx Available Configurations...."
rm /etc/nginx/sites-available/$subdomain.$site

echo "\n Removing Nginx Enabled Configurations...."
rm /etc/nginx/sites-enabled/$subdomain.$site

echo "\n Removing Database..."
mysql -u root --password="'$mysqlPass'" -e "Drop database $subdomain;"


}

if [ "$action" = "removeSite" ]
then
	act=$(removeSite)
elif [ "$action" = "addUser" ]
then
	act=$(addUser)
else
	echo "Not a valid action!"
fi
