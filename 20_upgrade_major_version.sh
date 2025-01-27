#!/bin/bash

. ./config.sh

printf "${green}kubectl apply -f cluster-example-upgrade-16-to-17.yaml${reset}\n"

kubectl apply -f cluster-example-upgrade-16-to-17.yaml
