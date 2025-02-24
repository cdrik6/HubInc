FROM debian:bullseye

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y gftp x11-apps \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
 && rm -rf /var/lib/apt/lists/*

#  RUN mkdir -p /var/www/wordpress \
#   && chown -R www-data:www-data /var/www/wordpress \
#   && chmod 777 -R /var/www/wordpress

ENV DISPLAY=:0 

ENTRYPOINT ["gftp"]
# CMD ["tail", "-f", "/dev/null"]
# ENTRYPOINT ["bash","init_gftp.sh"]

# 1. Build the Docker Image

# 2. Allow Docker to Access X11 (On the Host Machine):    
# xhost +local:docker (bash) -> Grants Docker access to your X session (host display)
# Run this command to allow X11 forwarding from Docker

# 3. Start the gFTP Docker Container:
# docker run -e DISPLAY=$DISPLAY \ -> Passes your host's display to the container
# -v /tmp/.X11-unix:/tmp/.X11-unix \ -> Shares the X11 socket (enables GUI display)
# --rm gftp-container -> Automatically removes the container after it exits

# COPY tools/init_gftp.sh /init_gftp.sh
# /root/.gftp/gftprc
# host_value=vsftpd
# port_value=21
# user_value=tata
