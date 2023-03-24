#!/bin/bash
. ./config.sh
printf "${green}curl -sSfL
  https://github.com/cloudnative-pg/cloudnative-pg/raw/main/hack/install-cnpg-plugin.sh |
  sh -s -- -b /usr/local/bin${reset}\n"

curl -sSfL \
  https://github.com/cloudnative-pg/cloudnative-pg/raw/main/hack/install-cnpg-plugin.sh | \
  sh -s -- -b /usr/local/bin

