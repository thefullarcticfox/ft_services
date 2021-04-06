# ft_services
42 ft_services project - a kubernetes cluster containing:

- Nginx server (ports 22, 80, 433) with:
  - access to this server's ssh at port 22
  - access to Wordpress website through redirect 307 at `/wordpress`
  - access to phpMyAdmin service through reverse proxy at `/phpmyadmin`
- FTPS server (port 21)
- MySQL database (port 3306/no external ip) used by Wordpress and phpMyAdmin
- Wordpress website (port 5050)
- phpMyAdmin service (port 5000)
- Influxdb database (port 8086/no external ip) used by Telegraf and Grafana.
- Grafana service (port 3000)
- Telegraf metrics collector daemonset (internal only)

All containers are building from scratch using Alpine Linux

## Running cluster
1. Install `kubectl` and `minikube` (also make sure virtualbox is installed)
2. Run `./setup.sh`

### Checking cluster
Open `192.168.117.242` in any browser and follow the instructions on the opened page to check other services

## Migrating to another minikube vm driver
1. Check `minikube ip` after running `minikube start --driver=[desired driver]`\
The ip address you get should be in the same `/24` CIDR subnet as your services\
So basically if `minikube ip` returned `a.b.c.d` you replace `192.168.117.242` with `a.b.c.242` everywhere
2. In `setup.sh` change driver and remove `--host-only-cidr` parameter
>`--host-only-cidr` is only for virtualbox driver

### If migration didn't work
1. check if something is blocking the ip or any port
2. check if the driver is limited by the OS (probably on macOS with docker driver so you better choose hyperkit or stay on virtualbox)
3. check some kind of documentation for minikube driver you chose or google the issue (somebody's probably had this kind of issue)
