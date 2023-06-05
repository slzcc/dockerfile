FROM ubuntu:20.04

RUN apt update && apt install -y dante-server openssl && \
    rm -rf /var/lib/apt/lists/* 

COPY docker-entrypoint.sh /bin/

CMD ["/docker-entrypoint.sh"]