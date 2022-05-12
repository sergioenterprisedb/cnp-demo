#!/bin/bash
. ./config.sh
printf "${green}kubectl apply -f restore.yaml${reset}\n"

kubectl apply -f restore.yaml

