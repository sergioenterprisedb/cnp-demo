#!/bin/bash
. ./config.sh

# Doc
echo 30 > ./docs/docid

printf "${green}kubectl-cnpg fencing on cluster-example cluster-example-3${reset}\n"

kubectl-cnpg fencing on cluster-example cluster-example-3

