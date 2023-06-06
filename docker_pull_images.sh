#!/bin/bash

docker system prune
docker pull ghcr.io/cloudnative-pg/postgresql:13
docker pull ghcr.io/cloudnative-pg/postgresql:14.2
docker pull ghcr.io/cloudnative-pg/postgresql:14.5
docker pull ghcr.io/cloudnative-pg/cloudnative-pg:1.18.0
docker pull ghcr.io/cloudnative-pg/cloudnative-pg:1.19.0

# Run postgres images
#docker run --rm -e POSTGRES_PASSWORD=password ghcr.io/cloudnative-pg/postgresql:14

