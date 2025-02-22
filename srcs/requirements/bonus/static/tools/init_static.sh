#!/bin/bash

echo '<meta http-equiv="refresh" content="0; url=https://villarson.com/" />' >> /static.html

mkdir -p /var/www/web
mv /static.html /var/www/web/static.html