#!/bin/bash
. ./config.sh
printf "${green}kubectl get deploy -n cnpg-system cnpg-controller-manager${reset}\n"

kubectl get deploy -n cnpg-system cnpg-controller-manager -o wide

