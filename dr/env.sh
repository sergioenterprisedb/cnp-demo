#!/bin/bash

export IMAGENAME="ghcr.io/cloudnative-pg/postgresql:16.3"

# MINIO
export MINIO_DESTINATIONPATH="s3://cnp/"
export MINIO_PORT="9000"
export HOSTNAME="172.17.0.2"
#export HOSTNAME="127.0.0.1"
export MINIO_ENDPOINTURL="http://${HOSTNAME}:${MINIO_PORT}"

# S3 AWS
export MINIO_DESTINATIONPATH="s3://sergio1-bucket/"
. ./.aws.sh

# S3 LS
#AWS_ENDPOINT_URL=https://us-east-1.console.aws.amazon.com/s3/buckets/sergio1-bucket/
S3_BUCKET=${MINIO_DESTINATIONPATH}

# rm -Rf *.yaml
# cp minio/*.yaml .

# sed -i '' -e "s|###IMAGENAME###|${IMAGENAME}|g" cluster*.yaml
# sed -i '' -e "s|###MINIO_DESTINATIONPATH###|${MINIO_DESTINATIONPATH}|g" cluster*.yaml
# sed -i '' -e "s|###MINIO_ENDPOINTURL###|${MINIO_ENDPOINTURL}|g" cluster*.yaml


