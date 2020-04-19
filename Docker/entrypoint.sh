#!/bin/bash

echo "Starting mongodb"
mongod --fork --logpath /var/log/mongod.log

domain=$1
port=$2

username=$3
password=$4

echo $domain
echo $port

echo $username
echo $password


passSalt=$(bcrypt-cli "${password}" 10)

echo $passSalt

mongo --eval 'db.users.update({"nickname":"Administrator"},{$set:{"email":"'$username'","password_hash":"'$passSalt'"}});' spacedeck

echo "\n Creating configuration file..."

rm /usr/src/app/config/default.json
cat > /usr/src/app/config/default.json << EOF
{
  //"endpoint": "http://localhost:9000",
  "endpoint": "https://$domain:$port",
  "storage_region": "eu-central-1",

  //"storage_bucket": "sdeck-development",
  //"storage_cdn": "http://localhost:9123/sdeck-development",
  //"storage_endpoint": "http://storage:9000",

  "storage_bucket": "my_spacedeck_bucket",
  "storage_cdn": "/storage",
  "storage_local_path": "./storage",

  "redis_mock": true,
  "mongodb_host": "localhost",
  "redis_host": "localhost",

  "google_access" : "",
  "google_secret" : "",
  "admin_pass": "very_secret_admin_password",
  "phantom_api_secret": "very_secret_phantom_password"
}
EOF


(cd /usr/src/app && node app.js)