#!/bin/sh

# minikube delete minikube
kubectl delete deployment,svc nginx
kubectl delete -n metallb-system secret memberlist

kubectl delete deployment,svc mysql
kubectl delete pvc mysql-pv-claim
kubectl delete pv mysql-volume

kubectl delete deployment,svc wordpress
kubectl delete pvc wordpress-pv-claim
kubectl delete pv wordpress-volume

kubectl delete deployment,svc phpmyadmin
kubectl delete pvc phpmyadmin-pv-claim
kubectl delete pv phpmyadmin-volume

kubectl delete deployment,svc ftps
kubectl delete pvc ftps-pv-claim
kubectl delete pv ftps-volume

kubectl delete deployment,svc influxdb
kubectl delete pvc influxdb-pv-claim
kubectl delete pv influxdb-volume

kubectl delete deployment,svc grafana
kubectl delete pvc grafana-pv-claim
kubectl delete pv grafana-volume
