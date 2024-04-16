#!/bin/bash

#kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/grafana-configmap.yaml
kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/prometheusrule.yaml
#kubectl delete -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/kube-stack-config.yaml
sleep 2
helm uninstall prometheus-community
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusagents.monitoring.coreos.com

#helm uninstall prometheus-community/kube-prometheus-stack
helm repo remove prometheus-community

