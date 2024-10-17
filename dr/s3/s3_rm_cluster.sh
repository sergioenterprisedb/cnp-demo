#!/bin/bash

. ../env.sh

./s3_banner.sh

cluster_name=$1

aws s3 rm ${S3_BUCKET}${cluster_name} --recursive
printf "\n"



