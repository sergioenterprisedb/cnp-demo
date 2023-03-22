#!/bin/bash
. ../config.sh
printf "${green}helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts${reset}\n"

helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts

