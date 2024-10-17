#!/bin/bash

kubectl exec -i cluster1-1 -- psql < ../sqltest.sql

