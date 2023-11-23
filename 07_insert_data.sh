#!/bin/bash
. ./config.sh
. ./primary.sh

printf "${green}kubectl exec -i ${primary} -- psql < sqltest.sql${reset}\n"

kubectl exec -i ${primary} -- psql < sqltest.sql

# Worldcup sample ata
cd worldcup_data
./create_players.sh
cd ..
