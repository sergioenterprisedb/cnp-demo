#!/bin/bash

#MinIO secrets
kubectl create secret generic minio-creds \
  --from-literal=MINIO_ACCESS_KEY=admin \
  --from-literal=MINIO_SECRET_KEY=password

kubectl apply -f cluster-example.yaml
