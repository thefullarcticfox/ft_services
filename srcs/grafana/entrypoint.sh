#!/bin/sh

# if not initialized
if [ ! -d /var/lib/grafana/data ]
then
	cp -r /usr/share/grafana/* /var/lib/grafana/
	cp /srcs/defaults.ini /var/lib/grafana/conf/
	cp /srcs/datasource.yaml /var/lib/grafana/conf/provisioning/datasources/
	cp /srcs/dashboards.yaml /var/lib/grafana/conf/provisioning/dashboards/
	cp /srcs/dashboards/*.json /var/lib/grafana/conf/provisioning/dashboards/
	chown -R grafana:grafana /var/lib/grafana
fi

# run grafana server
grafana-server -homepath /var/lib/grafana
