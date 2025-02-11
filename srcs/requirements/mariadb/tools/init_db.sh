#!/bin/bash

# SQL does not understand shell variables like ${DB_NAME} 
# so need to search and replace in init.sql file with shell variables
sed -i "s|{{DB_NAME}}|$DB_NAME|g" /tmp/init.sql
sed -i "s|{{DB_USER}}|$DB_USER|g" /tmp/init.sql
sed -i "s|{{DB_USER_PWD}}|$DB_USER_PWD|g" /tmp/init.sql
sed -i "s|{{ROOT_PWD}}|$ROOT_PWD|g" /tmp/init.sql	
# -i = edit the file in place (modify /tmp/init.sql directly)
# g = all occurences changed
# {{...}} best practice and no space|
# ${DB_NAME} safer than $DB_NAME (case space or empty value)

if [ -d "/var/lib/mysql/$DB_NAME" ]; then
	echo "MariaDB already installed"
	mysqld_safe
else	
	mysqld --init-file="/tmp/init.sql" # start mysql server with init.sql a start
fi