FROM slzcc/jenkins-jnlp:ubuntu-tool-v3

ARG K8S_VERSION=v1.23.4

USER root

RUN apt update && \
    apt install -y ldap-utils libffi-dev && \
    apt install -y fonts-baekmuk fonts-nanum language-pack-zh-hans telnet && \
    locale-gen en_US.UTF-8 && \
    rm -rf  /var/cache/apt/archives/* && \
    apt clean

RUN wget -qO- "https://dl.k8s.io/${K8S_VERSION}/kubernetes-node-linux-amd64.tar.gz" | tar zx -C /opt

RUN curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/kubernetes/node/bin