FROM	alpine:3.14
WORKDIR	/srcs
RUN		apk update && apk upgrade

# installing packages from edge community alpine repos
RUN		apk add --no-cache grafana \
		--repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

# copy configs
COPY	./datasource.yaml ./dashboards.yaml ./dashboards.yaml ./defaults.ini ./
COPY	./dashboards ./dashboards/
COPY	./entrypoint.sh ./

EXPOSE		3000
VOLUME		/var/lib/grafana
ENTRYPOINT	sh ./entrypoint.sh
