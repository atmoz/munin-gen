#!/bin/bash

# Replace localhost with docker host
hostIp=$(/sbin/ip route|awk '/default/ { print $3 }')
sed -i "s/127.0.0.1/$hostIp/g" /etc/munin/munin.conf

# Run munin-cron at fixed intervals
interval=${MUNIN_INTERVAL:-5}
echo "*/$MUNIN_INTERVAL * * * * munin /usr/bin/munin-cron" >> /etc/crontab

# Give munin ownership of data dir
chown -R munin /var/lib/munin

# Boot it up!
exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
