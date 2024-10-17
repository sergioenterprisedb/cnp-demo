
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
