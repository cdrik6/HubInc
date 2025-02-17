FROM debian:bullseye

RUN apt-get update \ 
 && apt-get install -y wget php php-mysql

# Adminer download and permissions
RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php \
 && chown -R www-data:www-data /var/www/html/adminer.php \
 && chmod 755 /var/www/html/adminer.php

RUN rm -rf /var/www/html/index.html \
 && mv /var/www/html/adminer.php /var/www/html/index.php

COPY ./tools/init_ad.sh /init_ad.sh

ENTRYPOINT  ["bash", "/init_ad.sh"]
# CMD ["php -S 0.0.0.0:80 -t /var/www/html"]
# CMD ["tail", "-f", "/dev/null"]