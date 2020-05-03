#!/bin/bash


action=$1

site=$2
subdomain=$3

mysqlPass="SqlAdmin12345"

echo "\n Removing Sub Domain...."
rm -rf /home/forge/$subdomain.$site


echo "\n Removing Nginx Available Configurations...."
rm /etc/nginx/sites-available/$subdomain.$site

echo "\n Removing Nginx Enabled Configurations...."
rm /etc/nginx/sites-enabled/$subdomain.$site


