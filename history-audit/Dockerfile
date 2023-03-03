FROM centos:7.9.2009

RUN yum install -y e2fsprogs

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENV HISTORY_SIZE=204800 \
    LOG_DIR=/var/log/shell_audit \
    LOG_NAME=audit.log \
    PROFILE_NAME=shell_audit.sh

CMD ["/usr/local/bin/docker-entrypoint.sh"]