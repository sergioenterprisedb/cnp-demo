#!/bin/bash

. ./config.sh

printf "${green}kubectl apply -f cluster-example-upgrade-13-to-14.yaml${reset}\n"

kubectl apply -f cluster-example-upgrade-13-to-14.yaml
