#!/bin/bash
. ./config.sh
printf "${green}kubectl-cnpg promote cluster-example cluster-example-2${reset}\n"

kubectl-cnpg promote cluster-example cluster-example-2
