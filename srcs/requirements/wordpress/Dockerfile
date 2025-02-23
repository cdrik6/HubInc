FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y wget php7.4 php7.4-fpm php7.4-mysql mariadb-client  
 
RUN wget https://wordpress.org/latest.tar.gz -P /var/www \
 && cd /var/www \
 && tar -xzf latest.tar.gz \
 && rm latest.tar.gz  \
 && chown -R www-data:www-data /var/www/wordpress
# && chown -R root:root /var/www/wordpress \
# ensures that all files and directories under /var/www/wordpress 
# are owned by the root user and group

# to get the CLI tool to configure wp with a script
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x wp-cli.phar \
 && mv wp-cli.phar /usr/local/bin/wp

COPY conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/init_wp.sh /init_wp.sh

EXPOSE 9000 
# 9000 is the default port for PHP-FPM

ENTRYPOINT  ["bash", "init_wp.sh"]
# for debbug: CMD ["tail", "-f", "/dev/null"]
