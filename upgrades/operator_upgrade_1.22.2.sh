#!/bin/bash

kubectl apply --server-side  --force-conflicts -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.22/releases/cnpg-1.22.2.yaml

