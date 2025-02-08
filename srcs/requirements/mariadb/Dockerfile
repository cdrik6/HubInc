FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y mariadb-server
# apt-get more script vs apt more human 

COPY conf/my.cnf /etc/mysql/my.cnf
# specific settings


COPY tools/init_db.sh /init_db.sh
# need to copy as the container know the root directory
# Docker containers are isolated environments and the file paths inside the container
# aren't the same as those the local system

EXPOSE 3306
# Expose port to the host

ENTRYPOINT ["bash", "init_db.sh"]
# execute MariaDB initialization script
# for debbug: CMD ["tail", "-f", "/dev/null"]