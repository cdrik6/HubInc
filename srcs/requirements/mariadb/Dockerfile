FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y mariadb-server
# apt-get more script vs apt more human 

COPY conf/my.cnf /etc/mysql/my.cnf
# CMD ["cat", "etc/mysql/mariadb.conf.d/50-server.cnf"]

# RUN mkdir -p /var/run/mysqld /var/lib/mysql \
# && chown -R mysql:mysql /var/run/mysqld /var/lib/mysql \ 
# && chmod 777 /var/run/mysqld /var/lib/mysql 
## directories needed by mysql /run/mysqld

# RUN sudo chmod -R 755 /run/mysql/

# COPY tools/init_db.sh /init_db.sh
# need to copy as the container know the root directory
# Docker containers are isolated environments and the file paths inside the container
# aren't the same as those the local system

EXPOSE 3306
# Expose port to the host

CMD ["tail", "-f", "/dev/null"]

# ENTRYPOINT ["bash", "init_db.sh"]
# execute MariaDB initialization script

