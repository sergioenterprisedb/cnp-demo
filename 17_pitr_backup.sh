#!/bin/bash

. ./config.sh

echo 16 > ./docs/docid

printf "${green}kubectl delete -f backup.yaml${reset}\n"
kubectl delete -f backup.yaml
sleep 3
printf "${green}kubectl apply -f backup.yaml${reset}\n"
kubectl apply -f backup.yaml
