#!/bin/bash
. ../config.sh
printf "${green}kubectl port-forward svc/prometheus-community-kube-prometheus 9090${reset}\n"
printf "${green}kubectl port-forward svc/prometheus-community-grafana 3000:80${reset}\n"
printf "\n"

# Prometheus port forwarding
kubectl port-forward svc/prometheus-community-kube-prometheus 9090 &
pid1=$!
printf "${green}Prometheus pid: ${red}$pid1${reset}\n"

# Grafana port forwarding
kubectl port-forward svc/prometheus-community-grafana 3000:80 &
pid2=$!
printf "${green}Grafana pid: ${red}$pid2${reset}\n"
printf "\n"
printf "${green}/!\ You have 5 minutes to demo. Good luck /!\\ ${reset}\n"
printf "\n"
sleep 300
kill $pid1
kill $pid2
