#!/bin/bash
kubectl exec -i cluster-example-1 -- psql < sqltest.sql

