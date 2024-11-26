#!/bin/bash

kubectl delete cluster cluster-example-tde
kubectl delete cluster cluster-example
kubectl delete -f https://get.enterprisedb.io/cnp/postgresql-operator-1.23.0.yaml
kubectl delete -f https://get.enterprisedb.io/cnp/postgresql-operator-1.23.1.yaml
kubectl delete -f https://get.enterprisedb.io/cnp/postgresql-operator-1.23.2.yaml
kubectl delete secret tde-key
rm tde_file.log

