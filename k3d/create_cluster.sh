#!/bin/bash

# Create 1 server (1 control plane) et 4 agents
k3d cluster create test --agents 4

# Create 3 servers (3 nodes with 1 control plane each)
#k3d cluster create test --servers 3

