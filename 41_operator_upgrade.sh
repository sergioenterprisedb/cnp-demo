#!/bin/sh

. ./config.sh

version1=`kubectl cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
version2=${version1%??}

latest_version=`kubectl cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`

printf "${green}Current operator version is: ${latest_version}.\n"
printf "${reset}"
printf "These pods will be upgraded:\n"
printf "CLUSTER NAME\t\tVERSION\t\tROLE\n"
kubectl get pod -o=jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.metadata.annotations.cnpg\.io\/operatorVersion}{'\t\t'}{.metadata.labels.role}{'\n'}"
printf "Press ENTER to continue:\n"
read

version1=`kubectl cnpg version | awk '{ print $2 }' | awk -F":" '{ print $2}'`
version2=${version1%??}

printf "${green}
kubectl apply --server-side  --force-conflicts -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-${version2}/releases/cnpg-${version1}.yaml
${reset}\n"

kubectl apply --server-side  --force-conflicts -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-${version2}/releases/cnpg-${version1}.yaml

printf "${green}Wait a minute and press ENTER to continue:\n${reset}"
read

printf "\n"
printf "${green}kubectl get pod -o=jsonpath=\"{range .items[*]}{.metadata.name}{'\t'}{.metadata.annotations.cnpg\.io\/operatorVersion}{'\t\t'}{.metadata.labels.role}{'\n'}\"${reset}"

printf "\n"
printf "CLUSTER NAME\t\tVERSION\t\tROLE\n"
kubectl get pod -o=jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.metadata.annotations.cnpg\.io\/operatorVersion}{'\t\t'}{.metadata.labels.role}{'\n'}"

