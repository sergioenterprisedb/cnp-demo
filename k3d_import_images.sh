#!/bin/bash
k3d images import --mode direct ghcr.io/cloudnative-pg/postgresql:14.2
k3d images import --mode direct ghcr.io/cloudnative-pg/postgresql:14.3
