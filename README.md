# ft_services
42 ft_services project - a kubernetes cluster containing:

- Nginx with ssh access (ports 22, 80, 433)
- FTPS (port 21)
- MySQL (port 3306/no external ip) used by Wordpress and phpMyAdmin
- Wordpress (port 5050)
- phpMyAdmin (port 5000)
- Influxdb (port 8086/no external ip) used by Telegraf and Grafana.
- Grafana (port 3000)
- Telegraf metrics collector daemonset (internal only)

All containers are building from scratch using Alpine Linux

### Running cluster
1. Install kubectl and minikube (also make sure virtualbox is installed)
2. Run ```./setup.sh```
