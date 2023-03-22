#!/bin/bash
. ../config.sh
printf "${green}kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/grafana-configmap.yaml${reset}\n"

kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/grafana-configmap.yaml

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

