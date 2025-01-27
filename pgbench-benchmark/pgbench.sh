#!/bin/bash
. ../config.sh

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
  echo "Error: No description provided for this test."
  echo "Usage: $0 <description>"
  exit 1
else
  description=$1
fi


# Function to check job status
check_job_status() {
    STATUS=$(${kubectl_cmd} get job $JOB_NAME -n $NAMESPACE -o jsonpath='{.status.conditions[?(@.type=="Complete")].status}')
    printf "$STATUS"
}

# Check if job is running
check_job_running() {
  # Poll for the job completion status
  printf "${green}Monitoring the job: $JOB_NAME in namespace: $NAMESPACE${reset}\n"
  while true; do
    STATUS=$(check_job_status)
    if [[ "$STATUS" == "True" ]]; then
      printf "${green}Job $JOB_NAME has been successfully completed!${reset}\n"
      break
    fi
    printf "${yellow}Waiting for job $JOB_NAME to complete...${reset}\n"
    sleep 3
  done
}

# Get primary instance
get_primary() {
  export primary=`kubectl get pod -o=jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.status.podIP}{'\t'}{.metadata.labels.role}{'\n'}" | grep ${cluster_name}- | grep primary | awk '{print $1}'`
}

# Create table
create_table() {
  get_primary
  ${kubectl_cmd} exec -it ${primary} -- psql -c \
  "CREATE TABLE IF NOT EXISTS pgbench_test (id serial primary key, date date, description text, tps float)"
}


# Insert bench
insert_pgbench() {
  # Get tps
  tps=`${kubectl_cmd} logs jobs/pgbench-run | grep 'tps' | sed -E 's/^tps = ([0-9.]+).*/\1/'`

  ${kubectl_cmd} exec -it ${primary} -- psql -c \
  "INSERT INTO pgbench_test (date, description, tps) values (now(),'${description}',${tps})" > /dev/null
}

# Delete jobs
printf "${green}Deleting jobs...${reset}\n"
${kubectl_cmd} delete jobs pgbench-init
${kubectl_cmd} delete jobs pgbench-run
sleep 5

printf "${green}Running job pgbench-init...${reset}\n"
${kubectl_cnp} pgbench \
  --job-name pgbench-init ${cluster_name}   \
  -- --initialize \
  --scale 20 --progress 1 

# Set the job name and namespace
JOB_NAME="pgbench-init"
NAMESPACE="default"  # Change to the namespace where your job is running

# Check job running
check_job_running

${kubectl_cmd} logs jobs/pgbench-init

JOB_NAME="pgbench-run"
STATUS=""

${kubectl_cnp} pgbench \
  --job-name pgbench-run \
  ${cluster_name} \
  -- --time 20 \
  --client 16 \
  --jobs 8

# Check job running
check_job_running

${kubectl_cmd} logs jobs/pgbench-run

# create table if doesn't exists
create_table
insert_pgbench
