#!/bin/bash

# Create 1 server (1 control plane) et 4 agents
#k3d cluster create test --agents 4

k3d cluster create test

k3d node create dc1-node1 -c test 
k3d node create dc1-node2 -c test
k3d node create dc1-node3 -c test
k3d node create dc2-node4 -c test
k3d node create dc2-node5 -c test
k3d node create dc2-node6 -c test

# Create 3 servers (3 nodes with 1 control plane each)
#k3d cluster create test --servers 3

# Taint node
./taint.sh

# Labels DC
./labels_dc.sh

# Check taints
kubectl get nodes -o go-template='{{printf "%-50s %-12s\n" "Node" "Taint"}}{{- range .items}}{{- if $taint := (index .spec "taints") }}{{- .metadata.name }}{{ "\t" }}{{- range $taint }}{{- .key }}={{ .value }}:{{ .effect }}{{ "\t" }}{{- end }}{{- "\n" }}{{- end}}{{- end}}'

# Install Operator
./install_operator.sh

