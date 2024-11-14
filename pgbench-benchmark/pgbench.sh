#!/bin/bash
kubectl delete jobs pgbench-init
kubectl delete jobs pgbench-run
sleep 4 
 
kubectl cnpg pgbench \
  --job-name pgbench-init cluster-example   \
  -- --initialize \
  --scale 20 \
  --index-tablespace=idx

sleep 25 

kubectl logs  jobs/pgbench-init
sleep 2

kubectl cnpg pgbench \
  --job-name pgbench-run \
  cluster-example \
  -- --time 20 \
  --client 32 \
  --jobs 8
sleep 40

kubectl logs jobs/pgbench-run

kubectl delete jobs pgbench-init
kubectl delete jobs pgbench-run

