ifconfig -a|grep -E "192|172" |head -n1|awk '{print $2}'
