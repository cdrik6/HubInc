#!/bin/bash

# service mariadb start

# until mysqladmin ping -h localhost --silent; do
#     echo "MariaDB is initializing..."
#     sleep 1
# done

# mysql -u root << EOF
# CREATE DATABASE IF NOT EXISTS ${DB_NAME};
# CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PWD}';
# GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
# FLUSH PRIVILEGES;
# EOF

# mysql -u root << EOF
# SHOW DATABASES;
# SELECT user, host FROM mysql.user;
# SELECT user, host, authentication_string, plugin FROM mysql.user;
# SHOW GRANTS FOR '${DB_USER}'@'%';
# EOF
 
# exec mariadb

# if db
# else
# mysql_init_db
mysqld < /init.sql
mysqld_safe