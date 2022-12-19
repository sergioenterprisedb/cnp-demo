#!/bin/bash

export PWD=`pwd`

echo $PWD

kubectl exec -it cluster-example-1 -- psql < ./test.sql
kubectl exec -it cluster-example-1 -- psql < ./players_schema.sql
kubectl exec -it cluster-example-1 -- psql < ./players.sql

