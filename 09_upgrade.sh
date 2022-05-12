#!/bin/bash
. ./config.sh
printf "${green}kubectl apply -f cluster-example-upgrade.yaml${reset}\n"

kubectl apply -f cluster-example-upgrade.yaml
