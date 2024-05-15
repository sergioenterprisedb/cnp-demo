#!/bin/bash

# Define colors
RED='\e[31m'
GREEN='\e[32m'
NC='\e[33m' # No Color

kubectl_filter="\
{range .items[*]}{.metadata.name}{','}\
{.metadata.labels.cnpg\.io\/cluster}{','}\
{.items[*]}{.status.phase}{','}\
{.spec.containers[*].image}{','}\
{.items[*]}{.metadata.labels.role}{','}\
{.items[*]}{.spec.nodeName}{','}\
{.items[*]}{.metadata.annotations.cnpg\.io\/operatorVersion}{'\n'}{end}"

echo "Instance Name,Cluster Name,Status,Image Version,Role,Node name,Operator Version" > ./monitor.log

kubectl get pod -o=jsonpath="$kubectl_filter"  >> ./monitor.log


cat monitor.log | sort | column -s, -t


