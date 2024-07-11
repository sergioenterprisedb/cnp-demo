#!/bin/bash
#alias kg='/usr/local/bin/kubectl-cnpg'
watch -c -n 2 kubectl-cnpg --color always status cluster-example
