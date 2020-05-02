docker run -it -d -p 8200:80 \
-e MYSQL_HOST='127.0.0.1' \
-e MYSQL_DATABASE='nextcloud' \
-e MYSQL_USER='cloud' \
-e MYSQL_PASSWORD='zScGCZHj' \
-e NEXTCLOUD_ADMIN_USER="admin" \
-e NEXTCLOUD_ADMIN_PASSWORD="admin12345" \
-e NEXTCLOUD_TRUSTED_DOMAINS="172.104.229.227" \
--name nextcloud-v1 nextcloud:v2


docker run -it -d -p 8200:80 \
--name nextcloud-v1 mnaveed/public:nextcloud-v1

mv /home/logo-site.png /var/www/html/core/img 
mv /home/neom-bkg.jpg /var/www/html/core/img
mv /home/neom-login.png /var/www/html/core/img

rm /var/www/html/core/css/guest.css
cp /home/guest.css /var/www/html/core/css

#body-login {

    background-image: url('/core/img/neom-bkg.jpg') !important;
    background-size: cover !important;
    float: left !important;
    margin-left: 6% !important;
    margin-top: 12% !important;

}

@media screen and (max-width: 768px) {
 #body-login {

    background-image: url('/core/img/neom-bkg.jpg') !important;
    background-size: cover !important;
    float: left !important;
    margin-left: 12% !important;
    margin-top: 30% !important;

}
}
 
#header .logo {
    background-image: url('/core/img/neom-login.png') !important;
    padding-bottom: 10% !important;
}

#theming-preview-logo #header .logo{
    background-image: url('/core/img/logo-site.png') !important;
}