#!/bin/bash
service mariadb start

# Wait for MariaDB to be ready
until mysqladmin ping -h localhost --silent; do
    echo "MariaDB is initializing..."
    sleep 1
done

# Configaration file my.cnf
echo
cat etc/mysql/my.cnf

# Check correct/regular names and pwds for mysql
if [ -z "${DB_NAME}" ]; then
  echo "Error: DB_NAME is not set."
  exit 1
fi
if [ -z "${MYSQL_USER}" ]; then
  echo "Error: SQL_USER is not set."
  exit 1
fi
if [ -z "${MYSQL_USER_PWD}" ]; then
  echo "Error: SQL_USER_PWD is not set."
  exit 1
fi
echo "Names and Passwords: OK"

# socket ?
mysql -e "SHOW VARIABLES LIKE 'socket';"

# create the DB DB_NAME (define in .env)
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -e "SHOW DATABASES;"

# create the user MYSQL_USER of the DB (define in .env)
# % -> allows the user to connect from any host
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PWD}';"
mysql -e "SELECT user, host FROM mysql.user;"

# give whole rigths the user MYSQL_USER of the DB (define in .env)
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${MYSQL_USER}'@'%';"

# MySQL updates privileges automatically. 
# Flush privileges ensures that changes take effect immediately.
mysql -e "FLUSH PRIVILEGES;"
mysql -e "SELECT user, host, authentication_string, plugin FROM mysql.user;"
mysql -e "SHOW GRANTS FOR '${MYSQL_USER}'@'%';"

# status
mysqladmin status

# & = running in background
mysqld_safe &

# note:
# Service mariadb stop or mysqladmin shutdown before restart is unusefull
# In worst case, flush privileges does the job