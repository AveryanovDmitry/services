#!/bin/sh
minikube start --vm-driver=virtualbox --cpus=4 --memory=4G --disk-size=50G

eval $(minikube docker-env)
minikube addons enable metallb

docker build -t nginx_image srcs/nginx
docker build -t mysql_image srcs/mysql
docker build -t phpmyadmin_image srcs/phpmyadmin
docker build -t wordpress_image srcs/wordpress
docker build -t ftps_image srcs/ftps
docker build -t influxdb_image srcs/influxdb
docker build -t grafana_image srcs/grafana

kubectl apply -f ./srcs/yaml_files/configmap.yaml
kubectl apply -f ./srcs/yaml_files/nginx.yaml
kubectl apply -f ./srcs/yaml_files/mysql.yaml
kubectl apply -f ./srcs/yaml_files/phpmyadmin.yaml
kubectl apply -f ./srcs/yaml_files/wordpress.yaml
kubectl apply -f ./srcs/yaml_files/ftps.yaml
kubectl apply -f ./srcs/yaml_files/influxdb.yaml
kubectl apply -f ./srcs/yaml_files/grafana.yaml

