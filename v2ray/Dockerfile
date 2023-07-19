FROM ubuntu:20.04

RUN bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) 

ENV V2RAY_VMESS_AEAD_FORCED=false

CMD v2ray run -config /etc/v2ray/config.json