#!/bin/bash
. ./config.sh

. ./primary.sh

printf "${yellow}Deleting pvc and pod from primary instance ${primary}...${reset}\n"

printf "${green}kubectl delete pvc/${primary} pod/${primary} --force${reset}\n"
kubectl delete pvc/${primary} pod/${primary} pvc/${primary}-tbs-idx pvc/${primary}-tbs-tmptbs pvc/${primary}-wal --force

