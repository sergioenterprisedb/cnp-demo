
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: cnpg-controller-manager-config
  namespace: cnpg-system
data:
  ENABLE_INSTANCE_MANAGER_INPLACE_UPDATES: 'false'
EOF
