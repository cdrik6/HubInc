#!/bin/bash

if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then  
    # back-up
    cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
    mv /vsftpd.conf /etc/vsftpd.conf

    # add FTP_USER in the userlist (skiping the prompts to get user details - gecos)
    adduser $FTP_USER --disabled-password --gecos ""
    echo "$FTP_USER:$FTP_PWD" | /usr/sbin/chpasswd # &> /dev/null  	
    echo "$FTP_USER" >> /etc/vsftpd.userlist    

    # FTP directory with FTP_USER as the owner of wordpress folders
    mkdir -p /var/www/wordpress
    # chown -R $FTP_USER:$FTP_USER /var/www/wordpress
    chown nobody:nogroup /var/www/wordpress
    chmod a-w /var/www/wordpress

    mkdir -p /var/www/web    
    chown nobody:nogroup /var/www/web
fi

if [ ! -f "/var/run/vsftpd/empty" ]; then 
    mkdir -p /var/run/vsftpd/empty
fi

/usr/sbin/vsftpd /etc/vsftpd.conf

# Note
# https://linux.developpez.com/vsftpd/
# https://olange.developpez.com/articles/debian/installation-serveur-dedie/?page=configuration-de-vsftpd-en-mode-utilisateur-virtuel

# If userlist_enable=YES is set in vsftpd.conf, only users in /etc/vsftpd.userlist can log in.
# If userlist_deny=NO is also set, only users listed in /etc/vsftpd.userlist are allowed.