FROM ubuntu:20.04

RUN apt update && apt install -y curl && \
    curl -sL https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh|bash

ENV V2RAY_VMESS_AEAD_FORCED=false

CMD v2ray run -config /etc/v2ray/config.json