#!/bin/bash
. ../config.sh
printf "${green}kubectl port-forward svc/prometheus-community-kube-prometheus 9090${reset}\n"
printf "${green}kubectl port-forward svc/prometheus-community-grafana 3000:80${reset}\n"

# Prometheus port forwarding
kubectl port-forward svc/prometheus-community-kube-prometheus 9090 &

# Grafana port forwarding
kubectl port-forward svc/prometheus-community-grafana 3000:80 &
