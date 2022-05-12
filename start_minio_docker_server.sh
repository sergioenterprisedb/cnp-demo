#!/bin/bash

# Docker Server
docker run -p 9000:9000 -p 9001:9001 \
           -e MINIO_ROOT_USER=admin \
           -e MINIO_ROOT_PASSWORD=password \
           --rm \
           minio/minio server /data \
           --console-address ":9001" 
