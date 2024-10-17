#!/bin/bash
kubectl get nodes -o custom-columns=NAME:.metadata.name,STATUS:.status.conditions[-1].type,AGE:.metadata.creationTimestamp,VERSION:.status.nodeInfo.kubeletVersion,DATACENTER:.metadata.labels.datacenter | sort

