FROM slzcc/jenkins-jnlp:ubuntu-tool-v4

ARG K8S_VERSION=v1.23.4
ARG NODE_VERSION=v17.8.0
ARG GO_VERSION=1.14.4

USER root

RUN apt update && \
    apt install -y ldap-utils libffi-dev && \
    apt install -y fonts-baekmuk fonts-nanum language-pack-zh-hans telnet && \
    locale-gen en_US.UTF-8 && \
    rm -rf  /var/cache/apt/archives/* && \
    apt clean

RUN wget -qO- "https://dl.k8s.io/${K8S_VERSION}/kubernetes-node-linux-amd64.tar.gz" | tar zx -C /opt

RUN curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

RUN wget -qO- https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar zx -C /opt && \
    ln -sf /opt/go /usr/local/go && \
    mkdir /root/golang

RUN curl -s https://glide.sh/get | sh

RUN wget -qO- https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz | tar Jx -C /opt && \
    ln -sf /opt/node-${NODE_VERSION}-linux-x64 /usr/local/node

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    GOPATH=/root/golang/ \
    GOROOT=/usr/local/go \
    GOARCH=amd64 \
    GOOS=linux \
    GOTOOLS=/usr/local/go/pkg/tool \
    GOBIN=/usr/local/go/bin \
    NODE_HOME=/usr/local/node \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/root/golang/bin:/opt/kubernetes/node/bin:/usr/local/node/bin