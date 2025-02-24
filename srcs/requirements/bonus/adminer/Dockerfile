FROM debian:bullseye

RUN apt-get update \ 
 && apt-get install -y wget php php-mysql \
 && rm -rf /var/lib/apt/lists/*
# clean up cache to keep the image small

# Adminer download and permissions
RUN wget -q "http://www.adminer.org/latest.php" -O /var/www/html/index.php \
 && chown -R www-data:www-data /var/www/html \
 && chmod 755 /var/www/html/index.php

# EXPOSE 8080

ENTRYPOINT ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html/"]
# COPY tools/init_ad.sh /init_ad.sh
# ENTRYPOINT  ["bash", "/init_ad.sh"]
# CMD ["tail", "-f", "/dev/null"]