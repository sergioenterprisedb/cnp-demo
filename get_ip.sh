#!/bin/bash

#ifconfig -a|grep -E "192|172" |head -n1|awk '{print $2}'

: '
>route -n get 0.0.0.0
   route to: default
destination: default
       mask: default
    gateway: 192.168.1.1
  interface: en5
      flags: <UP,GATEWAY,DONE,STATIC,PRCLONING,GLOBAL>
 recvpipe  sendpipe  ssthresh  rtt,msec    rttvar  hopcount      mtu     expire
       0         0         0         0         0         0      1500         0

>ifconfig en5 | grep "inet "
	inet 192.168.1.37 netmask 0xffffff00 broadcast 192.168.1.255

'

dumpIpForInterface()
{
  IT=$(ifconfig "$1") 
  if [[ "$IT" != *"status: active"* ]]; then
    return
  fi
  if [[ "$IT" != *" broadcast "* ]]; then
    return
  fi
  echo "$IT" | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'
}

main()
{
  # snagged from here: https://superuser.com/a/627581/38941
  DEFAULT_ROUTE=$(route -n get 0.0.0.0 2>/dev/null | awk '/interface: / {print $2}')
  if [ -n "$DEFAULT_ROUTE" ]; then
    dumpIpForInterface "$DEFAULT_ROUTE"
  else
    for i in $(ifconfig -s | awk '{print $1}' | awk '{if(NR>1)print}')
    do 
      if [[ $i != *"vboxnet"* ]]; then
        dumpIpForInterface "$i"
      fi
    done
  fi
}

main

