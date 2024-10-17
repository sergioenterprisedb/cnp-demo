#/bin/bash

. ./setup.sh

kubectl delete secret minio-creds

#kubectl create secret generic minio-creds \
#  --from-literal=ACCESS_KEY_ID=admin \
#  --from-literal=ACCESS_SECRET_KEY=password

kubectl create secret generic minio-creds \
  --from-literal=ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
  --from-literal=ACCESS_SECRET_KEY=${AWS_SECRET_ACCESS_KEY} \
  --from-literal=ACCESS_SESSION_TOKEN=${AWS_SESSION_TOKEN}

