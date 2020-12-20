#!/bin/bash

function replace_vars() {
  eval "cat <<EOF
$(<$2)
EOF
  " > $1
}

replace_vars '/keepalived/keepalived.conf' '/keepalived/keepalived.conf.templ'
replace_vars '/keepalived/chk_haproxy.sh' '/keepalived/chk_haproxy.sh.templ'

chmod +x /keepalived/*.sh

/usr/sbin/keepalived --dont-fork --dump-conf --log-console --log-detail --log-facility 7 --vrrp -f /keepalived/keepalived.conf

LANUCH_SCRIPT="keepalived --dont-fork --dump-conf --log-console --log-detail --log-facility 7 --vrrp -f /etc/keepalived/keepalived.conf"

eval $LANUCH_SCRIPT
while true; do
  k_pid=$(pidof keepalived)
  if [ -n "$k_id" ]; then
    break;
  fi

  kill -TERM $(cat /var/run/vrrp.pid)
  kill -TERM $(cat /var/run/keepalived.pid)
  echo "ERROR: Keepalived start failed, attempting restart ."
  eval $LANUCH_SCRIPT
done

echo "Keepalived started successfuly!"
