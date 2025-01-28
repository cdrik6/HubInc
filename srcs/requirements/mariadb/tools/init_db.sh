#!/bin/bash

# service mariadb start
service mariadb start

# Wait for MariaDB to be ready
until mysqladmin ping -h "localhost" --silent; do
    echo "MariaDB is initializing..."
    sleep 1
done

if [ -z "${SQL_DB_NAME}" ]; then
  echo "Error: SQL_DB_NAME is not set."
  exit 1
fi

# icici

# create the DB SQL_DB_NAME (define in .env)
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DB_NAME};"
echo "1"

# create the user SQL_USER of the DB (define in .env)
# 'localhost'
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_USER_PWD}';"
echo "2"

# give whole rigths the user SQL_USER of the DB (define in .env)
# % -> allows the user to connect from any host
mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DB_NAME}.* TO '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_USER_PWD}';"
echo "3"

# change/set the password for the MySQL root user (only when accessed from the local machine) --> more secure
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
echo "4"

# update new parameters
mysql -e "FLUSH PRIVILEGES;"
echo "5"

# first switch off mysql
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
echo "6"

# then restart mysql in order it runs with new parameters
mysqld_safe --user=mysql --port=3306 --bind-address=0.0.0.0 --socket='/run/mysqld/mysqld.sock' --datadir='/var/lib/mysql'

echo "init DB done!"