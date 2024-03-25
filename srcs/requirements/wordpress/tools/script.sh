#!/bin/bash

mkdir -p /run/php

#replace every "/run/php/php7.4-fpm.sock" with "listen = 9000" in /etc/php/7.4/fpm/pool.d/www.conf file
sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = wordpress:9000#g' /etc/php/7.4/fpm/pool.d/www.conf

#download core files for wordpress (--allow-root is for running it as root)
wp core download --allow-root --path=/var/www/wordpress

mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php


#replace variables using .env file
sed -i -r "s/database_name_here/$DB_NAME/"   /var/www/wordpress/wp-config.php
sed -i -r "s/username_here/$DB_USER/"  /var/www/wordpress/wp-config.php
sed -i -r "s/password_here/$DB_PASS/"    /var/www/wordpress/wp-config.php
sed -i "s/localhost/mariadb:3306/" /var/www/wordpress/wp-config.php
# sed -i -r "s/auth_key_here/$AUTH_KEY/"    /var/www/wordpress/wp-config.php
# sed -i -r "s/secure_auth_key_here/$SECURE_AUTH_KEY/"    /var/www/wordpress/wp-config.php
# sed -i -r "s/logged_in_key_here/$LOGGED_IN_KEY/"    /var/www/wordpress/wp-config.php
# sed -i -r "s/nonce_key_here/$NONCE_KEY/"    /var/www/wordpress/wp-config.php
# sed -i -r "s/auth_salt_here/$AUTH_SALT/"    /var/www/wordpress/wp-config.php
# sed -i -r "s/secure_auth_salt_here/$SECURE_AUTH_SALT/"    /var/www/wordpress/wp-config.php
# sed -i -r "s/logged_in_salt_here/$LOGGED_IN_SALT/"    /var/www/wordpress/wp-config.php
# sed -i -r "s/nonce_salt_here/$NONCE_SALT/"    /var/www/wordpress/wp-config.php

#runs the default installation process for wordpress, creating tables in the database for the wordpress page
# wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --path=/var/www/wordpress --allow-root

# #create a user with the author role
# wp user create $WP_USER $WP_EMAIL --user_pass=$WP_PASS --allow-root --path=/var/www/wordpress --url=$DOMAIN_NAME

# #install the theme neve and activate it


wp core install --allow-root --url=$DOMAIN_NAME --title="I'm tired boss"  --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --path=/var/www/wordpress

wp user create --allow-root $WP_USER $WP_EMAIL --user_pass=$WP_PASS --path=/var/www/wordpress --url=$DOMAIN_NAME

#install redis-cache to store query results and save time when searching
#wp plugin install redis-cache --activate --allow-root

#update plugins
#wp plugin update --all --allow-root

#enable redis to create the cache file
#wp redis enable --allow-root

#runs php fpm (fastCGI process manager) in foreground mode
/usr/sbin/php-fpm7.4 -F