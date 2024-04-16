#!/bin/bash
. ./config.sh
printf "${green}echo \"select pg_switch_wal()\" | kubectl-cnpg psql cluster-example${reset}\n"
printf "${green}kubectl apply -f restore.yaml${reset}\n"

#kubectl exec -it cluster-example-2 -- psql -c "select pg_switch_wal();"
echo "select pg_switch_wal()" | kubectl-cnpg psql cluster-example
sleep 3
kubectl apply -f restore.yaml

