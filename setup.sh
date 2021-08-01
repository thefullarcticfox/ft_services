#!/bin/sh

# starting kubernetes cluster
minikube start \
	--driver=docker --cpus=2 --memory='3072' --disk-size='17000mb' \
	--extra-config=kubelet.authentication-token-webhook=true
# --extra-config=kubelet.authentication-token-webhook=true is used to enable
# API bearer tokens to authenticate to the kubelet's HTTPS endpoint

# enabling addons
minikube addons enable default-storageclass
minikube addons enable storage-provisioner
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb

# configuring metallb layer 2 ip pool
kubectl apply -f ./srcs/metallb-config.yaml
# creating memberlist secret (a secretkey to encrypt the communication
# between speakers for the fast dead node detection)
kubectl create secret generic -n metallb-system memberlist \
	--from-literal=secretkey="$(openssl rand -base64 128)"

# get kubernetes host ip
export MINIKUBE_IP=$(minikube ip)
# building containers (eval $(minikube docker-env) works too)
eval $(minikube -p minikube docker-env)
# nginx container
printf "\n>>> Building nginx... "
docker build -t nginx ./srcs/nginx > /dev/null
echo "Done."
kubectl apply -f ./srcs/yaml-deploy/nginx-deploy.yaml
kubectl apply -f ./srcs/yaml-service/nginx-service.yaml
# mysql container
printf "\n>>> Building mysql... "
docker build -t mysql ./srcs/mysql > /dev/null
echo "Done."
kubectl apply -f ./srcs/yaml-storage/mysql-storage.yaml
kubectl apply -f ./srcs/yaml-deploy/mysql-deploy.yaml
kubectl apply -f ./srcs/yaml-service/mysql-service.yaml
# wordpress container
printf "\n>>> Building wordpress... "
docker build -t wordpress ./srcs/wordpress > /dev/null
echo "Done."
kubectl apply -f ./srcs/yaml-storage/wordpress-storage.yaml
kubectl apply -f ./srcs/yaml-deploy/wordpress-deploy.yaml
kubectl apply -f ./srcs/yaml-service/wordpress-service.yaml
# phpmyadmin container
printf "\n>>> Building phpmyadmin... "
docker build -t phpmyadmin ./srcs/phpmyadmin > /dev/null
echo "Done."
kubectl apply -f ./srcs/yaml-deploy/phpmyadmin-deploy.yaml
kubectl apply -f ./srcs/yaml-service/phpmyadmin-service.yaml
# ftps container
printf "\n>>> Building ftps... "
docker build -t ftps ./srcs/ftps > /dev/null
echo "Done."
kubectl apply -f ./srcs/yaml-storage/ftps-storage.yaml
kubectl apply -f ./srcs/yaml-deploy/ftps-deploy.yaml
kubectl apply -f ./srcs/yaml-service/ftps-service.yaml
# influxdb container
printf "\n>>> Building influxdb... "
docker build -t influxdb ./srcs/influxdb > /dev/null
echo "Done."
kubectl apply -f ./srcs/yaml-storage/influxdb-storage.yaml
kubectl apply -f ./srcs/yaml-deploy/influxdb-deploy.yaml
kubectl apply -f ./srcs/yaml-service/influxdb-service.yaml
# telegraf metrics collector container
printf "\n>>> Building telegraf metrics collector... "
docker build -t telegraf --build-arg MINIKUBE_IP=${MINIKUBE_IP} ./srcs/telegraf > /dev/null
echo "Done."
kubectl apply -f ./srcs/yaml-daemon/telegraf-roles.yaml
kubectl apply -f ./srcs/yaml-daemon/telegraf-rbac.yaml
kubectl apply -f ./srcs/yaml-daemon/telegraf-daemon.yaml
# grafana container
printf "\n>>> Building grafana... "
docker build -t grafana ./srcs/grafana > /dev/null
echo "Done."
kubectl apply -f ./srcs/yaml-storage/grafana-storage.yaml
kubectl apply -f ./srcs/yaml-deploy/grafana-deploy.yaml
kubectl apply -f ./srcs/yaml-service/grafana-service.yaml
