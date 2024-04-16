#!/bin/bash
. ../config.sh
printf "${green}kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/grafana-configmap.yaml${reset}\n"

#kubectl apply -f \
#  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/grafana-configmap.yaml

# Monitoring documentation
# https://github.com/cloudnative-pg/cloudnative-pg/blob/main/docs/src/quickstart.md#part-4-monitor-clusters-with-prometheus-and-grafana

kubectl get configmaps

printf "${green}\n"
printf "Prometheus\n"
printf "Server: http://localhost:9090\n"
printf "\n"

printf "Grafana dashboard\n"
printf "Server: http://localhost:3000\n"
printf "User: admin\n"
printf "Password: prom-operator\n"
printf "${reset}\n"

printf "${green}\n"
printf "************\n"
printf "Warning: Import this Grafana dashboard in Grafana:\n"
printf "https://github.com/cloudnative-pg/grafana-dashboards/blob/main/charts/cluster/grafana-dashboard.json"
printf "\n"
printf "************\n"
printf "${reset}\n"
