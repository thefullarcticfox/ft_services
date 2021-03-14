# ft_services
42 ft_services project - a kubernetes cluster containing:

- nginx with ssh access (ports 22, 80, 433)
- ftps (port 21)
- mysql (port 3306/no external ip)
- wordpress (port 5050)
- phpmyadmin (port 5000)
- influxdb (port 8086/no external ip)
- grafana (port 3000)
- telegraf metrics collector daemon (no port/internal only)

mysql used by wordpress and phpmyadmin.

influxdb used by telegraf and grafana.

All containers are building from scratch using alpine linux

### Running cluster
1. Install kubectl and minikube (also make sure virtualbox is installed)
2. Run ```./setup.sh```
