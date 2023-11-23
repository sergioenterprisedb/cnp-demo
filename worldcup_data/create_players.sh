#!/bin/bash
. ../config.sh
. ../primary.sh

export PWD=`pwd`

echo $PWD

kubectl exec -it ${primary} -- psql < ./test.sql
kubectl exec -it ${primary} -- psql < ./players_schema.sql
kubectl exec -it ${primary} -- psql < ./players.sql

