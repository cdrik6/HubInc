#!/bin/bash

# echo '<meta http-equiv="refresh" content="0; url=https://villarson.com/" />' >> /static.html

mkdir -p /var/www/wordpress
echo "<h1>ici static website - Page Found</h1>" > /var/www/wordpress/index.html
echo "<h1>static website - Page Found</h1>" > /var/www/wordpress/static.html

# mv /static.html /var/www/wordpress/static.html

tail -f /dev/null
