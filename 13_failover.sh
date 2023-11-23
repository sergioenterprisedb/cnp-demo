#!/bin/bash
. ./config.sh

#kubectl delete pod cluster-example-2 --force
primary=`kubectl get pod -o=jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.status.podIP}{'\t'}{.metadata.labels.role}{'\n'}" | grep primary | awk '{print $1}'`
printf "${yellow}Primary instance: ${red}${primary}${reset}\n"
printf "${yellow}Deleting pvc and pod from primary instance ${primary}...${reset}\n"

#kubectl delete pvc/cluster-example-2 pod/cluster-example-2 --force
printf "${green}kubectl delete pvc/${primary} pod/${primary} --force${reset}\n"
kubectl delete pvc/${primary} pod/${primary} --force
kubectl delete pod cluster-example-2 --force

