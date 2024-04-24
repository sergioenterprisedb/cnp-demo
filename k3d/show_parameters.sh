#!/bin/bash

clear

kubectl exec -it cluster-example-1 -- psql -c "
select name, setting
from pg_settings
where 
name = 'synchronous_standby_names'
or name = 'synchronous_commit';
"

