#!/bin/bash

. ../env.sh

./s3_banner.sh

aws s3 ls --recursive $S3_BUCKET
printf "\n"



