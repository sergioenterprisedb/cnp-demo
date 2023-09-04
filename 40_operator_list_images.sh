#!/bin/sh

#docker images | grep -E "REPOSITORY|/cloudnative-pg/cloudnative-pg"
docker image list --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}" | grep -E "REPOSITORY|/cloudnative-pg/cloudnative-pg"

