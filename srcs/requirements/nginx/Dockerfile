FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install nginx -y 

RUN mkdir -p /etc/nginx/ssl \
 && apt-get install openssl -y \
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

COPY conf/nginx.conf /etc/nginx/nginx.conf
# Copies my NGINX configuration file (nginx.conf)
# FROM conf/ (the directory on your local machine)
# TO /etc/nginx/nginx.conf (the container's standard configuration directory)
# NGINX uses /etc/nginx/nginx.conf as its main configuration file by default
# /etc/nginx/conf.d --> directory for site-specific files, included by nginx.conf
# /etc/nginx/nginx.conf --> main/global configuration file, affects the entire Nginx server

RUN mkdir -p /var/www/wordpress \
 && chown -R www-data:www-data /var/www/wordpress 
#  && chmod 777 -R /var/www/wordpress
# 755 sufficient if no ftp client but for bonus need the write permissions to manage files with gftp
 
# chmod ensures that:
# - Files in /var/www/wordpress are readable by everyone (necessary for a public web server).
# - Only the owner (www-data) has write permissions for security.
# chown ensures that:
# - the web server (running as www-data) has proper access to read/write files it needs to serve.
# (www-data owner of all files in /var/www/wordpress)
# These commands are foundational for setting up a secure and functional web server
# environment in a containerized setup.

COPY conf/default.conf /etc/nginx/sites-available/default.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

EXPOSE 443

CMD ["bash", "-c", "echo 'nginx configured' && nginx -g 'daemon off;'"]
# CMD ["nginx", "-g", "daemon off;"]
# -g is used to pass the daemon off; directive to Nginx
# In Docker, the container must have a single foreground process to keep it running.
# If the main process (in this case, Nginx) daemonizes and runs in the background,
# the container would exit immediately because Docker thinks the process has finished.
# Running Nginx in the foreground with daemon off; ensures that the container remains
# active as long as the Nginx process is running.

# Note
# ENTRYPOINT --> can NOT amend the command with docker run
# CMD --> can amend the command in the run option

# Draft
# CMD ["cat", "conf/temp"]
# CMD ["cat", "/etc/nginx/nginx.conf"]
