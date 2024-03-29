#!/bin/bash

if [ ${DEBUG} == 'true' ]; then
    set -x
fi

LOG_DIR=${LOG_DIR:-/data/logs/top}
IFTOP_WaitingTime=${IFTOP_WaitingTime:-100}
DSTAT_WaitingTime=${DSTAT_WaitingTime:-100}
IOTOP_WaitingTime=${IOTOP_WaitingTime:-100}
PIDSTAT_WaitingTime=${PIDSTAT_WaitingTime:-100}
VMSTAT_WaitingTime=${VMSTAT_WaitingTime:-100}
HISTORY_RESERVE=${HISTORY_RESERVE:-3}
dt=`date +"%Y%m%d%H%M"`
 
mkdir -p ${LOG_DIR} && chmod 777 ${LOG_DIR}

# Install Iftop
# [ `rpm -aq | grep -c iftop` -eq 0 ] && yum install -y iftop
## Iotop Script
iftop -i $(cat /proc/net/dev | awk '{i++; if(i>2){print $1}}' | sed 's/^[t]*//g' | sed 's/[:]*$//g'|grep -E "^(ens|eth)") -N -P -t -L 50 -o 40s -s ${IFTOP_WaitingTime} >> ${LOG_DIR}/iftop.out`date +"%Y%m%d%H%M"` 2>&1 &

# Install Epel-Release 
# [ `rpm -aq | grep -c epel-release` -eq 0 ] && yum install -y epel-release

# Install dstat
# [ `rpm -aq | grep -c dstat` -eq 0 ] && yum install -y dstat
## Dstat Script
dstat 1 ${DSTAT_WaitingTime} >> ${LOG_DIR}/dstat.out$dt &

## Ps_mem Script
## https://github.com/pixelb/ps_mem/blob/master/ps_mem.py
python3 /usr/local/bin/ps_mem.py >> ${LOG_DIR}/ps_mem.out$dt
for item in $(ps aux|awk '{print $2}'|grep -v PID);do
   echo ">>>>>>>>>>>>>>>>>>>>>> PID $item" >> ${LOG_DIR}/ps_mem.out$dt
   ps_mem.py -p $item >> ${LOG_DIR}/ps_mem.out$dt
   echo "" >> ${LOG_DIR}/ps_mem.out$dt
done

## Top Script
top -b -n2 -d5 -c -H >> ${LOG_DIR}/top.out$dt &

## PS Script
ps -auxH -wwwwwwwww >> ${LOG_DIR}/psaux.out$dt &

# Install Psmisc
# [ `rpm -aq | grep -c psmisc` -eq 0 ] && yum install -y psmisc
## Pstree Script
pstree -apnhgsu >> ${LOG_DIR}/pstree.out$dt &

# Install Netstat
# [ `rpm -aq | grep -c net-tools` -eq 0 ] && yum install -y net-tools
## Netstat Script
netstat -lnput >> ${LOG_DIR}/netstat-lnput.out$dt &
netstat -anlp >> ${LOG_DIR}/netstat-anlp.out$dt &

ifconfig >> ${LOG_DIR}/sysstat.out$dt && echo "" >> ${LOG_DIR}/sysstat.out$dt &

route >> ${LOG_DIR}/sysstat.out$dt && echo "" >> ${LOG_DIR}/sysstat.out$dt &

df -h >> ${LOG_DIR}/sysstat.out$dt && echo "" >> ${LOG_DIR}/sysstat.out$dt &

free -h >> ${LOG_DIR}/sysstat.out$dt && echo "" >> ${LOG_DIR}/sysstat.out$dt &

fdisk -l >> ${LOG_DIR}/sysstat.out$dt && echo "" >> ${LOG_DIR}/sysstat.out$dt &

lsblk >> ${LOG_DIR}/sysstat.out$dt && echo "" >> ${LOG_DIR}/sysstat.out$dt &


# Install Pstack
# [ `rpm -aq | grep -c gdb` -eq 0 ] && yum install -y gdb
# for item in $(pgrep -uroot);do
#     pstack $item
# done

# Install sysstat
# [ `rpm -aq | grep -c sysstat` -eq 0 ] && yum install -y sysstat
## Iotop sysstat
pidstat -w -u 1 ${PIDSTAT_WaitingTime} >> ${LOG_DIR}/pidstat.out$dt &

vmstat 1 ${VMSTAT_WaitingTime} >> ${LOG_DIR}/vmstat.out$dt &

# Install Iotop
# [ `rpm -aq | grep -c iotop` -eq 0 ] && yum install -y iotop
## Iotop Script
iotop -t -oP --iter=${IOTOP_WaitingTime} >> ${LOG_DIR}/iotop.out$dt

tar zcf ${LOG_DIR}/cron.$dt.tar.gz -C /var/spool cron

# Compressed Files
gzip ${LOG_DIR}/*$dt

# Delete Files Periodically
find ${LOG_DIR} -mtime +${HISTORY_RESERVE} -type f -delete