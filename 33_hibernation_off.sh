#!/bin/bash
. ./config.sh

# Doc
echo 33 > ./docs/docid

printf "${green}kubectl-cnpg hibernate off cluster-example${reset}\n"

kubectl-cnpg hibernate off cluster-example

