#!/bin/bash
kubectl describe backup backup-test
. ./config.sh

# Doc
echo 11 > ./docs/docid

printf "${green}kubectl describe backup backup-test${reset}\n"
