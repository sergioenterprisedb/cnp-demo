#!/bin/bash
kind load docker-image ghcr.io/cloudnative-pg/postgresql:14.2
kind load docker-image ghcr.io/cloudnative-pg/postgresql:14.3
kind load docker-image ghcr.io/cloudnative-pg/postgresql:14.4
kind load docker-image ghcr.io/cloudnative-pg/cloudnative-pg:1.15.0

# List images
docker exec -it kind-control-plane crictl images

