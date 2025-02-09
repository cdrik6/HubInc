#!/bin/bash
service mariadb start

# Wait for MariaDB to be ready
until mysqladmin ping -h localhost --silent; do
    echo "MariaDB is initializing..."
    sleep 1
done

# # Configaration file my.cnf
# echo
# cat etc/mysql/my.cnf
# echo

# # Check correct/regular names and pwds for mysql
# if [ -z "${DB_NAME}" ]; then
#   echo "Error: DB_NAME is not set."
#   exit 1
# fi
# if [ -z "${DB_USER}" ]; then
#   echo "Error: SQL_USER is not set."
#   exit 1
# fi
# if [ -z "${DB_USER_PWD}" ]; then
#   echo "Error: SQL_USER_PWD is not set."
#   exit 1
# fi
# echo "Names and Passwords: OK"
# echo

# # socket ?
# mysql -e "SHOW VARIABLES LIKE 'socket';"
# echo

# create the DB DB_NAME (define in .env)
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -e "SHOW DATABASES;"
echo

# create the user MYSQL_USER of the DB (define in .env)
# % -> allows the user to connect from any host
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PWD}';"
mysql -e "SELECT user, host FROM mysql.user;"
echo

# give whole rigths the user MYSQL_USER on the DB (define in .env)
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
# MySQL updates privileges automatically. 
# Flush privileges ensures that changes take effect immediately.
mysql -e "FLUSH PRIVILEGES;"
mysql -e "SELECT user, host, authentication_string, plugin FROM mysql.user;"
echo
mysql -e "SHOW GRANTS FOR '${DB_USER}'@'%';"
echo

# # status
# mysqladmin status

# & = running in background
mysqld_safe # --datadir='/var/lib/mysql' # &

# note:
# Service mariadb stop or mysqladmin shutdown before restart is unusefull
# In worst case, flush privileges does the job