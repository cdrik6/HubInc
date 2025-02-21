FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y mariadb-server \
 && rm -rf /var/lib/apt/lists/*

# specific settings	
COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/init.sql /tmp/init.sql
COPY tools/init_db.sh /tmp/init_db.sh
# need to copy as the container know the root directory
# Docker containers are isolated environments and the file paths inside the container
# aren't the same as those the local system

RUN	mkdir -p /var/run/mysqld \
 && chown -R mysql:mysql /var/run/mysqld \
 && chown -R mysql:mysql /tmp
#&& chown -R mysql:mysql /etc/mysql	

EXPOSE 3306
# Expose port to the host

USER mysql

ENTRYPOINT ["bash", "/tmp/init_db.sh"]
# execute MariaDB initialization script
# for debbug: CMD ["tail", "-f", "/dev/null"]