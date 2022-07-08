#!/bin/bash

#docker pull ghcr.io/cloudnative-pg/postgresql:14
docker pull ghcr.io/cloudnative-pg/postgresql:14.2
docker pull ghcr.io/cloudnative-pg/postgresql:14.3
docker pull ghcr.io/cloudnative-pg/postgresql:14.4
docker pull ghcr.io/cloudnative-pg/cloudnative-pg:1.15.0
docker pull ghcr.io/cloudnative-pg/cloudnative-pg:1.16.0

# Run postgres images
#docker run --rm -e POSTGRES_PASSWORD=password ghcr.io/cloudnative-pg/postgresql:14

