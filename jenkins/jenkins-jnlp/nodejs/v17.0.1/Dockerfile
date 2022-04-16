FROM slzcc/jenkins-slave:ubuntu-jnlp

ARG NODE_VERSION=v17.0.1

USER root

RUN apt update && \
    apt install -y git libffi-dev xz-utils && \
    apt install -y fonts-baekmuk ttf-baekmuk fonts-nanum language-pack-zh-hans jq telnet && \
    locale-gen en_US.UTF-8 && \
    rm -rf  /var/cache/apt/archives/* && \
    apt clean

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    NODE_HOME=/usr/local/node \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/node/bin

RUN apt autoremove --purge -y nodejs && \
    wget -qO- https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz | tar Jx -C /opt && \
    ln -sf /opt/node-${NODE_VERSION}-linux-x64 /usr/local/node && \
    npm config set registry=https://registry.npm.taobao.org && \
    #npm install -g n && \
    #n latest && \
    npm install node-gyp -g && \
    npm install -g grpc --unsafe-perm && \
    npm install -g cnpm && \
    npm install -g yarn && \
    npm install -g firebase-tools && \
    npm install -g vue-cli && \
    node-gyp install --fallback-to-build -g && \
    unset http_proxy && unset https_proxy