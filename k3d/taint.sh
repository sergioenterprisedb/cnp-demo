#!/bin/bash

kubectl taint nodes k3d-test-server-0 dedicated:NoSchedule

