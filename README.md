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
2. Run `./setup.sh`

### Checking cluster
Open `192.168.117.242` in any browser
and follow instructions on page to check other services

### Migrating to another minikube vm driver
1. Check `minikube ip` after running `minikube start` with desired driver.
The ip address you get should be in the same `/24` CIDR subnet as your services.
So basically if `minikube ip` returned `a.b.c.d` you replace `192.168.117.242` with `a.b.c.242` everywhere
2. In `setup.sh` change driver and remove `--host-only-cidr` parameter (this parameter supported only by virtualbox driver)

> If migration didn't work:
> 1. check if something blocks this ip
> 2. check if the driver is limited by the OS (probably on macOS with docker driver)
> 3. check some kind of documentation for minikube driver you chose or google the issue (somebody's probably had this kind of issue)
