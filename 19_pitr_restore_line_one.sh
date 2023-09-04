#!/bin/bash
. ./config.sh

pitr_date=$(kubectl exec -it cluster-example-1 -- psql -X -A -t -c "select min(timestamp+interval '1 second') from test;") 
echo "${pitr_date%?}"
ip=`./get_ip.sh`
printf 'IP: $ip'
cat > ./pitr/restore.yaml <<EOF
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: cluster-restore
spec:
  instances: 1
  imageName: ghcr.io/cloudnative-pg/postgresql:14.5

  storage:
    size: 1Gi

  bootstrap:
    recovery:
      source: cluster-example
      recoveryTarget:
        targetTime: '${pitr_date%?}'
        #backupID: 20230411T115526

  externalClusters:
    - name: cluster-example
      barmanObjectStore:
        destinationPath: "s3://cnp/"
        endpointURL: "http://${ip}:9000"
        s3Credentials:
          accessKeyId:
            name: minio-creds
            key: MINIO_ACCESS_KEY
          secretAccessKey:
            name: minio-creds
            key: MINIO_SECRET_KEY
EOF

kubectl delete cluster cluster-restore
sleep 5
kubectl exec -it cluster-example-1 -- psql -c "select pg_switch_wal();"
kubectl apply -f ./pitr/restore.yaml
printf "\n"
printf "${green}/!\ Verify that only the first record will be restored :-)${reset}\n"
printf "\n"
sleep 20
kubectl exec -it cluster-restore-1 -- psql -c "select * from test;"

