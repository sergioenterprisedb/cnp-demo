#!/bin/bash
. ./config.sh

# Doc
echo 08 > ./docs/docid

printf "${green}kubectl-cnpg promote cluster-example cluster-example-2${reset}\n"

kubectl-cnpg promote cluster-example cluster-example-2
