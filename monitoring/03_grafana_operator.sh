#!/bin/bash
. ../config.sh
printf "${green}kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/cnpg-prometheusrule.yaml${reset}\n"

# Install Grafana
helm upgrade \
  --install \
  cnpg-grafana-cluster cnpg-grafana/cluster

