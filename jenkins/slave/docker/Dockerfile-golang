FROM slzcc/jenkins-slave:ubuntu-jnlp

ARG GO_VERSION=1.14.4

USER root

RUN apt update && \
    apt install -y git ldap-utils libffi-dev && \
    apt install -y fonts-baekmuk ttf-baekmuk fonts-nanum language-pack-zh-hans jq telnet && \
    apt autoremove --purge -y python3 && \
    locale-gen en_US.UTF-8 && \
    rm -rf  /var/cache/apt/archives/* && \
    apt clean

RUN wget -qO- https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar zx -C /opt && \
    ln -sf /opt/go /usr/local/go && \
    mkdir /root/golang

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    GOPATH=/root/golang/ \
    GOROOT=/usr/local/go \
    GOARCH=amd64 \
    GOOS=linux \
    GOTOOLS=/usr/local/go/pkg/tool \
    GOBIN=/usr/local/go/bin \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/root/golang/bin

RUN curl -s https://glide.sh/get | sh