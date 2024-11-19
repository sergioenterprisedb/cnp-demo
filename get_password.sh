#!/bin/bash
export PGPASSWORD=$(kubectl get secret --namespace default cluster-example-superuser -o jsonpath="{.data.password}" | base64 --decode)
echo $PGPASSWORD
