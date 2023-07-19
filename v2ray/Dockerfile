FROM ubuntu:20.04

COPY v2ray.sh /

RUN apt update && apt install -y wget unzip && \
    chmod +x /v2ray.sh && /v2ray.sh

ENV V2RAY_VMESS_AEAD_FORCED=false

CMD v2ray run -config /etc/v2ray/config.json