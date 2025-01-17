#!/bin/bash

service mysql start;

# create the DB SQL_DB_NAME (define in .env)
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DB_NAME}\`;"

# create the user SQL_USER of the DB (define in .env)
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_USER_PWD}';"

# give whole rigths the user SQL_USER of the DB (define in .env)
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DB_NAME}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_USER_PWD}';"

# change/set the password for the MySQL root user (only when accessed from the local machine) --> more secure
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PWD}';"

# update new parameters
mysql -e "FLUSH PRIVILEGES;"

# first switch off mysql
mysqladmin -u root -p$SQL_ROOT_PWD shutdown

# then restart mysql in order it runs with new parameters
exec mysqld_safe

# service mysql stop