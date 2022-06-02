#!/bin/bash

#Doc
#https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

. ./config.sh

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
kubectl proxy &

cat > service-account.yaml <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

kubectl apply -f service-account.yaml
kubectl describe serviceaccount admin-user -n kubernetes-dashboard

# Create token
kubectl -n kubernetes-dashboard create token admin-user

printf "\n"
printf "${green}Click on this link and paste the token:\n"
printf "${green}http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy\n"
printf "${reset}"
