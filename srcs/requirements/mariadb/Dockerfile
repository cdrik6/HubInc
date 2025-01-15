FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install mariadb-server -y
# apt-get more script vs apt more human 

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# CMD ["cat", "etc/mysql/mariadb.conf.d/50-server.cnf"]

COPY tools/init.sh /init.sh
# need to copy as the container know the root directory
# Docker containers are isolated environments and the file paths inside the container
# aren't the same as those the local system

ENTRYPOINT  ["bash", "init.sh"]
# execute MariaDB initialization script

# Expose port to the host
EXPOSE      3306