#!/bin/bash

# Uninstall cluster
./delete_all_clusters.sh
rm cluster-example.yaml

# Uninstall operator
version1=`kubectl cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
version2=${version1%??}
kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-${version2}/releases/cnpg-${version1}.yaml

# K3d cluster
k3d cluster delete
k3d cluster create

#kind cluster
kind delete cluster
kind create cluster

#./docker_pull_images.sh
./k3d_import_images.sh
./kind_import_images.sh

# Stop MinIO
#ps | grep "start_minio" | grep -v grep | awk '{print $1}' | xargs -I % kill %
docker ps | grep minio | awk '{print $1}' | xargs -I % docker stop %
