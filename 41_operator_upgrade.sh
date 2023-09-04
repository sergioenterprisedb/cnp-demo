#!/bin/sh

. ./config.sh

version=$1
latest_version=`kubectl cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`

if [ -z "$version" ]; then
  printf "${green}Version can not be empty. The latest version is ${latest_version}.\n"
  printf "Execute this command to upgrade to the latest version:\n"
  printf "$0 $latest_version\n"
  printf "${reset}"
  printf "These pods will be upgraded:\n"
  printf "CLUSTER NAME\t\tVERSION\t\tROLE\n"
  kubectl get pod -o=jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.metadata.annotations.cnpg\.io\/operatorVersion}{'\t\t'}{.metadata.labels.role}{'\n'}"
  exit 1
fi


version1=$version
version2=${version1%??}
#version1=1.20.0
#version2=1.20

#kubectl get pod cluster-example-1 --output=yaml
#kubectl get pod -o=jsonpath="{range .items[*]}{.metadata.name}{','}{.metadata.annotations.cnpg\.io\/operatorVersion}{'\n'}"
#kubectl get pod -o=jsonpath="{range .items[*]}{.metadata.name}{','}{.metadata.annotations.cnpg\.io\/operatorVersion}{','}{.metadata.labels.role}{'\n'}" | grep primary

printf "${green}kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-${version2}/releases/cnpg-${version1}.yaml${reset}\n"

kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-${version2}/releases/cnpg-${version1}.yaml


