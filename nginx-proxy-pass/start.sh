#!/bin/sh

CONFIG=/etc/nginx/conf.d/default.conf
PROTOCOL=$(echo $TARGET |cut -f1 -d:)
SERVER=$(echo ${TARGET#*//})

/bin/sed -i "s/<target_server>/${SERVER}/" $CONFIG
/bin/sed -i "s/<target_protocol>/${PROTOCOL}/" $CONFIG

if [ ! -f "/etc/nginx/.htpasswd" ];then
  /bin/sed -i "/auth_basic*/d" $CONFIG
fi

nginx -g "daemon off;"
