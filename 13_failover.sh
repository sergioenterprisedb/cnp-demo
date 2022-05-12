#!/bin/bash
. ./config.sh
printf "${green}kubectl delete pod cluster-example-2 --force${reset}\n"

kubectl delete pod cluster-example-2 --force
