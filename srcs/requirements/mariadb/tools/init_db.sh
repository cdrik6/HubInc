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

# Secure the initial root access and remove default databases
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOF

# Create a new database and user, use env credentials
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${SQL_DB_NAME};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_USER_PWD}';
GRANT ALL PRIVILEGES ON ${SQL_DB_NAME}.* TO '${SQL_USER}' IDENTIFIED BY '${SQL_USER_PWD}';
FLUSH PRIVILEGES;
EOF

# Shutdown and restart with your specified configuration
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
mysqld_safe --user=mysql --port=3306 --bind-address=0.0.0.0  --socket='/run/mysqld/mysqld.sock' --datadir='/var/lib/mysql' --pid-file='/var/run/mysqld/mysqld.pid' --skip-networking=off --max_allowed_packet=64M #--log-error='/var/log/mysql/error.log'

echo "MariaDB is ready to use!"