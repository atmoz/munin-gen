#!/bin/bash

# Replace localhost with docker host
hostIp=$(/sbin/ip route|awk '/default/ { print $3 }')
sed -i "s/127.0.0.1/$hostIp/g" /etc/munin/munin.conf

# Boot it up!
exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
