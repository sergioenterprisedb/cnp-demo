#!/bin/bash

cd s3
./s3_rm_cluster.sh cluster1
cd ..

kubectl apply -f cluster1.yaml

