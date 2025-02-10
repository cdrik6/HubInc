#!/bin/bash
service mariadb start

# Wait for MariaDB to be ready
until mysqladmin ping -h localhost --silent; do
    echo "MariaDB is initializing..."
    sleep 1
done

mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PWD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

exec mariadb

# mysql -e "SHOW DATABASES;"
# mysql -e "SELECT user, host FROM mysql.user;"
# mysql -e "SELECT user, host, authentication_string, plugin FROM mysql.user;"
# mysql -e "SHOW GRANTS FOR '${DB_USER}'@'%';"

# # shutdown/stop in order to launche the safe mode need to stop before (avoid double process)
# mysqladmin shutdown
# --wait-for-all-slaves
# Defers shutdown until after all binlogged events have
# been sent to all connected slaves

# # & = running in background
# # mysqld_safe --datadir='/var/lib/mysql' &
# mysqld_safe

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

