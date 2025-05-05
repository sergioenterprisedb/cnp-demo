#!/bin/bash

. ./config.sh

echo 16 > ./docs/docid

printf "${green}kubectl exec -it cluster-example-1 -- psql < ./pitr/pitr_insert_data_3.sql${reset}\n"

kubectl exec -it cluster-example-1 -- psql  < ./pitr/pitr_insert_data_3.sql
