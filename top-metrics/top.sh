#!/bin/bash

script_dir=/data/script
workdir=${workdir:-/data/logs/top}
IFTOP_WaitingTime=${IFTOP_WaitingTime:-100}
dt=`date +"%Y%m%d%H%M"`
 
mkdir -p ${workdir} && chmod 777 ${workdir}
 
# [ `rpm -aq | grep -c epel-release` -eq 0 ] && yum install -y epel-release
 
python3 ${script_dir}/ps_mem.py >> ${workdir}/ps_mem.out$dt
 
top -b -n2 -d5 -c >> ${workdir}/top.out$dt
# [ `rpm -aq | grep -c iotop` -eq 0 ] && yum install -y iotop
iotop -t -o --iter=1 >> ${workdir}/iotop.out$dt
 
# [ `rpm -aq | grep -c iftop` -eq 0 ] && yum install -y iftop
iftop -i $(cat /proc/net/dev | awk '{i++; if(i>2){print $1}}' | sed 's/^[t]*//g' | sed 's/[:]*$//g'|grep -E "^(ens|eth)") -N -P -t -L 50 -o 40s -s ${IFTOP_WaitingTime} > ${workdir}/iftop.out`date +"%Y%m%d%H%M"` 2>&1
#iftop -i eth0 -N -P -t -L 50 -o 40s -s 100 > ${workdir}/iftop.out`date +"%Y%m%d%H%M"` 2>&1
 
ps -auxH -wwwwwwwww >> ${workdir}/psaux.out$dt
 
gzip ${workdir}/*$dt
 
find ${workdir} -mtime +3 -type f -delete