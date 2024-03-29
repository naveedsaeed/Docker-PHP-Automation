#!/bin/bash


action=$1

site=$2
subdomain=$3
username=$4
password=$5
grupoPassword=$6
email=$7

addUser(){

echo "Adding user in chat module..."
#docker exec ${subdomain}_chat bash -c "mysql -u root --password='zScGCZHj' -e \"INSERT into chat.gr_users( name, email, pass, mask, depict, role) select 'newUser', 'new@user.com', pass, mask, depict, role from chat.gr_users where id = 1;\"; exit;"
#docker exec ${subdomain}_chat bash -c "mysql -u root --password='zScGCZHj' -e \"UPDATE chat.gr_users SET email = '$email' WHERE name='newUser';\"; exit;"
#docker exec ${subdomain}_chat bash -c "mysql -u root --password='zScGCZHj' -e \"UPDATE chat.gr_users SET pass = '$grupoPassword' WHERE name='newUser';\"; exit;"
#docker exec ${subdomain}_chat bash -c "mysql -u root --password='zScGCZHj' -e \"UPDATE chat.gr_users SET name = '$username' WHERE name='newUser';\"; exit;"
docker exec ${subdomain}_chat bash -c "mysql -u root --password='zScGCZHj' -e \"INSERT into chat.gr_users( name, email, pass, mask, depict, role) select '$username', '$email', '$grupoPassword', mask, depict, role from chat.gr_users where id = 1;\"; exit;"


echo "Adding user in cloud module..."
docker exec ${subdomain}_cloud bash -c "export OC_PASS=$password; su -s /bin/sh www-data -c 'php occ user:add --password-from-env --group='users' $username'"
 
echo "Adding user in whiteboard module..."
whiteboardPass=$(bcrypt-cli "$password" 10)
docker exec ${subdomain}_whiteboard bash -c "mongo --eval 'var user = db.users.findOne(); user._id = new ObjectId(); user.nickname = "'"'$username'"'"; user.email = "'"'$email'"'"; user.password_hash = "'"'$whiteboardPass'"'"; db.users.insert(user)' spacedeck"

}

removeUser(){

echo "Removing user in chat module..."
docker exec ${subdomain}_chat bash -c "mysql -u root --password='zScGCZHj' -e \"DELETE from chat.gr_users WHERE email = '$email' AND name='$username';\"; exit;"
 
echo "Removing user in cloud module..."
docker exec ${subdomain}_cloud bash -c "export OC_PASS=$password; su -s /bin/sh www-data -c 'php occ user:add --password-from-env --group='users' $username'"
 
echo "Removing user in whiteboard module..." 
docker exec ${subdomain}_whiteboard bash -c "mongo --eval 'db.users.remove({'email': "'"'$email'"'"})' spacedeck"

}


removeSite(){

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

}


if [ "$action" = "removeSite" ]
then
	act=$(removeSite)
elif [ "$action" = "addUser" ]
then
	act=$(addUser)
elif [ "$action" = "removeUser" ]
then
	act=$(removeUser)
else
	echo "Not a valid action!"
fi






