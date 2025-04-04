#!/bin/bash
. ./config.sh
printf "${green}curl -sSfL
  https://github.com/cloudnative-pg/cloudnative-pg/raw/main/hack/install-cnpg-plugin.sh |
  sh -s -- -b /usr/local/bin${reset}\n"

# Doc
echo 01 > ./docs/docid

curl -sSfL \
  https://github.com/cloudnative-pg/cloudnative-pg/raw/main/hack/install-cnpg-plugin.sh | \
  sudo sh -s -- -b /usr/local/bin

