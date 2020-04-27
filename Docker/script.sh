#!/bin/bash

ipaddr="172.104.142.96"
LINODE_TOKEN="9fbb0118c8c58ce3d4c9b0d6432f2f9fce21e6e50c6cc9a09a1bf512bb32ae3e"
domain_id="1360312"

site="creativecamp.site"
subdomain=$1
username=$2
password=$3
grupoPassword=$4
email=$5

echo $username
echo $password


randomNameGen(){

 gpw 1 4

}

randomName=${subdomain}$(randomNameGen)

echo "\n Creating DNS Record for NextCloud...."

curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $LINODE_TOKEN" \
    -X POST -d '{
      "type": "A",
      "name": "'${subdomain}cloud'",
      "target": "'$ipaddr'"
    }' \
    https://api.linode.com/v4/domains/$domain_id/records



docker run -it -d -p 0:80 \
-e MYSQL_HOST='127.0.0.1' \
-e MYSQL_DATABASE='nextcloud' \
-e MYSQL_USER='cloud' \
-e MYSQL_PASSWORD='zScGCZHj' \
-e NEXTCLOUD_ADMIN_USER="$username" \
-e NEXTCLOUD_ADMIN_PASSWORD="$password" \
-e NEXTCLOUD_TRUSTED_DOMAINS="${subdomain}cloud.$site" \
--name ${subdomain}_cloud mnaveed/public:nextcloud-v1

nextcloud_port=$(docker inspect -f '{{ (index (index .NetworkSettings.Ports "80/tcp") 0).HostPort }}' ${subdomain}_cloud)

#sleep 5
echo "\n Creating Sub Domain and Nginx Configuration for NextCloud"
cat > /etc/nginx/sites-available/${subdomain}cloud.$site << EOF
server {
    server_name     ${subdomain}cloud.${site};
    location / {
        proxy_pass  http://localhost:${nextcloud_port};
    } 

}
EOF
 
sleep 5

echo "\n Creating DNS Record for Whiteboard...."

curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $LINODE_TOKEN" \
    -X POST -d '{
      "type": "A",
      "name": "'${subdomain}whiteboard'",
      "target": "'$ipaddr'"
    }' \
    https://api.linode.com/v4/domains/$domain_id/records

whiteboard_port=$(($nextcloud_port+1))

docker run -it -d -p ${whiteboard_port}:9666 \
--name ${subdomain}_whiteboard --entrypoint="/entrypoint.sh" mnaveed/public:whiteboard-v1 \
${site} ${whiteboard_port} ${email} ${password}


#sleep 5
echo "\n Creating Sub Domain and Nginx Configuration for Whiteboard"
cat > /etc/nginx/sites-available/${subdomain}whiteboard.$site << EOF
server {
    server_name     ${subdomain}whiteboard.${site};
    location / {
        proxy_pass  http://localhost:${whiteboard_port};
    } 

}
EOF

echo "\n Creating DNS Record for Jitsi...."

curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $LINODE_TOKEN" \
    -X POST -d '{
      "type": "A",
      "name": "'${subdomain}jitsi'",
      "target": "'$ipaddr'"
    }' \
    https://api.linode.com/v4/domains/$domain_id/records


jitsi_port=$(($whiteboard_port+1))

docker run -it -d -p ${jitsi_port}:443 \
--name ${subdomain}_jitsi --entrypoint="/entrypoint.sh" mnaveed/public:jitsi-v3


#sleep 5
echo "\n Creating Sub Domain and Nginx Configuration for Jitsi"
cat > /etc/nginx/sites-available/${subdomain}jitsi.$site << EOF
server {
    server_name     ${subdomain}jitsi.${site};
    location / {
        proxy_pass  https://localhost:${jitsi_port};
    } 

}
EOF

echo "\n Creating DNS Record for Chat...."

curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $LINODE_TOKEN" \
    -X POST -d '{
      "type": "A",
      "name": "'${subdomain}chat'",
      "target": "'$ipaddr'"
    }' \
    https://api.linode.com/v4/domains/$domain_id/records


grupo_port=$(($jitsi_port+1))

docker run -it -d -p ${grupo_port}:80 \
--name ${subdomain}_chat --entrypoint="/entrypoint.sh" mnaveed/public:chat-v2 \
${username} ${email} ${grupoPassword}


#sleep 5
echo "\n Creating Sub Domain and Nginx Configuration for Grupo"
cat > /etc/nginx/sites-available/${subdomain}chat.$site << EOF
server {
    server_name     ${subdomain}chat.${site};
    location / {
        proxy_pass  http://${site}:${grupo_port};
    } 

}
EOF



echo "Activating Sites..."
ln -s /etc/nginx/sites-available/${subdomain}cloud.$site /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/${subdomain}whiteboard.$site /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/${subdomain}jitsi.$site /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/${subdomain}chat.$site /etc/nginx/sites-enabled/


echo "Restarting Nginx Server..."
service nginx restart
