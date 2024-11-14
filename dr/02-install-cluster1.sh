#!/bin/bash

if [ ! -e ".aws.sh" ]; then
  echo ""
  echo "Error"
  echo "-----"
  echo "File .aws.sh doesn't exists. Please, create file and configure your AWS credentials."
  echo ""
  echo "export AWS_ACCESS_KEY_ID='<AWS_ACCESS_KEY_ID>'"
  echo "export AWS_SECRET_ACCESS_KEY='AWS_SECRET_ACCESS_KEY'"
  echo "export AWS_SESSION_TOKEN='<AWS_SESSION_TOKEN>'"
  echo ""
  exit
fi

cd s3
./s3_rm_cluster.sh cluster1
cd ..

kubectl apply -f cluster1.yaml
