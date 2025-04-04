#!/bin/bash
. ./config.sh

# Doc
echo 15 > ./docs/docid

printf "${green}kubectl scale cluster cluster-example --replicas=2${reset}\n"

kubectl scale cluster cluster-example --replicas=2

