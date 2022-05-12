#!/bin/bash
kubectl describe backup backup-test
. ./config.sh
printf "${green}kubectl describe backup backup-test${reset}\n"
