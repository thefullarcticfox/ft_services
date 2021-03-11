#!/bin/sh

# if not already owned
if [ ! -f /var/lib/ftp/test ]
then
	echo "test" > /var/lib/ftp/test
	chown -R vsftp:ftp /var/lib/ftp
fi

# launch ftps server
vsftpd /etc/vsftpd/vsftpd.conf
