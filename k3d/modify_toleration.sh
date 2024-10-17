#!/bin/bash

# Define variables
POD_NAME=$1
NAMESPACE="default"
NEW_TOLERATION_SECONDS="10"

# Patch the pod
kubectl patch pod "$POD_NAME" -n "$NAMESPACE" --type='json' -p="[{'op':'replace', 'path':'/spec/tolerations/0/tolerationSeconds', 'value': $NEW_TOLERATION_SECONDS}]"
kubectl patch pod "$POD_NAME" -n "$NAMESPACE" --type='json' -p="[{'op':'replace', 'path':'/spec/tolerations/1/tolerationSeconds', 'value': $NEW_TOLERATION_SECONDS}]"

