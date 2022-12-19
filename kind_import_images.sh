#!/bin/bash
kind load docker-image ghcr.io/cloudnative-pg/postgresql:14.2
#kind load docker-image ghcr.io/cloudnative-pg/postgresql:14.3
#kind load docker-image ghcr.io/cloudnative-pg/postgresql:14.4
kind load docker-image ghcr.io/cloudnative-pg/postgresql:14.5
kind load docker-image ghcr.io/cloudnative-pg/postgresql:15.1

#kind load docker-image ghcr.io/cloudnative-pg/cloudnative-pg:1.17.1
kind load docker-image ghcr.io/cloudnative-pg/cloudnative-pg:1.18.0

# List images
docker exec -it kind-control-plane crictl images

