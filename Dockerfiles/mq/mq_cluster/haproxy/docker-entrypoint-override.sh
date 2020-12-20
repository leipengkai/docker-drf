#!/bin/sh
set -e

# exec haproxy entry poing script
exec /docker-entrypoint.sh "$@" &

# start keepalived
exec /keepalived/start-keepalived.sh


#trap "stop; exit 0;" SIGTERM SIGINT

## handler for SIGINT & SIGITEM
#stop() {
  #echo "SIGTERM caught, terminating <haproxy & keepalived> process..."

  ## terminate haproxy
  #h_pid=$(pidof haproxy)

  #kill -TERM $h_pid > /dev/null 2>&1
  #echo "HAProxy had terminated."

  ## terminate keepalived
  #kill -TERM $(cat /var/run/vrrp.pid)
  #kill -TERM $(cat /var/run/keepalived.pid)
  #echo "Keepalived had terminated."

  #echo "haproxy-keepalived service instance is successfuly terminated!"
#}
