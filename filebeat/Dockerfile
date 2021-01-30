FROM ubuntu:20.04

ARG FILEBEAT_VERSION="7.10.0"

RUN apt update && apt install -y wget gzip

RUN wget -qO- https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz | tar zx -C /opt && \
    ln -sf /opt/filebeat-${FILEBEAT_VERSION}-linux-x86_64 /usr/share/filebeat && \
    groupadd --gid 1000 filebeat && \
    useradd -M --uid 1000 --gid 1000 --groups 0 --home /usr/share/filebeat filebeat && \
    chown filebeat:filebeat -R /opt

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint

ENV ELASTIC_CONTAINER=true \
    PATH=/usr/share/filebeat:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

USER filebeat

WORKDIR /usr/share/filebeat

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

CMD ["-environment", "container"]