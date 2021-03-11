#!/bin/sh

# if not initialized
if [ ! -d /var/lib/influxdb/data ]
then
	chown -R influxdb:influxdb /var/lib/influxdb
fi

# run influxdb
influxd -config /etc/influxdb.conf
