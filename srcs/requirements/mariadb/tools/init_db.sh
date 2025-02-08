#!/bin/bash

service mariadb start

# Wait for MariaDB to be ready
until mysqladmin ping -h localhost --silent; do
    echo "MariaDB is initializing..."
    sleep 1
done

# Check correct/regular names and pwds for mysql 
# 
# if [ -z "${SQL_DB_NAME}" ]; then
#   echo "Error: SQL_DB_NAME is not set."
#   exit 1
# fi
# 
# if [ -z "${SQL_USER}" ]; then
#   echo "Error: SQL_USER is not set."
#   exit 1
# fi
# 
# if [ -z "${SQL_USER_PWD}" ]; then
#   echo "Error: SQL_USER_PWD is not set."
#   exit 1
# fi
# 
# if [ -z "${MYSQL_ROOT_PASSWORD}" ]; then
#   echo "Error: MYSQL_ROOT_PASSWORD is not set."
#   exit 1
# fi

echo "1:"
# create the DB SQL_DB_NAME (define in .env)
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DB_NAME};"

echo "2:"
# create the user SQL_USER of the DB (define in .env)
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_USER_PWD}';"

echo "3:"
# give whole rigths the user SQL_USER of the DB (define in .env)
# % -> allows the user to connect from any host
# The GRANT OPTION privilege allows a user to pass on any privileges she has to other users
mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DB_NAME}.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_USER_PWD}';"

echo "4: socket?"
mysql -e "SHOW VARIABLES LIKE 'socket';"

echo "5: flush"
# update new parameters
mysql -e "FLUSH PRIVILEGES;"

echo "6: stop"
# first switch off
service mariadb stop

echo "7: mysqld_safe"
# then restart mysql in order it runs with new parameters
# mysqld_safe --user=mysql --port=3306 --bind-address=0.0.0.0 --socket='/run/mysqld/mysqld.sock' --datadir='/var/lib/mysql'
mysqld_safe

mysql -e "SHOW DATABASES;"