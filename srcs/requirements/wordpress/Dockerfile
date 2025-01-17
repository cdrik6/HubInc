FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install wget -y

RUN apt-get install -y php8.4 php-fpm php-mysql mariadb-client
 
RUN wget https://wordpress.org/latest.tar.gz -P /var/www
 && cd /var/www
 && tar -xzvf latest.tar.gz
 && rm latest.tar.gz 
 &&	chown -R root:root /var/www/wordpress
# ensures that all files and directories under /var/www/wordpress 
# are owned by the root user and group

COPY conf/php.conf /etc/php/8.4/fpm/pool.d/www.conf

# to get the CLI tool to configure wp with a script
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
 && chmod +x wp-cli.phar
 && mv wp-cli.phar /usr/local/bin/wp

COPY tools/init_wp.sh /init_wp.sh 
ENTRYPOINT  ["bash", "init_wp.sh"]


# # Expose port to the host
# EXPOSE      3306