#!/bin/bash

cd s3
./s3_rm_cluster.sh cluster2
cd ..

kubectl apply -f cluster2.yaml

