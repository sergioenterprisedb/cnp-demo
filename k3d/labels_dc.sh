#!/bin/bash
kubectl label node k3d-dc1-node1-0 datacenter=dc1
kubectl label node k3d-dc1-node2-0 datacenter=dc1
kubectl label node k3d-dc1-node3-0 datacenter=dc1
kubectl label node k3d-dc2-node4-0 datacenter=dc2
kubectl label node k3d-dc2-node5-0 datacenter=dc2
kubectl label node k3d-dc2-node6-0 datacenter=dc2

#kubectl label node k3d-test-agent-0 datacenter=dc1
#kubectl label node k3d-test-agent-1 datacenter=dc1
#kubectl label node k3d-test-agent-2 datacenter=dc2
#kubectl label node k3d-test-agent-3 datacenter=dc2

kubectl get nodes --show-labels
