#!/bin/bash

########################################################################################################################
# Author:      Sergio Romera                                                                                           #
# Date:        08/03/2024                                                                                              #
# Subject:     Pod cpu count                                                                                           #
# Description: This script count the number of CPU's per cluster in all K8s namespaces                                 #
# Limitations: This version doesn't support fractions of cpu's                                                         #
#                                                                                                                      #
# ./cpu_count.sh                                                                                                       #
# Namespace                     Cluster              Pod name                      IP            Type        CPU's     #
# ----------------              -------------------  ----------------------------  ------------  ----------  -----     #
# default                       cluster-a            cluster-a-1                   10.1.27.53    primary     1         #
# default                       cluster-a            cluster-a-2                   10.1.27.55    replica     1         #
# Cluster cluster-a CPU count:  2                                                                                      #
#                                                                                                                      #
# Namespace                     Cluster              Pod name                      IP            Type        CPU's     #
# ----------------              -------------------  ----------------------------  ------------  ----------  -----     #
# test                          cluster-b            cluster-b-1                   10.1.27.69    primary     1         #
# Cluster cluster-b CPU count:  1                                                                                      #
#                                                                                                                      #
# Global cluster CPU count:     3                                                                                      #
########################################################################################################################

#cluster_line=""
cluster_name=""
cluster_name_old=""
cluster_line_new=""
cluster_cpu_count=0             # pod count
cluster_cpu_count_total=0       # cluster group count
cluster_cpu_count_total_k8s=0   # cluster global count
i=1               #line number read

rm /tmp/total_cpu.csv
rm /tmp/cnp_cpu_count_header.csv

echo "Namespace,Cluster,Pod name,IP,Type,CPU's" > /tmp/cnp_cpu_count_header.csv
echo "----------------,-------------------,----------------------------,------------,----------,-----" >> /tmp/cnp_cpu_count_header.csv

kubectl get pod -A \
-o=jsonpath="\
{range .items[*]}\
{.metadata.namespace},\
{.metadata.labels.cnpg\.io\/cluster},\
{.metadata.name},\
{.status.podIP},\
{.metadata.labels.role},\
{.spec.containers[*].resources.limits.cpu}\
{'\n'}" | \
grep -E "primary|replica" >/tmp/cnp_cpu_count.csv

while read LINE
do

  cluster_line_new=$LINE
  cluster_name=`echo $cluster_line_new | awk -F "\"*,\"*" '{print $2}'`
  if [  $i -eq 1 ]; then
    cluster_name_old=$cluster_name
    cat /tmp/cnp_cpu_count_header.csv >>/tmp/total_cpu.csv
  fi

  if [ "$cluster_name" != "$cluster_name_old" ]; then
    echo "Cluster $cluster_name_old CPU count:,$cluster_cpu_count_total" >>/tmp/total_cpu.csv
    echo ",,">>/tmp/total_cpu.csv
    cat /tmp/cnp_cpu_count_header.csv >>/tmp/total_cpu.csv
    cluster_cpu_count=0
    cluster_cpu_count_total=0
    i=1
  fi

  echo "$cluster_line_new" >>/tmp/total_cpu.csv

  if [ "$cluster_name" = "$cluster_name_old" ] || [ $i -gt 0 ]; then
    echo "$new_line" > /tmp/cnp_cpu_count_cluster.csv
    cluster_cpu_count=`echo $cluster_line_new | awk -F "\"*,\"*" '{print $6}'`
  fi

  cluster_cpu_count_total=$(($cluster_cpu_count_total + $cluster_cpu_count))
  cluster_cpu_count_total_k8s=$(($cluster_cpu_count_total_k8s + $cluster_cpu_count))
  ((i++))
  cluster_line_old=$cluster_line_new
  cluster_name_old=$cluster_name

done < /tmp/cnp_cpu_count.csv

echo "Cluster $cluster_name CPU count:,$cluster_cpu_count_total" >>/tmp/total_cpu.csv
echo ",,">>/tmp/total_cpu.csv
echo "Global clusters CPU count:,$cluster_cpu_count_total_k8s" >>/tmp/total_cpu.csv

cat /tmp/total_cpu.csv | sed -e 's/,,/, ,/g' | column -s, -t 
echo ""
