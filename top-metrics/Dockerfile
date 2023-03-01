FROM centos:7.9.2009

RUN yum install -y epel-release lib-devel openssl-devel libffi-devel python3 iotop iftop

COPY ps_mem.py /data/script/ps_mem.py
COPY top.sh /data/script/top.sh

ENV workdir=/data/logs/top

CMD ["/data/script/top.sh"]