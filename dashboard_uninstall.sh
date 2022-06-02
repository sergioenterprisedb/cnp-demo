#!/bin/bash

#https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

# Delete
rm service-account.yaml
kubectl -n kubernetes-dashboard delete serviceaccount admin-user
kubectl -n kubernetes-dashboard delete clusterrolebinding admin-user
ps ux | grep "kubectl proxy" | grep -v grep | awk '{print $2}' | xargs -I % kill %

