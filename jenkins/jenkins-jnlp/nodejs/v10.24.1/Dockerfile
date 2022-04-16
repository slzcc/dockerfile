FROM slzcc/jenkins-jnlp:ubuntu-tool-v4

ARG NODE_VERSION=v10.24.1

USER root

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    NODE_HOME=/usr/local/node \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/node/bin

RUN wget -qO- https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz | tar Jx -C /opt && \
    ln -sf /opt/node-${NODE_VERSION}-linux-x64 /usr/local/node