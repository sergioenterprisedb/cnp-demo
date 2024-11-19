#!/bin/bash
. ../config.sh
printf "${green}helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts${reset}\n"

printf "${green}helm repo add cnpg-grafana https://cloudnative-pg.github.io/grafana-dashboards${reset}\n"
# Install Prometheus repo
helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts

# Install Grafana repo
helm repo add cnpg-grafana https://cloudnative-pg.github.io/grafana-dashboards

