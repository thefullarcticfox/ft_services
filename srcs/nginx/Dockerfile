FROM	alpine:3.12
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add --no-cache nginx vim openssl openssh supervisor
RUN		mkdir -p /run/nginx && chown -R nginx:nginx /run/nginx

# copy indexpage and configs
COPY	./index.html /var/www/localhost/htdocs
COPY	./localhost.conf /etc/nginx/conf.d/default.conf
COPY	./supervisord.conf /etc/supervisord.conf

# checking www-data: 82 is the standard uid/gid for "www-data" in Alpine
# RUN	addgroup -g 82 -S www-data; adduser -u 82 -D -S -G www-data www-data
# RUN	sed -i 's/user nginx;/user www-data;/g' /etc/nginx/nginx.conf
RUN		chown -R nginx:nginx /var/www/localhost/htdocs

# ssl cert/key generation
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/localhost.key \
		-out /etc/ssl/certs/localhost.crt \
		-subj "/C=RU/ST=Moscow/L=Moscow/O=42/OU=21/CN=nginx"

# ssh keys generation and config + user creation/password change
RUN		ssh-keygen -A
COPY	./sshd_config /etc/ssh/
RUN		adduser -D admin && \
		echo "admin:admin42" | chpasswd && echo "root:admin42" | chpasswd

EXPOSE		22 80 443
ENTRYPOINT	supervisord -c /etc/supervisord.conf
