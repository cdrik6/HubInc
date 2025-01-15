FROM debian:bullseye

RUN apt update \
 && apt upgrade -y \
 && apt install nginx -y		

RUN mkdir -p /etc/nginx/ssl \
 && apt install openssl -y \
 && openssl req -x509 -nodes -days 365 -newkey rsa:4096 -sha256 \
	-keyout /etc/nginx/ssl/server.key \
	-out /etc/nginx/ssl/server.crt \
	-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=Inception/CN=caguillo.42.fr/UID=caguillo"
# Generate a self-signed certificat
# req = create the certif with type -x509 / nodes = no pwd for the key
# -out = the folder/file to save the certif
# -keyout = the folder/file to save the key	

RUN mkdir -p /var/run/nginx
# Creates the directory /var/run/nginx inside the container's filesystem.
# The -p option ensures that the command doesn't throw an error if the directory already exists
# 	and will create any parent directories if needed.
# /var/run/nginx is often used by NGINX to store runtime files, such as the process ID file (nginx.pid).
# If this directory doesn’t exist when NGINX starts, it may fail or log an error.

# COPY /etc/nginx/conf.d conf/temp
COPY conf/nginx.conf /etc/nginx/nginx.conf
# Copies my NGINX configuration file (nginx.conf)
# FROM conf/ (the directory on your local machine)
# TO /etc/nginx/nginx.conf (the container's standard configuration directory)
# NGINX uses /etc/nginx/nginx.conf as its main configuration file by default
# /etc/nginx/conf.d --> directory for site-specific files, included by nginx.conf
# /etc/nginx/nginx.conf --> main/global configuration file, affects the entire Nginx server

RUN chmod 755 /var/www/html \
 && chown -R www-data:www-data /var/www/html
# chmod ensures that:
# - Files in /var/www/html are readable by everyone (necessary for a public web server).
# - Only the owner (www-data) has write permissions for security.
# chown ensures that:
# - the web server (running as www-data) has proper access to read/write files it needs to serve.
# (www-data owner of all files in /var/www/html)
# These commands are foundational for setting up a secure and functional web server
# environment in a containerized setup.

# EXPOSE 443 ?????????

CMD ["nginx", "-g", "daemon off;"] 
# ENTRYPOINT --> can NOT amend the command with docker run
# CMD --> can amend the command in the run option

# CMD ["cat", "conf/temp"]
# CMD ["cat", "/etc/nginx/nginx.conf"]
