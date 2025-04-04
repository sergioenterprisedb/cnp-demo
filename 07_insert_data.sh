#!/bin/bash
. ./config.sh
. ./primary.sh

# Doc
echo 07 > ./docs/docid

printf "${green}kubectl exec -i ${primary} -- psql < sqltest.sql${reset}\n"

kubectl exec -i ${primary} -- psql < sqltest.sql

# Worldcup sample ata
cd worldcup_data
./create_players.sh
cd ..
