#!/bin/bash

. ./config.sh
#version1=`kubectl-cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
version1=`kubectl cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
version2=${version1%??}
#version1=1.20.0
#version2=1.20
printf "${green}kubectl apply --server-side  --force-conflicts -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-${version2}/releases/cnpg-${version1}.yaml${reset}\n"

kubectl apply --server-side  --force-conflicts -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-${version2}/releases/cnpg-${version1}.yaml

