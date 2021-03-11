FROM	alpine:3.12
WORKDIR	/srcs
RUN		apk update && apk upgrade
RUN		apk add influxdb

# copy configs
COPY	./influxdb.conf /etc/influxdb.conf
COPY	./entrypoint.sh ./

EXPOSE		8086
VOLUME		/var/lib/influxdb
ENTRYPOINT	sh ./entrypoint.sh
