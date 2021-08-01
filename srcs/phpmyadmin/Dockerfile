FROM	alpine:3.14
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add --no-cache nginx php7-fpm phpmyadmin supervisor
RUN		mkdir -p /run/nginx && chown -R nginx:nginx /run/nginx
RUN		mkdir -p /var/tmp/phpmyadmin && \
		chown -R nginx:nginx /var/tmp/phpmyadmin
RUN		sed -i 's/nobody/nginx/g' /etc/php7/php-fpm.d/www.conf

# copy configs
COPY	./localhost.conf /etc/nginx/http.d/default.conf
COPY	./config.inc.php /etc/phpmyadmin/config.inc.php
COPY	./supervisord.conf /etc/supervisord.conf

RUN		cp -r /usr/share/webapps/phpmyadmin/* /var/www/localhost/htdocs
RUN		chown -R nginx:nginx /var/www/localhost/htdocs

EXPOSE		5000
# can be done with php --server 0.0.0.0:5000 --docroot /var/www/localhost/htdocs
ENTRYPOINT	supervisord -c /etc/supervisord.conf
