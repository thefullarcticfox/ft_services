#!/bin/sh

# if not already installed
if [ ! -f /var/www/localhost/htdocs/index.php ]
then
	cp -r /srcs/wordpress/* /var/www/localhost/htdocs
	if ! $(wp core is-installed --path=/var/www/localhost/htdocs --allow-root)
	then
		# wp installation
		wp core install --url="http://192.168.117.242:5050/" \
		--title=ft_services --admin_user=admin --admin_password=admin42 \
		--admin_email=thefullarcticfox@users.noreply.github.com --skip-email \
		--path=/var/www/localhost/htdocs --allow-root
		# wp generate some random users
		wp user generate --count=14 \
		--path=/var/www/localhost/htdocs --allow-root
		# wp create non-admin users with password
		wp user create evaluator evaluator@21school.com \
		--role=contributor --user_pass=admin42 \
		--path=/var/www/localhost/htdocs --allow-root
		wp user create bocal bocal@21school.com \
		--role=author --user_pass=admin42 \
		--path=/var/www/localhost/htdocs --allow-root
		# set website theme
		wp theme install bappi --activate \
		--path=/var/www/localhost/htdocs --allow-root
	fi
	chown -R nginx:nginx /var/www/localhost/htdocs
fi

supervisord -c /etc/supervisord.conf
