#!/bin/bash

node=$1

if [ $# -eq 0 ]; then
  echo "No parameter <node> provided."
  exit
fi

# Drain
kubectl drain ${node} --delete-emptydir-data --ignore-daemonsets
read -p "Press Enter to continue..."

# cordon
kubectl cordon ${node}
read -p "Press Enter to continue..."

# Uncordon
kubectl uncordon ${node}

