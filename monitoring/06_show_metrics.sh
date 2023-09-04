#!/bin/sh

cat > ./curl.yaml <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: curl
spec:
  containers:
  - name: curl
    image: curlimages/curl:7.84.0
    command: ['sleep', '3600']
EOF

kubectl apply -f curl.yaml
sleep 3
POD_IP=`kubectl get pod -o=jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.status.podIP}{'\t'}{.metadata.labels.role}{'\n'}" | grep primary | awk '{print $2}'`
#POD_IP=$(kubectl get pod cluster-example-1 --template '{{.status.podIP}}')

kubectl exec -ti curl -- curl -s ${POD_IP}:9187/metrics
kubectl delete -f curl.yaml

