#!/bin/bash

# ensure mariadb is running before continuing
# sleep 10

# # wait the database ready -- pb : check wp-config.php
# while ! wp db check --allow-root --path=/var/www/wordpress/; do
#     echo "Waiting for Database to be ready..."
#     sleep 1
# done

cd /var/www/wordpress

# if wp-config.php file does not exist
if [ -f /wp-config.php ]; then
	echo "Wordpress already installed"
else 
	wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_USER_PWD" \
    				 --dbhost=mariadb:3306 --dbprefix=wp_ --skip-check --allow-root --path='/var/www/wordpress'	
	wp core install --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$ADMIN" --admin_password="$ADMIN_PWD" \
					--admin_email="$ADMIN_EMAIL" --skip-email --allow-root --path='/var/www/wordpress'
	wp user create  "$USER" "$USER_EMAIL" --user_pass="$USER_PWD" --role=author \
				   	--allow-root --path='/var/www/wordpress'	
	# ensure any cached data is cleared to avoid conflicts
	wp cache flush --allow-root --path='/var/www/wordpress'	
fi
# -e = exists ? (file or directory)
# -f = file exists ?
# -d = directory exists ?

if [ ! -e /var/www/wordpress/wp-config.php ]; then
	echo "wp-config.php is missing"	
fi

# if /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi

# launch php-fpm
/usr/sbin/php-fpm7.4 -F