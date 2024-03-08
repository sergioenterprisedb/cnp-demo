#!/bin/bash

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

#cluster_old=`echo $new_line | awk -F "\"*,\"*" '{print $1}'`

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
echo "Global cluster CPU count:,$cluster_cpu_count_total_k8s" >>/tmp/total_cpu.csv

cat /tmp/total_cpu.csv | sed -e 's/,,/, ,/g' | column -s, -t 
printf "\n"
