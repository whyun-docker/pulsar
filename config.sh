#!/bin/bash

echo "Configuration..."
. /root/util.sh

common_conf_set $PULSAR_HOME/conf/bookkeeper.conf journalDirectory /data/bookkeeper/journal