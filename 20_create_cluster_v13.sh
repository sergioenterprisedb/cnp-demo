#!/bin/bash

. ./config.sh

printf "${green}kubectl apply -f cluster-example-13.yaml${reset}\n"

kubectl apply -f cluster-example-13.yaml
