#!/bin/bash
. ../config.sh
export primary=`${kubectl_cmd} get pod -o=jsonpath="{range .items[*]}{.metadata.name}{'\t'}{.status.podIP}{'\t'}{.metadata.labels.role}{'\n'}" | grep ${cluster_name} | grep primary | awk '{print $1}'`

${kubectl_cmd} exec -it ${primary} -- psql -U postgres > tde_file.log <<EOF
drop table users;
create table users (userid int, password varchar(100));
insert into users values (1, 'Thisismypassword01#');
-- Flush dirty pages
checkpoint;

select pg_relation_filepath('users');
EOF
${kubectl_cmd} exec -it ${primary} -- psql -U postgres <<EOF
select * from users;
EOF

export tde_file=`grep base tde_file.log`
export tde_pgdata=`${kubectl_cmd} exec -it ${primary} -- bash -c 'echo $PGDATA'`
echo "tde_pgdata: $tde_pgdata"
echo "tde_file: $tde_file"
export tde_file=`echo $tde_file | tr -s ' '`
echo "Press ENTER to continue..."
read
tde_cmd="${kubectl_cmd} exec -it ${primary} -- bash -c 'hexdump -C /var/lib/postgresql/data/pgdata/${tde_file}'"
echo "$tde_cmd"
eval $tde_cmd
