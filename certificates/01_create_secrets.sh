#!/bin/bash

OUTPUT_DIR="./certs"

# Delete secrets
kubectl delete secret my-postgresql-server-ca
kubectl delete secret my-postgresql-server

# Create a secret containing the CA certificate
kubectl create secret generic my-postgresql-server-ca \
  --from-file=ca.crt=${OUTPUT_DIR}/server.crt

# Create a secret with the TLS certificate
kubectl create secret tls my-postgresql-server \
  --cert=${OUTPUT_DIR}/server.crt --key=${OUTPUT_DIR}/server.key

