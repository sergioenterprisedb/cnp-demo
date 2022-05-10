#!/bin/bash

# Uninstall cluster
kubectl delete -f cluster-example.yaml
rm cluster-example.yaml

# Uninstall operator
kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/releases/cnpg-1.15.0.yaml

# Delete cluster
k3d cluster delete
k3d cluster create

# Kill MinIO
#ps | grep "start_minio" | grep -v grep | awk '{print $1}' | xargs -I % kill %

