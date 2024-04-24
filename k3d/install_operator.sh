#!/bin/bash

# Deploy operator
kubectl apply --server-side --force-conflicts -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.22/releases/cnpg-1.22.0.yaml

kubectl get deploy -n cnpg-system cnpg-controller-manager -o wide
sleep 10

# Configmap operator upgrade in place
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: cnpg-controller-manager-config
  namespace: cnpg-system
data:
  #INHERITED_ANNOTATIONS: categories
  #INHERITED_LABELS: environment, workload, app
  ENABLE_INSTANCE_MANAGER_INPLACE_UPDATES: 'true'
EOF

# Restart the operator
kubectl rollout restart deployment \
    -n cnpg-system \
    cnpg-controller-manager

# Operator status
kubectl get deploy -n cnpg-system cnpg-controller-manager -o wide

echo "kubectl get deploy -n cnpg-system cnpg-controller-manager"

