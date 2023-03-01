FROM centos:7.9.2009 as build

# Init System
RUN yum install -y wget git curl vim epel-release gcc zlib zlib-devel openssl-devel make libffi-devel

## install Python
RUN mkdir -p /data/install && \
    wget -qO- https://www.python.org/ftp/python/3.9.9/Python-3.9.9.tgz > /data/install/Python-3.9.9.tgz && \
    tar zxf /data/install/Python-3.9.9.tgz -C /data/install && \
    cd /data/install/Python-3.9.9 && \
    ./configure --prefix=/usr/local/python3 && \
    make -j2 && make install && \
    /usr/local/python3/bin/python3.9 -m pip install --upgrade pip


FROM centos:7.9.2009

RUN yum install -y epel-release libffi-devel iotop iftop

COPY --from=build /usr/local/python3 /usr/local/python3

COPY ps_mem.py /data/script/ps.mem.py
COPY top.sh /data/script/top.sh

ENV workdir=/data/logs/top

RUN ln -s /usr/local/python3/bin/python3 /usr/bin/python3 && \
    ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3

CMD ["/data/script/top.sh"]