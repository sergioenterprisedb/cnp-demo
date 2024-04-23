# Operator upgrades test
Threee operator test scripts are provided:
- Version 1.22.0
- Version 1.22.1
- Version 1.22.2

A cluster yaml file is provided with 3 clusters with 3 instances each (0.3 cpu's for testing):
- cluster-example1
- cluster-example2
- cluster-example3

# How to create clusters
```
kubectl apply -f cluster-example-multi-node.yaml
cluster.postgresql.cnpg.io/cluster-example1 created
cluster.postgresql.cnpg.io/cluster-example2 created
cluster.postgresql.cnpg.io/cluster-example3 created
```
# How to delete clusters
```
kubectl delete -f cluster-example-multi-node.yaml
cluster.postgresql.cnpg.io "cluster-example1" deleted
cluster.postgresql.cnpg.io "cluster-example2" deleted
cluster.postgresql.cnpg.io "cluster-example3" deleted
```
# Upgrade clusters from 1.22.0 to 1.22.1
```
./operator_upgrade_1.22.0.sh
```
Observe the pod Operator Version field in monitoring screen.
s
# Pod monitoring during upgrading
```
watch ./monitoring_upgrade.sh

Instance Name       Cluster Name      Status   Image Version                           Role     Operator Version
cluster-example1-1  cluster-example1  Running  ghcr.io/cloudnative-pg/postgresql:14.5  primary  1.22.0
cluster-example1-2  cluster-example1  Running  ghcr.io/cloudnative-pg/postgresql:14.5  replica  1.22.0
cluster-example1-3  cluster-example1  Running  ghcr.io/cloudnative-pg/postgresql:14.5  replica  1.22.0
cluster-example2-1  cluster-example2  Running  ghcr.io/cloudnative-pg/postgresql:14.5  primary  1.22.0
cluster-example2-2  cluster-example2  Running  ghcr.io/cloudnative-pg/postgresql:14.5  replica  1.22.0
cluster-example2-3  cluster-example2  Running  ghcr.io/cloudnative-pg/postgresql:14.5  replica  1.22.0
cluster-example3-1  cluster-example3  Running  ghcr.io/cloudnative-pg/postgresql:14.5  primary  1.22.0
cluster-example3-2  cluster-example3  Running  ghcr.io/cloudnative-pg/postgresql:14.5  replica  1.22.0
cluster-example3-3  cluster-example3  Running  ghcr.io/cloudnative-pg/postgresql:14.5  replica  1.22.0
```
