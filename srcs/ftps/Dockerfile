FROM	alpine:3.14
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add --no-cache openssl vsftpd

# copy configs
COPY	./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY	./entrypoint.sh ./

# ssl cert/key generation
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/ftps.key \
		-out /etc/ssl/certs/ftps.crt \
		-subj "/C=RU/ST=Moscow/L=Moscow/O=42/OU=21/CN=ftp"

# password change
RUN		echo "vsftp:admin42" | chpasswd

EXPOSE		21 20021
VOLUME		/var/lib/ftp
ENTRYPOINT	sh ./entrypoint.sh
