#!/bin/bash
. ./config.sh

# Doc
echo 03 > ./docs/docid

printf "${green}kubectl get deploy -n cnpg-system cnpg-controller-manager${reset}\n"

kubectl get deploy -n cnpg-system cnpg-controller-manager -o wide

