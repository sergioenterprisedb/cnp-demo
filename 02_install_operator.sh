#!/bin/bash

. ./config.sh
version=`kubectl-cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
printf "${green}kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/releases/cnpg-${version}.yaml${reset}\n"

version1=`kubectl-cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
version2=${version%??}

kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-${version2}/releases/cnpg-${version1}.yaml

