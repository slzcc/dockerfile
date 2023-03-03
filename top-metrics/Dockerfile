FROM centos:7.9.2009

RUN yum install -y epel-release && \
    yum install -y net-tools iotop iftop dstat psmisc lib-devel openssl-devel libffi-devel python3

COPY ps_mem.py /usr/local/bin/ps_mem.py
COPY top.sh /usr/local/bin/top.sh

ENV LOG_DIR=/data/logs/top \
    IFTOP_WaitingTime=100 \
    DSTAT_WaitingTime=100 \
    HISTORY_RESERVE=3 \
    DEBUG=false

CMD ["/usr/local/bin/top.sh"]