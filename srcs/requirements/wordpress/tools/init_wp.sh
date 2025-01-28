#!/bin/bash

# # wait the database ready
# while ! wp db check --allow-root --path=/var/www/wordpress/; do
#     echo "Waiting for Database to be ready..."
#     sleep 1
# done

# ensure mariadb is running before continuing
sleep 10

if [ ! -e /var/www/wordpress/wp-config.php ]; then
    
	wp config create --allow-root --dbname=$SQL_DB_NAME --dbuser=$SQL_USER --dbpass=$SQL_USER_PWD \
    				 --dbhost=mariadb:3306 --path='/var/www/wordpress'
	
	sleep 10

	wp core install --url=$DOMAIN_NAME --title=$TITLE --admin_user=$ADMIN --admin_password=$ADMIN_PWD \
					--admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
	
	wp user create --allow-root --role=author $USER $USER_MAIL --user_pass=$USER_PWD \
				   --path='/var/www/wordpress' >> /log.txt
fi

# if /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir -p ./run/php
fi

# launch php-fpm
/usr/sbin/php-fpm7.3 -F
