#!/bin/bash

cluster_name=$1

if [ -z "${cluster_name}" ]; then
  echo "Parameter is null or empty."
  exit
else
  echo "Parameter is not null. Value: $1"
fi


printf "${green}echo \"select pg_switch_wal()\" | kubectl-cnpg psql ${cluster_name}${reset}\n"
echo "select pg_switch_wal()" | kubectl-cnpg psql ${cluster_name}

printf "${green}kubectl delete -f backup.yaml${reset}\n"
kubectl delete -f backup.yaml

printf "${green}kubectl apply -f backup.yaml${reset}\n"
kubectl apply -f backup.yaml

printf "${green}echo \"select pg_switch_wal()\" | kubectl-cnpg psql ${cluster_name}${reset}\n"
echo "select pg_switch_wal()" | kubectl-cnpg psql ${cluster_name} 

