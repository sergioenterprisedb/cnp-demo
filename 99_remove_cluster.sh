#!/bin/bash

# Uninstall cluster
kubectl delete -f cluster-example.yaml
rm cluster-example.yaml

# Uninstall operator
kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/releases/cnpg-1.15.0.yaml

# K3d cluster
k3d cluster delete
k3d cluster create

#kind cluster
kind delete cluster
kind create cluster

#./docker_pull_images.sh
./k3d_import_images.sh

# Stop MinIO
#ps | grep "start_minio" | grep -v grep | awk '{print $1}' | xargs -I % kill %
docker ps | grep minio | awk '{print $1}' | xargs -I % docker stop %
