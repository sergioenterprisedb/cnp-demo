#!/bin/bash

kubectl drain k3d-test-agent-3 --delete-emptydir-data --ignore-daemonsets

