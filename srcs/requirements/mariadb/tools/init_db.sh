#!/bin/bash
# service mariadb start
# # mysqld --user=mysql --datadir=/var/lib/mysql
echo "0"
# mysqld_safe --datadir='/var/lib/mysql' &
mysqld_safe &
echo "1"
# mysql -u root
# echo "2"

# Wait for MariaDB to be ready
until mysqladmin ping -h localhost --silent; do
    echo "MariaDB is initializing..."
    sleep 1
done

echo "3"
# # Configaration file my.cnf
# echo
# cat etc/mysql/my.cnf
# echo

# Check correct/regular names and pwds for mysql
if [ -z "${DB_NAME}" ]; then
  echo "Error: DB_NAME is not set."
  exit 1
fi
if [ -z "${DB_USER}" ]; then
  echo "Error: SQL_USER is not set."
  exit 1
fi
if [ -z "${DB_USER_PWD}" ]; then
  echo "Error: SQL_USER_PWD is not set."
  exit 1
fi
echo "Names and Passwords: OK"
echo

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

# # shutdown/stop in order to launche the safe mode need to stop before (avoid double process)
# mysqladmin shutdown
# --wait-for-all-slaves
# Defers shutdown until after all binlogged events have
# been sent to all connected slaves

# # & = running in background
# # mysqld_safe --datadir='/var/lib/mysql' &
# mysqld_safe
exec mariadb


# # status
# mysqladmin status

# # socket ?
# mysql -e "SHOW VARIABLES LIKE 'socket';"
# echo



# Note:
# Le shutdown n'est pas pour mettre a jour (flush privileges does the job) mais pour relancer mysql
# en safe sans double process
# les points :
# - il faut faire mysqld_safe
# - si on met mysqld_safe & + mysql au debut du script, a la fin du script mariadb exit
# - si on lance mysqld_safe sans faire un shutdown (mariadb start au debut), alors error : process already exit
# chown -R mysql:mysql /var/lib/mysql -->native: drwxr-xr-x 4 mysql mysql 4096 Feb  9 20:29 mysql

# A daemon is a background process that runs continuously, waiting for requests or performing tasks.
# In MariaDB, the daemon is mysqld, the main database server process.
# mysqld → The main MariaDB server process (the database engine).
# mysqld_safe → A wrapper script that monitors and restarts mysqld if it crashes.
# mysqladmin → A client tool to manage MariaDB, including stopping the daemon.

