#! /bin/bash
mkdir -p /data/app/log/
mkdir -p /data/bookkeeper/journal
/data/config.sh

/etc/init.d/pulsar start

while true
do
    PID=$(cat $PULSAR_PIDFILE)
    if ps -p $PID > /dev/null
    then
        sleep 1
    else
        echo "pulsar not running"
        exit 1
    fi
done
