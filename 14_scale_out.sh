#!/bin/bash
. ./config.sh

# Doc
echo 14 > ./docs/docid

printf "${green}kubectl scale cluster cluster-example --replicas=4${reset}\n"

kubectl scale cluster cluster-example --replicas=4

