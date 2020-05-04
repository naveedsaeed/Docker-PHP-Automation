docker run -it -d -p 8200:9666 \
--name demo_whiteboard --entrypoint="/entrypoint.sh" mnaveed/public:whiteboard-v2 \
creativecamp.site 8200 mnaveed.dev@hotmail.com admin12345


docker exec demo_whiteboard bash -c "mongo --eval 'db.users.findOne({"nickname":"Administrator"})' spacedeck"

passSalt=$(bcrypt-cli "${password}" 10)
mongo --eval 'db.users.update({"nickname":"Administrator"},{$set:{"email":"'$username'","password_hash":"'$passSalt'"}});' spacedeck

mysql -u root --password="zScGCZHj" -e "INSERT into chat.gr_users( name, email, pass, mask, depict, role) select 'newUser', 'new@user.com', pass, mask, depict, role from chat.gr_users where id = 1;"
mysql -u root --password="zScGCZHj" -e "UPDATE chat.gr_users SET email = '$email' WHERE name='newUser';"
mysql -u root --password="zScGCZHj" -e "UPDATE chat.gr_users SET pass = '$pass' WHERE name='newUser';"
mysql -u root --password="zScGCZHj" -e "UPDATE chat.gr_users SET name = 'naveed' WHERE name='newUser';"

docker run -it -d -p 8400:80 \
--name demo_chat mnaveed/public:chat-v3