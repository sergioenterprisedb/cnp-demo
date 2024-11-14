#!/bin/bash

kubectl config get-context
kubectl config current-context
kubectl config use-context docker-desktop
kubectl config set-context --current --namespace=default
