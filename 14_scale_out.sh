#!/bin/bash
. ./config.sh
printf "${green}kubectl scale cluster cluster-example --replicas=4${reset}\n"

kubectl scale cluster cluster-example --replicas=4

