service mysql start

# crée une table si elle n’existe pas déjà, du nom de la variable d’environnement SQL_DATABASE, indiqué dans le fichier .env qui sera envoyé par le docker-compose.yml.
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DB_NAME}\`;"

# crée l’utilisateur SQL_USER s’il n’existe pas, avec le mot de passe SQL_PASSWORD , toujours à indiquer dans le .env
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PWD}';"

# donne les droits à l’utilisateur SQL_USER avec le mot de passe SQL_PASSWORD pour la table SQL_DATABASE
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DB_NAME}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PWD}';"

# change les droits root avec le mot de passe root SQL_ROOT_PASSWORD
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# rafraichit la database
mysql -e "FLUSH PRIVILEGES;"

# redemarrer MySQL pour que tout soit effectif
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# lance la commande que MySQL recommande à son démarrage
exec mysqld_safe