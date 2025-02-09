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
	echo "0"
	wp config create --allow-root --dbname=$SQL_DB_NAME --dbuser=$SQL_USER --dbpass=$SQL_USER_PWD \
    				 --dbhost=mariadb --path='/var/www/wordpress'	
	echo "1"				 
	wp core install --url=$DOMAIN_NAME --title=$TITLE --admin_user=$ADMIN --admin_password=$ADMIN_PWD \
					--admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'	
	echo "2"				
	wp user create --allow-root --role=author $USER $USER_EMAIL --user_pass=$USER_PWD \
				   --path='/var/www/wordpress' #>> /log.txt
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
