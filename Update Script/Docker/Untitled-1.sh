docker run -it -d -p 8200:9666 \
--name demo_whiteboard --entrypoint="/entrypoint.sh" mnaveed/public:whiteboard-v2 \
creativecamp.site 8200 mnaveed.dev@hotmail.com admin12345

ObjectId: 5e9c240bb60bb80056a68a31
"nickname" : "Administrator"



$2a$10$/.vtnpZvgER1UVuDTBImVu7sQkneyNatDVYvGc9Sjm5G9hwnAujUa = global
var user = db.users.findOne()
> user._id = new ObjectId()
ObjectId("5eafeb7dbb5c0b7b22afa30f")
> db.users.insert(user)
WriteResult({ "nInserted" : 1 })
passSalt=bcrypt-cli '${password}' 10
mongo --eval 'db.users.update({"nickname":"Administrator"},{$set:{"email":"'$username'","password_hash":"'$passSalt'"}});' spacedeck



docker exec demo_whiteboard bash -c "mongo --eval 'db.users.findOne({"nickname":"Administrator"})' spacedeck"

passSalt=$(bcrypt-cli "${password}" 10)
mongo --eval 'db.users.update({"nickname":"Administrator"},{$set:{"email":"'$username'","password_hash":"'$passSalt'"}});' spacedeck

mysql -u root --password="zScGCZHj" -e "INSERT into chat.gr_users( name, email, pass, mask, depict, role) select 'newUser', 'new@user.com', pass, mask, depict, role from chat.gr_users where id = 1;"
mysql -u root --password="zScGCZHj" -e "UPDATE chat.gr_users SET email = '$email' WHERE name='newUser';"
mysql -u root --password="zScGCZHj" -e "UPDATE chat.gr_users SET pass = '$pass' WHERE name='newUser';"
mysql -u root --password="zScGCZHj" -e "UPDATE chat.gr_users SET name = 'naveed' WHERE name='newUser';"

docker run -it -d -p 8400:80 \
--name demo_chat mnaveed/public:chat-v3



docker run -it -d -p 8200:80 \
-e MYSQL_HOST='127.0.0.1' \
-e MYSQL_DATABASE='nextcloud' \
-e MYSQL_USER='cloud' \
-e MYSQL_PASSWORD='zScGCZHj' \
-e NEXTCLOUD_ADMIN_USER="admin" \
-e NEXTCLOUD_ADMIN_PASSWORD="admin12345" \
-e NEXTCLOUD_TRUSTED_DOMAINS="creativecamp.site" \
--name demo_cloud mnaveed/public:nextcloud-v2

db.bios.findOne({$or: [{ '_id' : '' }}]})