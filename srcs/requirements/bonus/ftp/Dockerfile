FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y vsftpd

COPY tools/init_ftp.sh /init_ftp.sh

ENTRYPOINT ["bash", "init_ftp.sh"]