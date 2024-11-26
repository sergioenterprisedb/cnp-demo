#!/bin/bash

#
# Warning: EDB Postgres for Kubernetes images are not compatible with ARM architectures
#

# Create namespace
kubectl create namespace postgresql-operator-system

. ../config.sh
. ./.credentials.sh

docker login docker.enterprisedb.com -u $EDB_SUBSCRIPTION_PLAN -p $EDB_SUBSCRIPTION_TOKEN

version1=`kubectl cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
version2=${version1%??}
printf "${green}kubectl apply --force-conflicts --server-side -f https://get.enterprisedb.io/cnp/postgresql-operator-${version1}.yaml${reset}\n"

kubectl create secret -n postgresql-operator-system docker-registry edb-pull-secret \
  --docker-server=docker.enterprisedb.com \
  --docker-username=k8s_$EDB_SUBSCRIPTION_PLAN \
  --docker-password=$EDB_SUBSCRIPTION_TOKEN

sleep 5

#kubectl apply --force-conflicts --server-side -f https://get.enterprisedb.io/cnp/postgresql-operator-${version1}.yaml
kubectl apply --server-side -f \
   https://get.enterprisedb.io/pg4k/pg4k-$EDB_SUBSCRIPTION_PLAN-${version1}.yaml

sleep 15
kubectl get deployments.apps -n postgresql-operator-system

