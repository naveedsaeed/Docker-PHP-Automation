#!/bin/bash


action=$1

site=$2
subdomain=$3



echo "\n Removing Docker Containers...."
docker rm ${subdomain}_chat -f
docker rm ${subdomain}_cloud -f
docker rm ${subdomain}_jitsi -f
docker rm ${subdomain}_whiteboard -f


echo "\n Removing Nginx Available Configurations...."

rm /etc/nginx/sites-available/${subdomain}chat.$site
rm /etc/nginx/sites-available/${subdomain}cloud.$site
rm /etc/nginx/sites-available/${subdomain}jitsi.$site
rm /etc/nginx/sites-available/${subdomain}whiteboard.$site


echo "\n Removing Nginx Enabled Configurations...."
rm /etc/nginx/sites-enabled/${subdomain}chat.$site
rm /etc/nginx/sites-enabled/${subdomain}cloud.$site
rm /etc/nginx/sites-enabled/${subdomain}jitsi.$site
rm /etc/nginx/sites-enabled/${subdomain}whiteboard.$site


