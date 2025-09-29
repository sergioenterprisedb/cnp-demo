
# Welcome to CloudNativePG demo!

In this demo I'll show you how to create a PostgreSQL cluster with the Red Hat OpenShift operator called EDB CloudNativePG. The features that I want to show you are:

- Kubernetes plugin install
- EDB Postgres for Kubernetes operator install
- Postgres cluster install
- Insert data in the cluster
- Switchover (promote)
- Failover
- Backup & Recovery (in a S3 Minio platform)
- Scale out/down
- Rolling updates (minor and major)
- Point In Time Recovery (PITR)
- Fencing
- Replication slots (for HA)
- Monitoring (scripts)

# Architecture deployed

```
     ╭────────────────────────────────╮
     │                                ▼
┌───────────┐   ┌───────────┐   ┌───────────┐
│  Primary  │█  │  Standby  │   │  Standby  │
└───────────┘█  └───────────┘   └───────────┘
 ▀▀▀▀▀▀▀▀▀▀▀▀▀
     │                 ▲
     ╰─────────────────╯
```

# Switchover

```
      ╭───────────────┬───────────────╮
      ▼               │               ▼
┌───────────┐   ┌───────────┐   ┌───────────┐
│  Standby  │   │  Primary  │█  │  Standby  │
└───────────┘   └───────────┘█  └───────────┘
                 ▀▀▀▀▀▀▀▀▀▀▀▀▀ 
```

 