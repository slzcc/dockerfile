#!/bin/bash

LOG_DIR=${LOG_DIR:-/data/logs/top}
IFTOP_WaitingTime=${IFTOP_WaitingTime:-100}
HISTORY_RESERVE=${HISTORY_RESERVE:-3}
dt=`date +"%Y%m%d%H%M"`
 
# mkdir -p ${LOG_DIR} && chmod 777 ${LOG_DIR}
 
# [ `rpm -aq | grep -c epel-release` -eq 0 ] && yum install -y epel-release
 
python3 /usr/local/bin/ps_mem.py >> ${LOG_DIR}/ps_mem.out$dt
 
top -b -n2 -d5 -c >> ${LOG_DIR}/top.out$dt
# [ `rpm -aq | grep -c iotop` -eq 0 ] && yum install -y iotop
iotop -t -o --iter=1 >> ${LOG_DIR}/iotop.out$dt
 
# [ `rpm -aq | grep -c iftop` -eq 0 ] && yum install -y iftop
iftop -i $(cat /proc/net/dev | awk '{i++; if(i>2){print $1}}' | sed 's/^[t]*//g' | sed 's/[:]*$//g'|grep -E "^(ens|eth)") -N -P -t -L 50 -o 40s -s ${IFTOP_WaitingTime} > ${LOG_DIR}/iftop.out`date +"%Y%m%d%H%M"` 2>&1
#iftop -i eth0 -N -P -t -L 50 -o 40s -s 100 > ${LOG_DIR}/iftop.out`date +"%Y%m%d%H%M"` 2>&1
 
ps -auxH -wwwwwwwww >> ${LOG_DIR}/psaux.out$dt
 
gzip ${LOG_DIR}/*$dt
 
find ${LOG_DIR} -mtime +${HISTORY_RESERVE} -type f -delete