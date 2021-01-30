FROM ubuntu:20.04

RUN apt update && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apt install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt install -y syslog-ng fonts-baekmuk fonts-nanum language-pack-zh-hans supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean && \
    ln -sf /dev/stdout /var/log/syslog

COPY docker-entrypoint.sh /docker-entrypoint

CMD ["/docker-entrypoint"]