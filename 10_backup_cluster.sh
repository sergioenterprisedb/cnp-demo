#!/bin/bash
. ./config.sh
printf "${green}kubectl apply -f backup.yaml${reset}\n"

kubectl apply -f backup.yaml
