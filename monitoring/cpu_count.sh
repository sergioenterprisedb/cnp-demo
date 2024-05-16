#!/bin/bash

###########################################################################################################################
# Author:      Sergio Romera                                                                                              #
# Date:        08/03/2024                                                                                                 #
# Subject:     Pod cpu count                                                                                              #
# Description: This script count the number of CPU's per cluster in all K8s namespaces                                    #
# Limitations: This version doesn't support fractions of cpu's                                                            #
#                                                                                                                         #
# ./cpu_count.sh                                                                                                          #
#                                                                                                                         #
# Namespace                            Cluster              Pod name                      IP            Type        CPU's #
# -----------------------------------  -------------------  ----------------------------  ------------  ----------  ----- #
# default                              cluster-a            cluster-a-1                   10.1.27.194   primary     500m  #
# default                              cluster-a            cluster-a-2                   10.1.27.191   replica     500m  #
# -----------------------------------  -------------------                                                                #
# Cluster cluster-a CPU count:         1000(m) -> 1 CPU's                                                                 #
#                                                                                                                         #
# Namespace                            Cluster              Pod name                      IP            Type        CPU's #
# -----------------------------------  -------------------  ----------------------------  ------------  ----------  ----- #
# default                              cluster-example      cluster-example-1             10.1.27.193   primary     2     #
# default                              cluster-example      cluster-example-4             10.1.27.192   replica     2     #
# -----------------------------------  -------------------                                                                #
# Cluster cluster-example CPU count:   4000(m) -> 4 CPU's                                                                 #
#                                                                                                                         #
# -----------------------------------  -------------------                                                                #
# *** Global clusters CPU count ***    5000(m) -> 5 CPU's                                                                 #
# -----------------------------------  -------------------                                                                #
###########################################################################################################################

cluster_name=""
cluster_name_old=""
cluster_line_new=""
cluster_cpu_count=0             # pod count
cluster_cpu_count_total=0       # cluster group count
cluster_cpu_count_total_k8s=0   # cluster global count
i=1                             # line number read

dir="./tmp"
file_cnp_cpu_count_header="$dir/cnp_cpu_count_header.csv"
file_cnp_cpu_count_cluster="$dir/file_cnp_cpu_count_cluster.csv"
file_cnp_cpu_count="$dir/cnp_cpu_count.csv"
file_total_cpu="$dir/total_cpu.csv"

mkdir -p $dir

rm -f $file_cnp_cpu_count
rm -f $file_cnp_cpu_count_cluster
rm -f $file_cnp_cpu_count_header
rm -f $file_total_cpu

echo ""
echo "Namespace,Cluster,Pod name,IP,Type,CPU's" > $file_cnp_cpu_count_header
echo "-----------------------------------,-------------------,----------------------------,------------,----------,-----" >> $file_cnp_cpu_count_header

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
sort | \
grep -E "primary|replica" >$file_cnp_cpu_count

while read LINE
do

  cluster_line_new=$LINE
  cluster_name=`echo $cluster_line_new | awk -F "\"*,\"*" '{print $2}'`
  if [  $i -eq 1 ]; then
    cluster_name_old=$cluster_name
    cat $file_cnp_cpu_count_header >>$file_total_cpu
  fi

  if [ "$cluster_name" != "$cluster_name_old" ]; then
    echo "-----------------------------------,-------------------" >> $file_total_cpu
    echo "Cluster $cluster_name_old CPU count:,$cluster_cpu_count_total(m) -> `expr $cluster_cpu_count_total \/ 1000` CPU's" >>$file_total_cpu
    echo ",,">>$file_total_cpu
    cat $file_cnp_cpu_count_header >>$file_total_cpu
    cluster_cpu_count=0
    cluster_cpu_count_total=0
    i=1
  fi

  echo "$cluster_line_new" >>$file_total_cpu

  if [ "$cluster_name" = "$cluster_name_old" ] || [ $i -gt 0 ]; then
    echo "$new_line" > $file_cnp_cpu_count_cluster
    cluster_cpu_count=`echo $cluster_line_new | awk -F "\"*,\"*" '{print $6}'`

    if echo $cluster_cpu_count | grep -q "m"; then
      char="m"
      cluster_cpu_count=${cluster_cpu_count%?}
    else
      cluster_cpu_count=`expr $cluster_cpu_count \* 1000`
    fi
  fi

  cluster_cpu_count_total=$(($cluster_cpu_count_total + $cluster_cpu_count))
  cluster_cpu_count_total_k8s=$(($cluster_cpu_count_total_k8s + $cluster_cpu_count))
  ((i++))
  cluster_line_old=$cluster_line_new
  cluster_name_old=$cluster_name

done < $file_cnp_cpu_count

echo "-----------------------------------,-------------------" >> $file_total_cpu
echo "Cluster $cluster_name CPU count:,$cluster_cpu_count_total(m) -> `expr $cluster_cpu_count_total \/ 1000` CPU's" >>$file_total_cpu
echo ",,">>$file_total_cpu
echo "-----------------------------------,-------------------" >> $file_total_cpu
echo "*** Global clusters CPU count ***,$cluster_cpu_count_total_k8s(m) -> `expr $cluster_cpu_count_total_k8s \/ 1000` CPU's" >>$file_total_cpu
echo "-----------------------------------,-------------------" >> $file_total_cpu

cat $file_total_cpu | sed -e 's/,,/, ,/g' | column -s, -t 
echo ""
