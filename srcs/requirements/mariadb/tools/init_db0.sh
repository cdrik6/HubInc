#!/bin/bash

# For debugging and test without Makefile delete mariadb in data each time, and mkdir mariadb

# service mariadb start
service mariadb start


# Wait for MariaDB to be ready
until mysqladmin ping -h "localhost" --silent; do
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

# chmod 755 /run/mysqld/mysqld.sock
# chown -R mysql:mysql /run/mysqld/mysqld.sock 
# chmod 755 /var/run/mysqld/mysqld.sock
# chown -R mysql:mysql /var/run/mysqld/mysqld.sock 

echo "1:"
# create the DB SQL_DB_NAME (define in .env)
mariadb -e "CREATE DATABASE IF NOT EXISTS ${SQL_DB_NAME};"

echo "2:"
# create the user SQL_USER of the DB (define in .env)
# 'localhost'
mariadb -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_USER_PWD}';"

echo "3:"
# give whole rigths the user SQL_USER of the DB (define in .env)
# % -> allows the user to connect from any host
mariadb -e "GRANT ALL PRIVILEGES ON ${SQL_DB_NAME}.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_USER_PWD}';"

echo "4:"
# change/set the password for the MySQL root user (only when accessed from the local machine) --> more secure
# mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

echo "5: flush"
# update new parameters
mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

echo "5b: socket?"
mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW VARIABLES LIKE 'socket';"

echo "6: shutdown"
# first switch off mysql
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" --user=root --socket='/run/mysqld/mysqld.sock' shutdown

# echo "6b: socket?"
# mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW VARIABLES LIKE 'socket';"

echo "7: mysqld_safe"
# then restart mysql in order it runs with new parameters
mysqld_safe --user=mysql --port=3306 --bind-address=0.0.0.0 --socket='/run/mysqld/mysqld.sock' --datadir='/var/lib/mysql'
# mysqld_safe
# systemctl start mariadb

# echo "7b: socket?"
# # mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW VARIABLES LIKE 'socket';"
# mysql -e "SHOW VARIABLES LIKE 'socket';"

echo "Init MariaDB done!"