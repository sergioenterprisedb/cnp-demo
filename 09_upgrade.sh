#!/bin/bash
. ./config.sh

# Doc
echo 09 > ./docs/docid

printf "${green}kubectl apply -f cluster-example-upgrade.yaml${reset}\n"

kubectl apply -f cluster-example-upgrade.yaml
