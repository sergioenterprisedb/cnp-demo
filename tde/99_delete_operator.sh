#!/bin/bash

kubectl delete cluster cluster-example-tde
kubectl delete cluster cluster-example
kubectl delete -f https://get.enterprisedb.io/cnp/postgresql-operator-1.23.0.yaml
kubectl delete -f https://get.enterprisedb.io/cnp/postgresql-operator-1.23.1.yaml
kubectl delete -f https://get.enterprisedb.io/cnp/postgresql-operator-1.23.2.yaml
kubectl delete -f https://get.enterprisedb.io/cnp/postgresql-operator-1.24.1.yaml
kubectl delete secret tde-key

kubectl delete namespace postgresql-operator-system

rm tde_file.log

. ../config.sh
. ./.credentials.sh

version1=`kubectl cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
version2=${version1%??}
kubectl delete -f --force-conflicts --server-side -f https://get.enterprisedb.io/cnp/postgresql-operator-${version1}.yaml

kubectl delete -f \
   https://get.enterprisedb.io/pg4k/pg4k-$EDB_SUBSCRIPTION_PLAN-${version1}.yaml

