#!/bin/bash

. ./env.sh

rm -Rf *.yaml
cp minio/*.yaml .

sed -i '' -e "s|###IMAGENAME###|${IMAGENAME}|g" cluster*.yaml
sed -i '' -e "s|###MINIO_DESTINATIONPATH###|${MINIO_DESTINATIONPATH}|g" cluster*.yaml
sed -i '' -e "s|###MINIO_ENDPOINTURL###|${MINIO_ENDPOINTURL}|g" cluster*.yaml


