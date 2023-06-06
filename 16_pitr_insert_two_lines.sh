#!/bin/bash
. ./config.sh
printf "${green}kubectl exec -it cluster-example-1 -- psql < ./pitr/pitr_insert_data_1.sql${reset}\n"

kubectl exec -it cluster-example-1 -- psql  < ./pitr/pitr_insert_data_1.sql
sleep 5
kubectl exec -it cluster-example-1 -- psql  < ./pitr/pitr_insert_data_2.sql
