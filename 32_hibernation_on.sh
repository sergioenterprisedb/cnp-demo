#!/bin/bash
. ./config.sh

# Doc
echo 32 > ./docs/docid

printf "${green}kubectl-cnpg hibernate on cluster-example${reset}\n"

kubectl-cnpg hibernate on cluster-example

