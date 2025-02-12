#!/bin/bash

# # wait the database ready -- pb : check wp-config.php
# while ! wp db check --allow-root --path=/var/www/wordpress/; do
#     echo "Waiting for Database to be ready..."
#     sleep 1
# done

# ensure mariadb is running before continuing
sleep 10

# if [ -e /var/www/wordpress/wp-config.php ]; then
# 	echo "wp-config exits"
# else
# 	echo "wp-config don't"	
# fi

# if wp-config.php file does not exist
if [ ! -e /var/www/wordpress/wp-config.php ]; then
	echo "00"
	cd /var/www/wordpress
	echo "0"
	wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_USER_PWD" \
    				 --dbhost=mariadb:3306 --allow-root --path='/var/www/wordpress'	
	echo "1"				 
	wp core install --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$ADMIN" --admin_password="$ADMIN_PWD" \
					--admin_email="$ADMIN_EMAIL" --allow-root --path='/var/www/wordpress'	
	echo "2"				
	wp user create  "$USER" "$USER_EMAIL" --user_pass="$USER_PWD" --role=author \
				   	--allow-root --path='/var/www/wordpress'
	echo "3"			   
	# ensure any cached data is cleared to avoid conflicts
	wp cache flush --allow-root --path='/var/www/wordpress'
	echo "4"
fi

if [ -e /var/www/wordpress/wp-config.php ]; then
	echo "2 - wp-config exits"
else
	echo "2 - wp-config don't"	
fi

# if /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi

echo "5"

# launch php-fpm
/usr/sbin/php-fpm7.4 -F

echo "6"