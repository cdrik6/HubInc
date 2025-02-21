FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y vsftpd \
 && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /vsftpd.conf 
COPY tools/init_ftp.sh /init_ftp.sh

ENTRYPOINT ["bash", "init_ftp.sh"]
# CMD ["tail", "-f", "/dev/null"]