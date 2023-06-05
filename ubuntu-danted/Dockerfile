FROM ubuntu:20.04

RUN apt update && apt install -y danted openssl && \
    rm -rf /var/lib/apt/lists/* 

COPY docker-entrypoint.sh /bin/

CMD ["/docker-entrypoint.sh"]