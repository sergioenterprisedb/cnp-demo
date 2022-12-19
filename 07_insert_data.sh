#!/bin/bash
. ./config.sh
printf "${green}kubectl exec -i cluster-example-1 -- psql < sqltest.sql${reset}\n"

kubectl exec -i cluster-example-1 -- psql < sqltest.sql

# Worldcup sample ata
cd worldcup_data
./create_players.sh
cd ..
