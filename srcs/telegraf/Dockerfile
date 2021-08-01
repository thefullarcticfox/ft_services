FROM	alpine:3.14
ARG		MINIKUBE_IP
WORKDIR	/srcs
RUN		apk update && apk upgrade

# installing packages from edge community alpine repos
RUN		apk add --no-cache telegraf \
		--repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

# ADD https://dl.influxdata.com/telegraf/releases/telegraf-1.16.1_static_linux_amd64.tar.gz ./
# RUN tar xf ./telegraf-1.16.1_static_linux_amd64.tar.gz
# RUN cp -r ./telegraf-1.16.1/* /

# copy config
COPY	./telegraf.conf /etc/telegraf.conf
RUN		sed -i "s/MINIKUBE_IP/$MINIKUBE_IP/g" /etc/telegraf.conf

VOLUME		/var/run/docker.sock
ENTRYPOINT	telegraf --config /etc/telegraf.conf
