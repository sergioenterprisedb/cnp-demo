#!/bin/bash
. ./config.sh

printf "${green}echo \"select pg_switch_wal()\" | kubectl-cnpg psql cluster-example${reset}\n"
echo "select pg_switch_wal()" | kubectl-cnpg psql ${cluster_name}

printf "${green}kubectl delete -f backup.yaml${reset}\n"
kubectl delete -f backup.yaml

printf "${green}kubectl apply -f backup.yaml${reset}\n"
kubectl apply -f backup.yaml

printf "${green}echo \"select pg_switch_wal()\" | kubectl-cnpg psql cluster-example${reset}\n"
echo "select pg_switch_wal()" | kubectl-cnpg psql ${cluster_name} 

