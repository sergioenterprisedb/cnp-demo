#!/bin/bash

kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.23/releases/cnpg-1.23.0.yaml
kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.23/releases/cnpg-1.23.1.yaml
kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.23/releases/cnpg-1.23.2.yaml

kubectl apply --force-conflicts --server-side -f https://get.enterprisedb.io/cnp/postgresql-operator-1.23.2.yaml
kubectl get deployment -n postgresql-operator-system postgresql-operator-controller-manager

