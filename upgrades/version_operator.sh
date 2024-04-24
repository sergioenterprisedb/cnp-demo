#!/bin/bash

kubectl get deployments.apps -n cnpg-system cnpg-controller-manager -o wide

